import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  final Map<String, dynamic> user = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.nimC.text = user['nim'];
    controller.namaC.text = user['nama'];
    controller.emailC.text = user['email'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.account_box_outlined),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      autocorrect: false,
                      controller: controller.nimC,
                      decoration: InputDecoration(
                        labelText: "NIM",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.email),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      autocorrect: false,
                      controller: controller.emailC,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      autocorrect: false,
                      controller: controller.namaC,
                      decoration: InputDecoration(
                        labelText: "Nama",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10), // Adjust the spacing as needed
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GetBuilder<UpdateProfileController>(
                        builder: (c) {
                          if (c.image != null) {
                            return ClipOval(
                              child: Container(
                                width: 120,
                                height: 120,
                                child: Image.file(
                                  File(c.image!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          } else {
                            if (user["urlphoto"] != null) {
                              return Column(
                                children: [
                                  ClipOval(
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      child: Image.network(
                                        user['urlphoto'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      controller.deleteProfile(user['uid']);
                                    }, 
                                    child: Text("Delete"),
                                    
                                  ),
                                ],
                              );
                            } else {
                              return ClipOval(
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  child: Image.network(
                                    "https://ui-avatars.com/api/?name=${user['nama']}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }
                          }
                        },
                      ),
                      TextButton(
                        onPressed: () async {
                          controller.pickImage();
                        },
                        child: Text("Choose Photo"),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => ElevatedButton(
                          onPressed: () async {
                            if (controller.isLoading.isFalse) {
                              await controller.updateProfile(user['uid']);
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add, size: 15),
                              SizedBox(width: 10),
                              Text(controller.isLoading.isFalse
                                  ? "Update Profile"
                                  : "Loading..."),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
