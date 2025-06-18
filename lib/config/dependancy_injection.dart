
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tathkara_dashboard/features/company_login/presntation/controller/company_login_controller.dart';
import 'package:tathkara_dashboard/features/home/presntation/controller/home_controller.dart';
import 'package:tathkara_dashboard/features/trip/presntation/controller/trip_controller.dart';
import 'package:tathkara_dashboard/features/trip/presntation/model/trip_model.dart';
import 'package:tathkara_dashboard/features/trip_details/presntaiton/view/trip_details_view.dart';
import 'package:tathkara_dashboard/features/trip_list/presntation/controller/trip_list_controller.dart';

import '../core/storage/local/database/shared_preferences/app_settings_shared_preferences.dart';
import '../features/trip_details/presntaiton/controller/trip_details_controller.dart';
import '../firebase_options.dart';

initModule() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await AppSettingsSharedPreferences().initPreferences();
}
initTripController() {
  Get.put<TripController>(TripController());
}
iniCompanyLoginController() {
  Get.put<CompanyLoginController>(CompanyLoginController());
}
iniHome() {
  Get.put<HomeController>(HomeController());
}

initTripList() {
  Get.put<TripListController>(TripListController());
}
initTripLDetails() {
  Get.put<TripDetailsController>(TripDetailsController());
}

