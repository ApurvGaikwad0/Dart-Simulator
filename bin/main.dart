import 'dart:io';
import 'package:args/args.dart';
import 'package:yaml/yaml.dart';
import 'package:queueing_simulator/simulator.dart';

void main(List<String> args) {
  // Configure command line argument parser and parse the arguments
  final parser = ArgParser()
    ..addOption('conf', abbr: 'c', help: 'Config file path')
    ..addFlag('verbose', abbr: 'v', defaultsTo: false, negatable: false, help: 'Print verbose output');
  final results = parser.parse(args);

  // Print help message if the user omitted the config file path
  if (!results.wasParsed('conf')) {
    print('Usage:');
    print(parser.usage);
    exit(0);
  }

  // Get the verbose flag and config file path
  final verbose = results['verbose'] as bool;
  final configPath = results['conf'] as String;
  final file = File(configPath);

  if (!file.existsSync()) {
    print('Config file not found: $configPath');
    exit(1);
  }

  try {
    // Load the config file
    final yamlString = file.readAsStringSync();
    final yamlData = loadYaml(yamlString);

    // Create a simulator, run it, and print the report
    final simulator = Simulator(yamlData, detailedOutput: verbose);
    simulator.run();
    simulator.printReport();
  } catch (e) {
    print('Error during simulation: $e');
    exit(1);
  }
}
