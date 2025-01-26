
## Queueing Simulator
This repository contains the implementation of the Queueing Simulator developed for CS 442: Machine Problem 1. The simulator models a queueing system with various deterministic and stochastic processes, calculates event wait times, and provides detailed performance statistics. The project meets all requirements specified in the instructions and demonstrates modular, clean, and efficient Dart code.
## Project Overview
A queuing system manages requests for a resource and tracks event wait times for performance evaluation. This simulator models and evaluates such systems by generating events from multiple processes (singleton, periodic, and stochastic) based on a YAML configuration file. Key statistics like total wait times, average wait times, and per-process metrics are computed and displayed.

#### Example Use Cases:

Modeling grocery checkout queues. Analyzing event-driven software systems. Evaluating network or CPU scheduling.
## Features

- Singleton Process: Simulates a single event with a fixed arrival time and duration.
- Periodic Process: Models repetitive events with fixed intervals and durations.
- Stochastic Process: Generates events with durations and arrival times based on exponential distributions.
- Detailed Simulation Trace: Outputs a timeline of events with wait times and start times.
- Per-Process Statistics: Calculates the number of events, total wait times, and average wait times for each process.
- Summary Statistics: Aggregates results across all processes to show total and average wait times.
- Verbose Mode: Optional detailed logging for debugging.



## Technologies Used
- Programming Language: Dart
- YAML Parsing: yaml package for configuration files.
- Command Line Argument Handling: args package for input parsing.
- Exponential Distribution: Utilized the ExpDistribution class for generating random samples.

## How It Works
1. Input Configuration:
    - Processes are defined in a YAML configuration file specifying process types, durations, arrival times, and repetitions.
2. Event Generation:
    - Each process generates a queue of events based on its configuration.
    - Singleton, periodic, and stochastic processes are handled with appropriate logic.
3. Simulation Execution:
    - Events are processed in order of arrival.
    - Wait times are calculated based on queue states at event arrival.
    - The simulation records when events are serviced and calculates statistics.
4. Output Generation:
    - A detailed simulation trace logs event start and wait times.
    - Per-process and summary statistics are computed and displayed.


## Configuration
Example Configuration File (YAML)

``` yaml
Computation:
  type: singleton
  duration: 50
  arrival: 10

Timer interrupt:
  type: periodic
  duration: 10
  interarrival-time: 25
  first-arrival: 0
  num-repetitions: 3

I/O request:
  type: stochastic
  mean-duration: 10
  mean-interarrival-time: 25
  first-arrival: 5
  end: 150

```


## Running Tests

To run tests, run the following command

1. Clone the Repository
```bash
git clone https://github.com/ApurvGaikwad0/Dart-Simulator.git
cd QueueingSimulator
```
2. Run the Simulator:
```bash
dart run bin/main.dart -c <path/to/config.yaml>
``` 
3. Verbose Mode: Add the -v flag for detailed output:
```bash
dart run bin/main.dart -c <path/to/config.yaml> -v
```
4. Example Command:
```bash
dart run bin/main.dart -c conf/sim1.yaml
``` 


## Sample Output

#### Simulation Trace
```plaintext
t=0: Timer interrupt, duration 10 started (arrived @ 0, no wait)
t=10: I/O request, duration 18 started (arrived @ 5, waited 5)
t=28: Computation, duration 50 started (arrived @ 10, waited 18)
t=78: Timer interrupt, duration 10 started (arrived @ 25, waited 53)
``` 
#### Per-Process Statistics
```yaml
Computation:
  Events generated:  1
  Total wait time:   18
  Average wait time: 18.0

Timer interrupt:
  Events generated:  3
  Total wait time:   113
  Average wait time: 37.67
  ```
#### Summary Statistics
```yaml
Total num events:  8
Total wait time:   199.0
Average wait time: 24.875
```




## Folder Structure 
```bash
QueueingSimulator/
│
├── bin/                    # Entry point for the simulator
├── conf/                   # YAML configuration files
├── lib/                    # Core classes and utilities
│   ├── simulation.dart     # Simulation logic
│   ├── process.dart        # Process class and subclasses
│   ├── event.dart          # Event class
│   └── util/               # Utility functions and classes
├── test/                   # Unit tests for the project
├── REPORT.md               # Project report
├── pubspec.yaml            # Dart package dependencies
└── README.md               # Project documentation
```
## Key Learnings
- Implementing modular and reusable code structures in Dart.
- Parsing and handling YAML configuration files efficiently.
- Simulating stochastic and deterministic processes in queueing systems.
- Analyzing performance metrics for real-world applications.
