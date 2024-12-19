import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ftp_connect/provider/ftp_provider.dart';
import 'package:ftp_connect/provider/local_provider.dart';
import 'package:ftp_connect/service/path_provider.dart';
import 'package:ftp_connect/widget/distant_widget.dart';
import 'package:ftp_connect/widget/local_widget.dart';
import 'package:ftp_connect/widget/remote_widget.dart';
import 'package:ftp_connect/widget/ssh_connection_fields.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    fetchLocalDirectories();
    super.initState();
  }

  void fetchLocalDirectories() {
    Provider.of<LocalProvider>(context, listen: false).listLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              children: [
                const SSHConnectionFields(),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .6,
                    padding: const EdgeInsets.all(8.0),
                    child: const Row(
                      children: [
                        LocalWidget(),
                        SizedBox(
                          width: 8.0,
                        ),
                        RemoteWidget()
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
