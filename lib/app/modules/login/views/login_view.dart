import 'package:absensi/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        // Ganti ListView dengan SingleChildScrollView untuk mengatasi masalah overflow saat keyboard muncul.
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            TextField(
              autocorrect: false,
              controller: controller.emailC,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                icon: Icon(Icons.person), // Tambahkan ikon
              ),
            ),
            SizedBox(height: 20),
            TextField(
              autocorrect: false,
              controller: controller.passwordC,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                icon: Icon(Icons.lock), // Tambahkan ikon
              ),
            ),
            SizedBox(height: 30),
            Obx(
              () => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    await controller.Login();
                  }
                },
                child:
                    Text(controller.isLoading.isTrue ? "Loading..." : "Login"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(12),
                ),
              ),
            ),
            TextButton(
              onPressed: () =>Get.toNamed(Routes.FORGOT_PASSWORD),
              child: Text("Lupa Password"),
            ),
          ],
        ),
      ),
    );
  }
}
