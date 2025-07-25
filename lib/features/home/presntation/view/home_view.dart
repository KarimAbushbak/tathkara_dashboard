import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tathkara_dashboard/features/home/presntation/controller/home_controller.dart';
import '../../../../core/resources/manager_assets.dart';
import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_font_sizes.dart';
import '../../../../core/resources/manager_font_weight.dart';
import '../../../../core/resources/manager_height.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../../../core/resources/manager_width.dart';
import '../../../../core/routes.dart';
import '../../../booking/presntation/view/pending_bookings_page.dart';
import '../../../booking/presntation/view/responded_bookings_page.dart';
import '../../../company_login/presntation/controller/company_login_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildNavItem(icon: Icons.notifications_active, label: "الإشعارات", color: ManagerColors.red, textColor: ManagerColors.white),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(
                      context,
                      Routes.addTripPage,
                      arguments: Get.find<CompanyLoginController>().loggedInCompanyId,
                    );


                  },
                    child: buildNavItem(icon: Icons.add_circle, label: "إضافة رحلة", color: ManagerColors.green, textColor: ManagerColors.white)),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.tripListView);
                  },
                    child: buildNavItem(icon: Icons.directions_bus, label: "الرحلات", color: ManagerColors.primaryColor, textColor: ManagerColors.white)),
                GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(
                        context,
                        Routes.allBooking,
                        arguments: {'companyId': Get.find<CompanyLoginController>().loggedInCompanyId},
                      );


                    },child: buildNavItem(icon: Icons.confirmation_number, label: "الحجوزات", color: Colors.yellow, textColor: ManagerColors.white)),
              ],
            ),
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                Icons.sync,
                color: ManagerColors.primaryColor,
                size: 40,
              ),
            ),
            actions: [
              Text(
                ManagerStrings.appName,
                style: TextStyle(
                  fontSize: 44,
                  fontWeight: ManagerFontWeight.bold,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ManagerAssets.auth),
                  ),
                ),
              ),
            ],
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              double screenWidth = constraints.maxWidth;
              double containerWidth = screenWidth > 600 ? 460 : screenWidth * 0.9;
              double horizontalMargin = screenWidth > 600 ? (screenWidth - containerWidth) / 2 : screenWidth * 0.05;

              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: ManagerHeight.h34),
                    InkWell(
                      onTap: (){
                        Get.to(() => PendingBookingsPage());
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
                        width: containerWidth,
                        height: 200,
                        decoration: BoxDecoration(
                          color: ManagerColors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  controller.pendingCount.toString(),
                                  style: TextStyle(
                                    fontWeight: ManagerFontWeight.bold,
                                    fontSize: ManagerFontSizes.s38,
                                    color: ManagerColors.white,
                                  ),
                                ),
                                SizedBox(width: ManagerWidth.w20),
                                Icon(Icons.person_add_alt_1, color: ManagerColors.white, size: 50),
                              ],
                            ),
                            SizedBox(height: ManagerHeight.h20),
                            Text(
                              ManagerStrings.reservationsAwaitingConfirmation,
                              style: TextStyle(
                                fontWeight: ManagerFontWeight.regular,
                                fontSize: ManagerFontSizes.s16,
                                color: ManagerColors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: ManagerHeight.h30,),
                    InkWell(
                      onTap: (){
                        Get.to(() => RespondedBookingsPage());
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
                        width: containerWidth,
                        height: 200,
                        decoration: BoxDecoration(
                          color: ManagerColors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  controller.respondedCount.toString(),
                                  style: TextStyle(
                                    fontWeight: ManagerFontWeight.bold,
                                    fontSize: ManagerFontSizes.s38,
                                    color: ManagerColors.white,
                                  ),
                                ),
                                SizedBox(width: ManagerWidth.w20),
                                Icon(Icons.task_alt, color: ManagerColors.white, size: 50),
                              ],
                            ),
                            SizedBox(height: ManagerHeight.h20),
                            Text(
                              ManagerStrings.numberOfConfirmedReservations,
                              style: TextStyle(
                                fontWeight: ManagerFontWeight.regular,
                                fontSize: ManagerFontSizes.s16,
                                color: ManagerColors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: ManagerHeight.h30),
                  ],
                ),
              );
            },
          ),
        );
      }
    );
  }
}

Widget buildNavItem({required IconData icon, required String label, required Color color, required textColor}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            Text(
              label,
              style: TextStyle(
                fontSize: ManagerFontSizes.s12,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}