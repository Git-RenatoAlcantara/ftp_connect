import 'package:flutter/material.dart';
import 'package:ftp_connect/provider/ftp_provider.dart';
import 'package:ftp_connect/service/path_provider.dart';
import 'package:provider/provider.dart';

class DistantWidget extends StatelessWidget {
  const DistantWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: .4,
        child: Consumer<FtpProvider>(builder: (context, user, child) {
          return Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Remoto:',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Text(user.dir.join()),
                      ],
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 500,
                child: ListView.builder(
                    itemCount: user.currentFilesDir.length,
                    itemBuilder: (context, index) => Container(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 2, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: index % 2 == 0
                                ? Colors.grey[200]
                                : Colors.white,
                          ),
                          child: InkWell(
                            onTap: () {
                              PathProvider().dir();
                            },
                            onDoubleTap: () =>
                                {user.listFTP(user.currentFilesDir[index])},
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(user.currentFilesDir[index]),
                            ),
                          ),
                        )),
              ),
            ],
          );
        }));
  }
}
