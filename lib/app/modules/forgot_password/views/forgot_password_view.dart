import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            _buildEmailTextField(),
            SizedBox(height: 30),
            _buildResetPasswordButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextField(
      autocorrect: false,
      controller: controller.emailC,
      decoration: InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
        icon: Icon(Icons.person),
      ),
    );
  }

  Widget _buildResetPasswordButton() {
    return Obx(
      () => ElevatedButton(
        onPressed: controller.isLoading.isFalse ? controller.sendEmail : null,
        child: Text(
          controller.isLoading.isTrue ? 'Loading...' : 'Send Reset Password Link',
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(12),
        ),
      ),
    );
  }
}
