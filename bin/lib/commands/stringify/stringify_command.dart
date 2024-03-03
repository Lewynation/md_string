import 'package:args/command_runner.dart';

import 'arg_parser.dart';
import 'md/markdown_stringify.dart';

class StringifyCommand extends Command {
  @override
  String get name => 'stringify';

  @override
  String get description => 'Converts the mentioned supported file to string';

  StringifyCommand() {
    buildStringifyArgParser(argParser);
    addSubcommand(StringifyMarkDownCommand());
  }

  @override
  void run() {
    print('stringify');
    // final size = int.parse(argResults?['size'] as String? ?? '20');
    // final char = (globalResults?['char'] as String?)?[0] ?? '#';
  }
}
