import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/booking_controller.dart';
import '../model/booking_model.dart';
import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_font_sizes.dart';
import '../../../../core/resources/manager_font_weight.dart';
import '../../../../core/resources/manager_height.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../../../core/resources/manager_width.dart';
import '../../../company_login/presntation/controller/company_login_controller.dart';

class RespondedBookingsPage extends StatefulWidget {
  @override
  State<RespondedBookingsPage> createState() => _RespondedBookingsPageState();
}

class _RespondedBookingsPageState extends State<RespondedBookingsPage> {
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
      appBar: AppBar(title: Text('الحجوزات المعالجة')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Obx(() {
        final respondedBookings = bookingController.bookings.where((b) => b.status != 'pending').toList();
        if (respondedBookings.isEmpty) {
          return Center(child: Text('لا توجد حجوزات معالجة حالياً'));
        }
        final screenWidth = MediaQuery.of(context).size.width;
        double containerWidth = screenWidth > 600 ? 500 : screenWidth * 0.9;
        double horizontalMargin = screenWidth > 600 ? (screenWidth - containerWidth) / 2 : screenWidth * 0.05;

        return ListView.builder(
          itemCount: respondedBookings.length,
          itemBuilder: (context, index) {
            final booking = respondedBookings[index];
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
            );

          },
        );
      }),
    );
  }
}