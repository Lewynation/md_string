import 'package:args/command_runner.dart';

import 'arg_parser.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

class StringifyMarkDownCommand extends Command {
  @override
  String get name => 'md';

  @override
  String get description => 'Converts markdown to string';

  StringifyMarkDownCommand() {
    buildMdStringifyArgParser(argParser);
  }

  @override
  void run() {
    final inputFile = argResults?['file'] as String?;
    final inputFolder = argResults?['directory'] as String?;
    final outputFolder = argResults?['output'] as String?;

    if (inputFile == null && inputFolder == null) {
      stdout.writeln('❌❌ Input file or directory not found');
      return;
    }
    if (inputFile != null && inputFolder != null) {
      stdout.writeln('❌❌ Input file and directory both found');
      return;
    }
    try {
      if (inputFile != null) {
        final inputFileBaseName = p.basenameWithoutExtension(inputFile);
        if (!File(inputFile).existsSync()) {
          print('❌❌ $inputFile - Input file not found');
          return;
        }
        final outputDirectory = Directory(_getOutputDirectory(outputFolder));
        _convertFile(
          inputFile: inputFile,
          outputFileName: inputFileBaseName,
          outputFolder: outputDirectory.path,
        );
      } else if (inputFolder != null) {
        final inputDirectory = Directory(inputFolder);

        if (!inputDirectory.existsSync()) {
          print('❌❌ ${inputDirectory.path} - Input directory not found');
          return;
        }
        final outputDirectory = Directory(_getOutputDirectory(outputFolder));
        final files = inputDirectory.listSync();
        print("\n\n🚀🚀 Converting .md files");
        print("__________________________\n");
        for (var file in files) {
          if (file is File) {
            final baseName = p.basenameWithoutExtension(file.path);
            _convertFile(
              inputFile: file.path,
              outputFileName: baseName,
              outputFolder: outputDirectory.path,
            );
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void _convertFile({
    required String inputFile,
    required String outputFileName,
    required String outputFolder,
  }) {
    final file = File(inputFile);
    final fileExtension = p.extension(file.path);
    if (fileExtension != '.md') {
      print('❌❌ ${file.path} is not a markdown file');
      return;
    }
    print('✅✅ ${file.path} converted successfully');
    final content = file.readAsStringSync();
    final removeNewLine = content.replaceAll('\n', '\\n');
    final output = File(p.join(outputFolder, '$outputFileName.txt'));
    output.writeAsStringSync(removeNewLine);
  }

  String _getOutputDirectory(String? outputFolder) {
    final currentRootDirectory = Directory.current.path;
    final outputDirectory = Directory(
      outputFolder ?? p.join(currentRootDirectory, 'out'),
    );
    if (!outputDirectory.existsSync()) {
      outputDirectory.createSync(recursive: true);
    } else {
      outputDirectory.deleteSync(recursive: true);
      outputDirectory.createSync(recursive: true);
    }
    return outputDirectory.path;
  }
}
