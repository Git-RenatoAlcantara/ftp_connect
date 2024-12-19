import 'dart:io';

class FilePicker {
  Future<String> pickFile([String extension = '']) async {
    return await Process.run(
            'zenity',
            [
              '--file-selection',
            ],
            runInShell: true)
        .then((pr) {
      if (pr.exitCode != 0) {
        return '';
      }

      return pr.stdout.toString();
    });
  }
}
