import 'package:flutter/material.dart';
import 'package:ftp_connect/provider/ftp_provider.dart';
import 'package:provider/provider.dart';

class RemoteWidget extends StatelessWidget {
  const RemoteWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int? selected;

    return Expanded(
      child: Container(
        child: Consumer<FtpProvider>(builder: (context, user, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(1, 1), // changes position of shadow
                    ),
                  ],
                ),
                width: double.infinity,
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
                          width: 10.0,
                        ),
                        Text(user.dir.join())
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
              Expanded(
                flex: 1,
                child: ListView.builder(
                    itemCount: user.currentFilesDir.length,
                    itemBuilder: (context, index) => Container(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 2, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: user.selectedDir == index
                                ? Colors.blue
                                : index % 2 == 0
                                    ? Colors.grey[200]
                                    : Colors.white,
                          ),
                          child: InkWell(
                            onTap: () {
                              Provider.of<FtpProvider>(context, listen: false)
                                  .setSelectedDir(index);
                            },
                            onDoubleTap: () => {
                              user.listFTP(user.currentFilesDir[index]
                                  .replaceAll('/', ''))
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    user.currentFilesDir[index],
                                    style: TextStyle(
                                        color: user.selectedDir == index
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Provider.of<FtpProvider>(context).isFile(
                                          user.currentFilesDir[index]
                                              .replaceAll('/', ''));
                                    },
                                    icon: const Icon(Icons.upload))
                              ],
                            ),
                          ),
                        )),
              )
            ],
          );
        }),
      ),
    );
  }
}
