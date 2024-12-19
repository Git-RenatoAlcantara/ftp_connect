import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dartssh2/dartssh2.dart';
import 'package:ftp_connect/util/listItemRemove.dart';
import '../service/file_picker.dart';
import 'package:path/path.dart' as p;

class FtpProvider extends ChangeNotifier {
  SSHClient? client;
  List<String> currentFilesDir = [];
  String fileToUpload = '';
  List<String> dir = [];
  int? selectedDir;

  Future<void> connect({ip, user, pass, port = 22}) async {
    final socket = await SSHSocket.connect(ip, port);
    try {
      client = SSHClient(
        socket,
        username: user,
        onPasswordRequest: () => pass,
      );

      await listFTP();
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  Future<void> listFTP([String path = '']) async {
    print('$path - $dir');
    if (path.isEmpty) {
      dir.add('/');
    }

    if (path.isNotEmpty) {
      if (dir.contains('/')) {
        dir.clear();
      }

      dir.add('/$path');
    }

    if (!dir.contains('/') && path == '..') {
      dir.removeLast();
    }

    if (client != null) {
      currentFilesDir.clear();
      final sftp = await client!.sftp();
      final items = await sftp.listdir(dir.join());
      for (final item in items) {
        await isFile(item.filename)
            ? currentFilesDir.add(item.filename)
            : currentFilesDir.add('/${item.filename}');
      }
    }

    currentFilesDir = listItemRemove(currentFilesDir);

    currentFilesDir.insert(0, '..');

    notifyListeners();
    /*
    if (path.isEmpty && dir.isEmpty) {
      dir.add('/');
    }
    if (dir.length > 1 && path == '..') {
      dir.removeLast();
    }

    if (path.isNotEmpty && dir.isNotEmpty && path != '..') {
      dir.add('/$path');
    }

    if (client != null) {
      currentFilesDir.clear();
      final sftp = await client!.sftp();
      final items = await sftp.listdir(dir.join());
      for (final item in items) {
        if (dir.isEmpty || item.filename.isEmpty) {
          return;
        }
        final stat = await sftp.stat('${dir.join()}/${item.filename}');

        if (stat.isDirectory) {
          currentFilesDir.add('/${item.filename}');
        } else {
          currentFilesDir.add(item.filename);
        }
      }

      currentFilesDir = listItemRemove(currentFilesDir);

      currentFilesDir.insert(0, '..');
      notifyListeners();
    }
    */
  }

  Future<void> uploadFile(String upload) async {
    var formatPath = upload.toString().trim();
    var name = p.basename(formatPath);

    if (client != null) {
      final sftp = await client!.sftp();
      name = name.toString().trim();
      final file = await sftp.open('/root/$name',
          mode: SftpFileOpenMode.create | SftpFileOpenMode.write);

      await file.write(File(formatPath).openRead().cast());
    }
  }

  Future<void> openFile() async {
    fileToUpload = await FilePicker().pickFile();
    notifyListeners();
  }

  setDir(String currentDir) async {
    dir.add('$currentDir/');
    notifyListeners();
  }

  void setSelectedDir(int index) {
    selectedDir = index;
    notifyListeners();
  }

  Future<bool> isFile(String path) async {
    final sftp = await client!.sftp();
    final stat = await sftp.stat('${dir.join()}/$path');
    print(stat.isFile);
    return stat.isFile;
  }
}
