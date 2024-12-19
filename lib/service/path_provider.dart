import 'dart:io';

class PathProvider {
  Future<List<String>> dir() async {
    ProcessResult result = await Process.run('ls', []);
    var directories = result.stdout;
    List<String> listDirectories = directories.toString().split('\n');
    return listDirectories;
  }
}
