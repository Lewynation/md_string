import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';

import 'lib/commands/stringify/stringify_command.dart';

const String version = '0.0.1';

void main(List<String> arguments) async {
  try {
    var runner = CommandRunner(
      'mdstring',
      "Converts markdown to string",
    )..addCommand(
        StringifyCommand(),
      );
    runner.argParser.addFlag(
      'version',
      negatable: false,
      help: 'Print the version',
    );
    runner.argParser.addFlag(
      abbr: 'v',
      'verbose',
      defaultsTo: false,
      negatable: false,
      help: 'increase logging',
    );
    final ArgResults results = runner.parse(arguments);
    if (results.wasParsed('version')) {
      print('md_string version: $version');
      return;
    }
    await runner.run(arguments);
    stdout.write('Press Enter to exit...');
    stdin.readLineSync();
  } on FormatException catch (e) {
    print(e.message);
  }
}
