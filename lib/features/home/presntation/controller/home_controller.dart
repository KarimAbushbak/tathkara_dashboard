import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../company_login/presntation/controller/company_login_controller.dart';

class HomeController extends GetxController {
  int pendingCount = 0;
  int respondedCount = 0;

  Future<void> countBookingsByStatus(String companyId) async {
    final bookingsRef = FirebaseFirestore.instance.collection('bookings');

    // Count pending status for this company
    final pendingSnapshot = await bookingsRef
        .where('status', isEqualTo: 'pending')
        .where('companyId', isEqualTo: companyId)
        .get();
    pendingCount = pendingSnapshot.docs.length;

    // Count confirmed status for this company
    final respondedSnapshot = await bookingsRef
        .where('status', isEqualTo: 'confirmed')
        .where('companyId', isEqualTo: companyId)
        .get();
    respondedCount = respondedSnapshot.docs.length;

    update(); // Notify the UI
  }

  @override
  void onInit() {
    super.onInit();
    final companyId = Get.find<CompanyLoginController>().loggedInCompanyId;
    countBookingsByStatus(companyId!);
  }
}
