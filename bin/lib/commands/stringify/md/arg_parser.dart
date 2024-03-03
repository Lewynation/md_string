import 'package:args/args.dart';

ArgParser buildMdStringifyArgParser(ArgParser argParser) {
  return argParser
    ..addOption(
      'file',
      abbr: 'f',
      help: 'The input file to convert',
      valueHelp: 'path',
      mandatory: false,
    )
    ..addOption(
      'directory',
      abbr: 'd',
      help: 'The input directory to convert',
      valueHelp: 'path',
      mandatory: false,
    )
    ..addOption(
      'output',
      abbr: 'o',
      help: 'The output directory to write the files to',
      valueHelp: 'path',
      mandatory: false,
    );
}
