import 'package:absensi/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/all_presensi_controller.dart';

class AllPresensiView extends GetView<AllPresensiController> {
  const AllPresensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Presensi'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 14, left: 14, right: 14, bottom: 6),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 8,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  label: Text("Cari"),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: controller.streamAllPresence(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data?.docs.length == 0) {
                    return SizedBox(
                        height: 150,
                        child:
                            Center(child: Text("Belum ada history presence")));
                  }
                  return ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data =
                            snapshot.data!.docs[index].data();
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Material(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_PRESENSI,
                                    arguments: data);
                              },
                              child: Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Masuk",
                                            style: TextStyle(fontSize: 20)),
                                        Text(
                                          "${DateFormat.yMMMEd().format(DateTime.parse(data['date']))}",
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      data['masuk']?['date'] == null
                                          ? "-"
                                          : "${DateFormat.jms().format(DateTime.parse(data['masuk']?['date']))}",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(height: 10),
                                    Text("Keluar",
                                        style: TextStyle(fontSize: 20)),
                                    Text(
                                      data['keluar'] != null
                                          ? "${DateFormat.jms().format(DateTime.parse(data['keluar']['date']))}"
                                          : "-",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }
}
