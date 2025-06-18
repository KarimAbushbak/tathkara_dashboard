import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  int pendingCount = 0;
  int respondedCount = 0;

  Future<void> countBookingsByStatus() async {
    final bookingsRef = FirebaseFirestore.instance.collection('bookings');

    // Count pending status
    final pendingSnapshot =
    await bookingsRef.where('status', isEqualTo: 'pending').get();
    pendingCount = pendingSnapshot.docs.length;

    // Count all other statuses (not pending)
    final respondedSnapshot =
    await bookingsRef.where('status', isNotEqualTo: 'pending').get();
    respondedCount = respondedSnapshot.docs.length;

    update(); // Notify the UI
  }

  @override
  void onInit() {
    super.onInit();
    countBookingsByStatus(); // 🔄 Count based on status
  }
}
