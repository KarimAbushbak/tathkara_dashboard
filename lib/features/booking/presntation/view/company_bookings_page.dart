import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tathkara_dashboard/features/booking/presntation/view/reschadule_booking_page.dart';
import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_font_sizes.dart';
import '../../../../core/resources/manager_font_weight.dart';
import '../../../../core/resources/manager_height.dart';
import '../../../../core/resources/manager_strings.dart';
import '../controller/booking_controller.dart';
import 'cancel_booking_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyBookingsPage extends StatefulWidget {
  final String companyId;
  final String? tripId;

  CompanyBookingsPage({super.key, required this.companyId, this.tripId});

  @override
  _CompanyBookingsPageState createState() => _CompanyBookingsPageState();
}

class _CompanyBookingsPageState extends State<CompanyBookingsPage> {
  String? tripNumber;

  @override
  void initState() {
    super.initState();
    final controller = Get.put(BookingController());
    controller.fetchCompanyBookings(widget.companyId, tripId: widget.tripId);
    if (widget.tripId != null) {
      fetchTripNumber(widget.tripId!);
    }
  }

  Future<void> fetchTripNumber(String tripId) async {
    final doc = await FirebaseFirestore.instance.collection('trips').doc(tripId).get();
    if (doc.exists) {
      setState(() {
        tripNumber = doc.data()?['tripNumber'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          tripNumber ?? '',
          style: TextStyle(
            fontSize: 44,
            fontWeight: ManagerFontWeight.bold,
          ),
        ),
      ),
      body: Obx(() {
        final controller = Get.find<BookingController>();

        if (controller.bookings.isEmpty) {
          return const Center(child: Text("لا توجد حجوزات حالياً"));
        }

        return ListView.builder(
          itemCount: controller.bookings.length,
          itemBuilder: (context, index) {
            final booking = controller.bookings[index];
            double containerWidth = screenWidth > 600 ? 500 : screenWidth * 0.9;
            double horizontalMargin = screenWidth > 600 ? (screenWidth - containerWidth) / 2 : screenWidth * 0.05;

            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('تفاصيل المقاعد'),
                    content: booking.selectedSeats.isNotEmpty
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: booking.selectedSeats.map<Widget>((seat) {
                              return Text('رقم المقعد: ''${seat['seatNumber']}\n'
                                  '   الجنس: ${seat['gender']}');  }).toList(),
                          )
                        : Text('لا يوجد مقاعد محددة'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('إغلاق'),
                      ),
                    ],
                  ),
                );
              },
              child: Column(
                children: [
                  if (index == 0) SizedBox(height: ManagerHeight.h50),
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
                              booking.tripNumber ?? '',
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
                        if (booking.status == 'pending')
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  final result = await Get.to(() => CancelBookingPage(bookingId: booking.id));
                                  if (result == true) {
                                    controller.updateBookingStatusLocally(booking.id, 'cancelled');
                                  }
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
                                    controller.updateBookingStatusLocally(booking.id, 'rescheduled');
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
                                  await controller.confirmBooking(booking.id);
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
                          )
                        else
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: ElevatedButton(
                              onPressed: null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: booking.status == 'confirmed' ? Colors.green :
                                               booking.status == 'cancelled' ? Colors.red :
                                               Colors.yellow[700],
                                disabledBackgroundColor: booking.status == 'confirmed' ? Colors.green :
                                                   booking.status == 'cancelled' ? Colors.red :
                                                   Colors.yellow[700],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                              ),
                              child: Text(
                                booking.status == 'confirmed' ? 'تم التأكيد' :
                                booking.status == 'cancelled' ? 'تم الإلغاء' :
                                'تم التأجيل',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ManagerFontSizes.s18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: ManagerHeight.h10),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
