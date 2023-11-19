import 'package:flutter/material.dart';

import '../services/api.dart';
import '../utils/constants/color_constant.dart';

class Notificaiton extends StatefulWidget {
  const Notificaiton({super.key});

  @override
  State<Notificaiton> createState() => _NotificaitonState();
}

class _NotificaitonState extends State<Notificaiton> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử hòm thư'),
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstant.primaryColor,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future(() {
            setState(() {});
          });
        },
        child: FutureBuilder(
          future: Api.fetchNotify(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          //String boxId = snapshot.data![index]['BoxId'];
                          String body =
                          snapshot.data![index]["messageBody"].toString();
                          String title =
                          snapshot.data![index]["messageTitle"].toString();

                          String date =
                          snapshot.data![index]["sendDate"].toString();
                          return SizedBox(
                            height: size.height * 0.10,
                            child: Card(
                              child: ListTile(
                                leading: Container(
                                  width: 5,
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                  ),
                                ),
                                title: Text(
                                    title
                                  // 'Số tủ: $boxName',
                                ),
                                subtitle: Text(
                                      'Ngày tạo: $date\n'
                                      'Thông báo: $body',
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );

              default:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ),
      ),
    );
  }
}
