import 'dart:math';
import 'package:yaml/yaml.dart';

class Event {
  final String sourceName;
  final int startTime;
  final int length;
  int pendingTime = 0;

  Event(this.sourceName, this.startTime, this.length);
}

abstract class Process {
  final String processLabel;
  Process(this.processLabel);
  List<Event> createEvents();
}

class SingleEventProcess extends Process {
  final int eventStart;
  final int eventDuration;

  SingleEventProcess(String processLabel, this.eventStart, this.eventDuration)
      : super(processLabel);

  @override
  List<Event> createEvents() {
    return [Event(processLabel, eventStart, eventDuration)];
  }
}

class RecurringProcess extends Process {
  final int firstEventTime;
  final int intervalTime;
  final int eventDuration;
  final int repeatCount;

  RecurringProcess(String processLabel, this.firstEventTime, this.intervalTime,
      this.repeatCount, this.eventDuration)
      : super(processLabel);

  @override
  List<Event> createEvents() {
    List<Event> events = [];
    for (int i = 0; i < repeatCount; i++) {
      int scheduledTime = firstEventTime + i * intervalTime;
      events.add(Event(processLabel, scheduledTime, eventDuration));
    }
    return events;
  }
}

class RandomProcess extends Process {
  final int initialTime;
  final int averageDuration;
  final int averageInterval;
  final int cutoffTime;

  RandomProcess(String processLabel, this.initialTime, this.averageDuration,
      this.averageInterval, this.cutoffTime)
      : super(processLabel);

  @override
  List<Event> createEvents() {
    List<Event> events = [];
    ExpDistribution durationDist =
        ExpDistribution(mean: averageDuration.toDouble());
    ExpDistribution intervalDist =
        ExpDistribution(mean: averageInterval.toDouble());

    int currentTime = initialTime;
    while (currentTime < cutoffTime) {
      int duration = durationDist.next().toInt();
      events.add(Event(processLabel, currentTime, duration));
      currentTime += intervalDist.next().toInt();
    }
    return events;
  }
}

class ExpDistribution {
  final double rate;
  final Random rng;

  ExpDistribution({double? mean, double? rate, int seed = 0})
      : assert(mean != null || rate != null, 'You must provide mean or rate'),
        rate = rate ?? 1 / (mean ?? 1),
        rng = Random(seed);

  double next() {
    return -1 / rate * log(1 - rng.nextDouble());
  }
}

class Simulator {
  List<int> eventWaitTimes = [];
  int totalWaitTime = 0;
  final bool detailedOutput;
  final List<Event> eventQueue = [];

  Simulator(YamlMap configData, {this.detailedOutput = false}) {
    for (final processName in configData.keys) {
      final processFields = configData[processName];
      Process process;

      switch (processFields['type']) {
        case 'singleton':
          process = SingleEventProcess(
              processName, processFields['arrival'], processFields['duration']);
          break;
        case 'periodic':
          process = RecurringProcess(
              processName,
              processFields['first-arrival'],
              processFields['interarrival-time'],
              processFields['num-repetitions'],
              processFields['duration']);
          break;
        case 'stochastic':
          process = RandomProcess(
              processName,
              processFields['first-arrival'],
              processFields['mean-duration'],
              processFields['mean-interarrival-time'],
              processFields['end']);
          break;
        default:
          throw ArgumentError('Unknown process type: ${processFields['type']}');
      }
      eventQueue.addAll(process.createEvents());
    }

    eventQueue.sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  void run() {
    int currentTime = 0;

    for (final event in eventQueue) {
      if (currentTime < event.startTime) {
        currentTime = event.startTime;
      }

      int waitTime = currentTime - event.startTime;
      waitTime = waitTime > 0 ? waitTime : 0;

      event.pendingTime = waitTime;
      eventWaitTimes.add(waitTime);
      totalWaitTime += waitTime;

      if (detailedOutput) {
        print('Processed ${event.sourceName} at $currentTime with wait $waitTime');
      }

      currentTime += event.length;
    }
  }

  void printReport() {
    double averageWait =
        eventWaitTimes.isNotEmpty ? totalWaitTime / eventWaitTimes.length : 0.0;

    print('\n# Simulation Report');
    for (var event in eventQueue) {
      print(
          'Process: ${event.sourceName}, Arrival: ${event.startTime}, Duration: ${event.length}, Wait Time: ${event.pendingTime}');
    }

    print('\n# Summary Statistics');
    print('Total events: ${eventWaitTimes.length}');
    print('Total wait time: $totalWaitTime');
    print('Average wait time: ${averageWait.toStringAsFixed(2)}');
  }
}
