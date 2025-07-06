import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../company_login/presntation/controller/company_login_controller.dart';
import '../../../trip/presntation/model/trip_model.dart';

class TripListController extends GetxController {
  List<Trip> tripList = [];
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void onInit() {
    final companyId = Get.find<CompanyLoginController>().loggedInCompanyId;
    if (companyId != null) {
      fetchTripsForCompany(companyId);
    } else {
      print("⚠️ companyId is null");
    }
    super.onInit();
  }

  Future<void> fetchTripsForCompany(String companyId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('trips')
        .where('companyId', isEqualTo: companyId)
        .get();

    tripList = snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return Trip.fromMap(data);
    }).toList();

    update(); // notify UI
  }

  void updateSearchQuery(String value) {
    searchQuery = value;
    update();
  }
}
