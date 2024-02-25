import 'package:args/args.dart';

class CLIArguments {
  late String backendIP;

  CLIArguments(List<String> args) {
    final ArgParser argParser = ArgParser()
      ..addOption('ip', abbr: 'i', defaultsTo: 'localhost:8080');

    final ArgResults results = argParser.parse(args);
    backendIP = results['ip']!;
  }
}
