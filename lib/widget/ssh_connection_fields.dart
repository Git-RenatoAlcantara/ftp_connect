import 'package:flutter/material.dart';
import 'package:ftp_connect/provider/ftp_provider.dart';
import 'package:provider/provider.dart';

class SSHConnectionFields extends StatefulWidget {
  const SSHConnectionFields({super.key});

  @override
  State<SSHConnectionFields> createState() => _SSHConnectionFieldsState();
}

class _SSHConnectionFieldsState extends State<SSHConnectionFields> {
  final TextEditingController _inputHost = TextEditingController();
  final TextEditingController _inputUser = TextEditingController();
  final TextEditingController _inputPassword = TextEditingController();
  final TextEditingController _inputPort = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 50,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              child: Card(
                elevation: .5,
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: TextField(
                    controller: _inputHost,
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Host',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 30.0,
            ),
            SizedBox(
              width: 250,
              child: Card(
                elevation: .5,
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: TextField(
                    controller: _inputUser,
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'User',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 30.0,
            ),
            SizedBox(
              width: 250,
              child: Card(
                elevation: .5,
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: TextField(
                    controller: _inputPassword,
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 30.0,
            ),
            SizedBox(
              width: 120,
              child: Card(
                elevation: .5,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: _inputPort,
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Port',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 30.0,
            ),
            ElevatedButton(
                onPressed: () {
                  Provider.of<FtpProvider>(context, listen: false).connect(
                      ip: _inputHost.text,
                      user: _inputUser.text,
                      pass: _inputPassword.text);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Consumer<FtpProvider>(
                    builder: (context, value, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Badge(
                          backgroundColor:
                              value.client == null ? Colors.red : Colors.green,
                          textColor: Colors.green,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(value.client == null ? 'Cennect' : 'Disconect', style: const TextStyle(fontWeight: FontWeight.w600),),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
