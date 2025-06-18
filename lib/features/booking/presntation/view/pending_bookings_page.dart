import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/booking_controller.dart';
import '../model/booking_model.dart';
import 'cancel_booking_dialog.dart';
import 'cancel_booking_page.dart';
import 'reschadule_booking_page.dart';
import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_font_sizes.dart';
import '../../../../core/resources/manager_font_weight.dart';
import '../../../../core/resources/manager_height.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../../../core/resources/manager_width.dart';
import '../../../company_login/presntation/controller/company_login_controller.dart';

class PendingBookingsPage extends StatefulWidget {
  @override
  State<PendingBookingsPage> createState() => _PendingBookingsPageState();
}

class _PendingBookingsPageState extends State<PendingBookingsPage> {
  final BookingController bookingController = Get.put(BookingController());
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    final companyId = Get.find<CompanyLoginController>().loggedInCompanyId;
    bookingController.fetchCompanyBookings(companyId!).then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('الحجوزات المعلقة')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Obx(() {
              final pendingBookings = bookingController.bookings.where((b) => b.status == 'pending').toList();
              if (pendingBookings.isEmpty) {
                return Center(child: Text('لا توجد حجوزات معلقة حالياً'));
              }
              final screenWidth = MediaQuery.of(context).size.width;
              double containerWidth = screenWidth > 600 ? 500 : screenWidth * 0.9;
              double horizontalMargin = screenWidth > 600 ? (screenWidth - containerWidth) / 2 : screenWidth * 0.05;

              return ListView.builder(
                itemCount: pendingBookings.length,
                itemBuilder: (context, index) {
                  final booking = pendingBookings[index];
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
                        width: screenWidth * 0.9,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        decoration: BoxDecoration(
                          color: ManagerColors.bgColorcompany,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: ManagerColors.bgFrameColorcompany,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: ManagerHeight.h20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'SY001',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: ManagerFontSizes.s24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  booking.userName,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: ManagerFontSizes.s24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: ManagerHeight.h20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'ذكر',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: ManagerFontSizes.s18,
                                        fontWeight: ManagerFontWeight.regular,
                                      ),
                                    ),
                                    Text(
                                      ManagerStrings.gender,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: ManagerFontSizes.s18,
                                        fontWeight: ManagerFontWeight.regular,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      booking.userPhone,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: ManagerFontSizes.s18,
                                        fontWeight: ManagerFontWeight.regular,
                                      ),
                                    ),
                                    Text(
                                      ManagerStrings.phoneBookATrip,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: ManagerFontSizes.s18,
                                        fontWeight: ManagerFontWeight.regular,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: ManagerHeight.h20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    await showCancelBookingDialog(
                                      context,
                                      booking.id,
                                      booking.userName,
                                      booking.userPhone,
                                      onCancelled: () {
                                        bookingController.updateBookingStatusLocally(booking.id, 'cancelled');
                                      },
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                                  ),
                                  child: Text(
                                    'إلغاء',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ManagerFontSizes.s18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    final result = await Get.to(() => RescheduleBookingPage(bookingId: booking.id));
                                    if (result == true) {
                                      bookingController.updateBookingStatusLocally(booking.id, 'rescheduled');
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.yellow[700],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                                  ),
                                  child: Text(
                                    'تأجيل',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ManagerFontSizes.s18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    final result = await Get.to(() => RescheduleBookingPage(bookingId: booking.id));
                                    if (result == true) {
                                      bookingController.updateBookingStatusLocally(booking.id, 'rescheduled');
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                                  ),
                                  child: Text(
                                    'تأكيد',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ManagerFontSizes.s18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: ManagerHeight.h10),

                    ],
                  );
                },
              );
            }),
    );
  }
} 