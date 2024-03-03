import 'package:args/args.dart';

ArgParser buildStringifyArgParser(ArgParser argParser) {
  return argParser
    ..addOption(
      'input',
      abbr: 'i',
      help: 'The input file to convert',
      valueHelp: 'path/to/file.md',
    )
    ..addOption(
      'output',
      abbr: 'o',
      help: 'The output file to write',
      valueHelp: 'path/to/file.txt',
    );
}
