import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tathkara_dashboard/core/resources/manager_colors.dart';
import 'package:tathkara_dashboard/core/resources/manager_font_sizes.dart';
import 'package:tathkara_dashboard/core/resources/manager_font_weight.dart';
import 'package:tathkara_dashboard/core/resources/manager_height.dart';
import 'package:tathkara_dashboard/core/resources/manager_strings.dart';
import 'package:tathkara_dashboard/core/resources/manager_width.dart';
import 'package:tathkara_dashboard/features/booking/presntation/controller/booking_controller.dart';

import '../../../booking/presntation/view/cancel_booking_dialog.dart';

class CompanyBookingsPage extends StatelessWidget {
  final String companyId;
  final String? tripId;

  CompanyBookingsPage({super.key, required this.companyId, this.tripId}) {
    final controller = Get.put(BookingController());
    controller.fetchCompanyBookings(companyId, tripId: tripId);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GetBuilder<BookingController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            ManagerStrings.reservations,
            style: TextStyle(
              fontSize: 44,
              fontWeight: ManagerFontWeight.bold,
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: controller.bookings.length,
          itemBuilder: (context, index) {
            double contentWidth = screenWidth > 800 ? 760 : screenWidth - 40;
            double horizontalMargin = screenWidth > 800 ? (screenWidth - contentWidth) / 2 : 20;
            
            return Column(
              children: [
                if (index == 0) SizedBox(height: ManagerHeight.h50),
                Container(
                  width: contentWidth,
                  margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: ManagerHeight.h20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: ManagerColors.bgColorTextTrips,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              controller.bookings[index].seats.toString(),
                              style: TextStyle(
                                fontSize: ManagerFontSizes.s20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Text(
                            'SY001',
                            style: TextStyle(
                              fontSize: ManagerFontSizes.s24,
                              fontWeight: ManagerFontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ManagerHeight.h20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 180,
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: ManagerColors.bgColorTextTrips,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              controller.bookings[index].userName,
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Text(
                            ManagerStrings.tripHistory,
                            style: TextStyle(
                              fontSize: ManagerFontSizes.s24,
                              fontWeight: ManagerFontWeight.bold,
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
                                'ل.س',
                                style: TextStyle(
                                  fontSize: ManagerFontSizes.s14,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                controller.bookings[index].userPhone,
                                style: TextStyle(
                                  fontSize: ManagerFontSizes.s28,
                                  fontWeight: ManagerFontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    controller.bookings[index].status,
                                    style: TextStyle(
                                      fontSize: ManagerFontSizes.s24,
                                      fontWeight: ManagerFontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    controller.bookings[index].tripId,
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: ManagerWidth.w30),
                              Column(
                                children: [
                                  Text(
                                    controller.bookings[index].companyId,
                                    style: TextStyle(
                                      fontSize: ManagerFontSizes.s24,
                                      fontWeight: ManagerFontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Company ID',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
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
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ManagerColors.red,
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () async {
                              await showCancelBookingDialog(
                                context,
                                controller.bookings[index].id,
                                controller.bookings[index].userName,
                                controller.bookings[index].userPhone,
                                onCancelled: () {
                                  controller.updateBookingStatusLocally(controller.bookings[index].id, 'cancelled');
                                },
                              );
                            },
                            child: Text(
                              ManagerStrings.editDetails,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ManagerFontSizes.s16,
                                fontWeight: ManagerFontWeight.bold,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              ManagerStrings.reservations,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ManagerFontSizes.s16,
                                fontWeight: ManagerFontWeight.bold,
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
        ),
      );
    });
  }
} 