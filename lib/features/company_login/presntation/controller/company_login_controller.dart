import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/routes.dart';

class CompanyLoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  var isLoading = false.obs;
  String? loggedInCompanyId;

  Future<void> loginCompany() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Username and password are required");
      return;
    }

    isLoading.value = true;

    try {
      final result = await FirebaseFirestore.instance
          .collection('companies')
          .where('username', isEqualTo: username)
          .where('password', isEqualTo: password)
          .get();

      if (result.docs.isNotEmpty) {
        loggedInCompanyId = result.docs.first.id;
        Get.toNamed(Routes.homeView);

      } else {
        Get.snackbar("Login Failed", "Invalid credentials");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
