import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:tathkara_dashboard/core/routes.dart';
import 'package:tathkara_dashboard/features/trip_list/presntation/controller/trip_list_controller.dart';

import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_font_sizes.dart';
import '../../../../core/resources/manager_font_weight.dart';
import '../../../../core/resources/manager_height.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../../../core/resources/manager_width.dart';
import '../../../company_login/presntation/controller/company_login_controller.dart';
import '../../../trip/presntation/view/add_trip_page.dart';
import '../../../trip/presntation/view/edit_trip.dart';

class TripListView extends StatelessWidget {
  const TripListView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GetBuilder<TripListController>(builder: (controller) {
      return Scaffold(
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, -1),
              ),
            ],
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(Icons.search, color: Colors.white, size: 30),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(250, 50),
                  backgroundColor: ManagerColors.green,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.addTripPage,
                    arguments: Get.find<CompanyLoginController>().loggedInCompanyId,
                  );
                },
                icon: Icon(Icons.add, color: Colors.white),
                label: Text(
                  ManagerStrings.addANewTrip,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ManagerFontSizes.s18,
                    fontWeight: ManagerFontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            ManagerStrings.trips,
            style: TextStyle(
              fontSize: 44,
              fontWeight: ManagerFontWeight.bold,
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: controller.tripList.length,
          itemBuilder: (context, index) {
            double containerWidth = screenWidth > 600 ? 500 : screenWidth * 0.9;
            double horizontalMargin = screenWidth > 600 ? (screenWidth - containerWidth) / 2 : screenWidth * 0.05;
            
            return Column(
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
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: ManagerColors.bgColorTextTrips,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                controller.tripList[index].seats.toString(),
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ManagerFontSizes.s20,
                                  fontWeight: ManagerFontWeight.regular,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'SY001',
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
                          Container(
                            width: 180,
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: ManagerColors.bgColorTextTrips,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                controller.tripList[index].date.toString(),
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: ManagerFontWeight.regular,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            ManagerStrings.tripHistory,
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
                                'ل.س',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ManagerFontSizes.s14,
                                  fontWeight: ManagerFontWeight.regular,
                                ),
                              ),
                              Text(
                                controller.tripList[index].price.toString(),
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ManagerFontSizes.s28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    controller.tripList[index].timeArrive,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: ManagerFontSizes.s24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    controller.tripList[index].from.toString(),
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: ManagerFontSizes.s16,
                                      fontWeight: ManagerFontWeight.regular,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: ManagerWidth.w30),
                              Column(
                                children: [
                                  Text(
                                    controller.tripList[index].timeLeave,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: ManagerFontSizes.s24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    controller.tripList[index].to.toString(),
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: ManagerFontSizes.s16,
                                      fontWeight: ManagerFontWeight.regular,
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
                            onPressed: () {
                              Get.to(() => EditTripPage(trip: controller.tripList[index]));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ManagerColors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                            ),
                            child: Text(
                              ManagerStrings.editDetails,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ManagerFontSizes.s18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.toNamed(
                                Routes.bookingView,
                                arguments: {
                                  'companyId': controller.tripList[index].companyId,
                                  'tripId': controller.tripList[index].id,
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                            ),
                            child: Text(
                              ManagerStrings.reservations,
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
        ),
      );
    });
  }
}
