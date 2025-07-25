import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/storage/local/database/shared_preferences/app_settings_shared_preferences.dart';
import '../model/trip_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class TripController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final formKey = GlobalKey<FormState>();
  final fromController = TextEditingController();
  final toController = TextEditingController();
  final dateController = TextEditingController();
  final timeLeaveController = TextEditingController();
  final timeArriveController = TextEditingController();
  final seatsController = TextEditingController();
  final priceController = TextEditingController();
  final notesController = TextEditingController();
  final isLoading = false.obs;

  AppSettingsSharedPreferences appSettingsSharedPreferences = AppSettingsSharedPreferences();
  RxInt seatCount = 0.obs;
  var isMale = true.obs;
  var pageSelectedIndex = 2.obs;
  var currentPageIndex = 0.obs;

  void incrementSeats() {
    seatCount++;
    seatsController.text = seatCount.value.toString();
    update();
  }

  void decrementSeats() {
    if (seatCount > 0) seatCount--;
    seatsController.text = seatCount.value.toString();
    update();
  }

  void changeMale(int index) {
    isMale.value = index == 0;
  }

  void onPageChanged(int index) {
    currentPageIndex.value = index;
  }

  @override
  void onClose() {
    fromController.dispose();
    toController.dispose();
    dateController.dispose();
    timeLeaveController.dispose();
    timeArriveController.dispose();
    seatsController.dispose();
    priceController.dispose();
    notesController.dispose();
    super.onClose();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      locale: const Locale('ar', ''), // للتقويم بالعربية
    );
    if (picked != null) {
      dateController.text = '${picked.day}-${picked.month}-${picked.year}';
      update();
    }
  }

  /// Add a trip with auto-incremented `tripId`, signed-in company ID, and Firestore doc ID.
  Future<void> addTrip(String companyId) async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      // Get the current trip count for this company
      int tripCount = await getCompanyTripCount(companyId);
      String tripNumber = 'SY' + (tripCount + 1).toString().padLeft(3, '0');

      final docRef = _firestore.collection('trips').doc();
      await docRef.set({
        'id': docRef.id,
        'companyId': companyId,
        'from': fromController.text.trim(),
        'to': toController.text.trim(),
        'date': dateController.text.trim(),
        'timeLeave': timeLeaveController.text.trim(),
        'timeArrive': timeArriveController.text.trim(),
        'seats': seatCount.value,
        'price': double.tryParse(priceController.text.trim()) ?? 0.0,
        'notes': notesController.text.trim(),
        'createdAt': Timestamp.now(),
        'tripNumber': tripNumber, // Save the trip number
      });

      Get.snackbar(
        'تمت العملية بنجاح',
        'تمت إضافة الرحلة بنجاح!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      formKey.currentState!.reset();
      seatCount.value = 0;
      update();
      await Future.delayed(const Duration(milliseconds: 800));
      Get.back();
    } catch (e) {
      Get.snackbar(
        'حدث خطأ',
        'فشل في إضافة الرحلة: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateTrip(Trip trip) async {
    isLoading.value = true;
    try {
      await _firestore.collection('trips').doc(trip.id).update({
        'from': trip.from,
        'to': trip.to,
        'date': trip.date,
        'timeLeave': trip.timeLeave,
        'timeArrive': trip.timeArrive,
        'seats': trip.seats,
        'price': trip.price,
        'notes': trip.notes ?? '',
      });
      Get.snackbar(
        'تمت العملية بنجاح',
        'تم تعديل الرحلة بنجاح!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      update();
      await Future.delayed(const Duration(milliseconds: 800));
      Get.back();
    } catch (e) {
      Get.snackbar(
        'حدث خطأ',
        'فشل في تعديل الرحلة: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteTrip(String tripId) async {
    isLoading.value = true;
    try {
      await _firestore.collection('trips').doc(tripId).delete();
      Get.snackbar(
        'تم الحذف',
        'تم حذف الرحلة بنجاح!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      update();
      await Future.delayed(const Duration(milliseconds: 800));
      Get.back(result: true);
    } catch (e) {
      Get.snackbar(
        'حدث خطأ',
        'فشل في حذف الرحلة: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<int> getCompanyTripCount(String companyId) async {
    final query = await _firestore.collection('trips').where('companyId', isEqualTo: companyId).get();
    return query.docs.length;
  }
}
