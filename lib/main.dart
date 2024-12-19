import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:ftp_connect/provider/ftp_provider.dart';
import 'package:ftp_connect/provider/local_provider.dart';
import 'package:ftp_connect/screens/main_screen.dart';
import 'package:ftp_connect/widget/left_widget.dart';
import 'package:ftp_connect/widget/right_widget.dart';
import 'package:ftp_connect/widget/windows_widget.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
  doWhenWindowReady(() {
    const initialSize = Size(1280, 720);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = "FTP Connect";
    appWindow.show();
  });
}

const backgroundStartColor = Color(0xFFFFFFFF);
const backgroundEndColor = Color(0xFFFFFFFF);
const borderColor = Color(0xFF805306);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FtpProvider()),
        ChangeNotifierProvider(create: (context) => LocalProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: WindowBorder(
          color: borderColor,
          width: 1,
          child: const Row(
            children: [RightSide()],
          ),
        ),
      ),
    );
  }
}
