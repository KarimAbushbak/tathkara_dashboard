import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_font_sizes.dart';
import '../../../../core/resources/manager_font_weight.dart';
import '../../../../core/resources/manager_height.dart';
import '../../../../core/resources/manager_strings.dart';
import '../controller/trip_controller.dart';
import '../model/trip_model.dart';

class AddTripPage extends StatelessWidget {
  final String companyId;
  final TripController controller = Get.put(TripController());

  AddTripPage({super.key, required this.companyId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripController>(builder: (controller) {
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
                offset: const Offset(0, -1),
              ),
            ],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 80,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ManagerColors.grey,
                    fixedSize: const Size(200, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    ManagerStrings.cancellation,
                    style: TextStyle(
                      color: ManagerColors.white,
                      fontSize: ManagerFontSizes.s18,
                      fontWeight: ManagerFontWeight.bold,
                    ),
                  ),
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(250, 50),
                  backgroundColor: ManagerColors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                        String? error;
                        if (controller.fromController.text.isEmpty) {
                          error = 'يرجى اختيار مدينة الانطلاق';
                        } else if (controller.toController.text.isEmpty) {
                          error = 'يرجى اختيار مدينة الوصول';
                        } else if (controller.dateController.text.isEmpty) {
                          error = 'يرجى اختيار التاريخ';
                        } else if (controller.timeArriveController.text.isEmpty) {
                          error = 'يرجى إدخال وقت الوصول';
                        } else if (controller.timeLeaveController.text.isEmpty) {
                          error = 'يرجى إدخال وقت الانطلاق';
                        } else if (controller.priceController.text.isEmpty) {
                          error = 'يرجى إدخال السعر';
                        } else if (double.tryParse(controller.priceController.text) == null) {
                          error = 'يرجى إدخال رقم صحيح للسعر';
                        }
                        if (error != null) {
                          Get.snackbar('خطأ في الإدخال', error, backgroundColor: Colors.red, colorText: Colors.white);
                          return;
                        }
                        controller.addTrip(companyId);
                      },
                icon: controller.isLoading.value
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.file_copy, color: Colors.white),
                label: Text(
                  ManagerStrings.saveInformation,
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
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: screenWidth > 500 ? 70 : 55,
                    height: 36,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: ManagerColors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        ManagerStrings.delete,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth > 500 ? ManagerFontSizes.s16 : ManagerFontSizes.s14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        ManagerStrings.trips,
                        style: TextStyle(
                          fontSize: screenWidth > 500 ? 44 : ManagerFontSizes.s28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'السابق',
                        style: TextStyle(
                          color: ManagerColors.black,
                          fontSize: ManagerFontSizes.s16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: ManagerColors.primaryColor,
                          size: 28,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            double containerWidth = screenWidth > 600 ? 500 : screenWidth * 0.9;
            double horizontalMargin = screenWidth > 600 ? (screenWidth - containerWidth) / 2 : screenWidth * 0.05;
            return SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    SizedBox(height: ManagerHeight.h30),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
                      width: containerWidth,
                      height: 60,
                      decoration: BoxDecoration(
                        color: ManagerColors.bgColorcompany,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FutureBuilder<int>(
                              future: controller.getCompanyTripCount(companyId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Text(
                                    'SY...',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: ManagerFontSizes.s20,
                                      fontWeight: ManagerFontWeight.regular,
                                    ),
                                  );
                                }
                                final tripNumber = 'SY' + ((snapshot.data ?? 0) + 1).toString().padLeft(3, '0');
                                return Text(
                                  tripNumber,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: ManagerFontSizes.s20,
                                    fontWeight: ManagerFontWeight.regular,
                                  ),
                                );
                              },
                            ),
                            Text(
                              ManagerStrings.tripCode,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: ManagerFontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: ManagerHeight.h16),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 150,
                            height: 120,
                            decoration: BoxDecoration(
                              color: ManagerColors.bgColorcompany,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: ManagerColors.bgFrameColorcompany,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  ManagerStrings.toTheCity,
                                  style: TextStyle(
                                    fontWeight: ManagerFontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  width: 120,
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF4F4F4),
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: controller.toController.text.isEmpty ? 'إدلب' : controller.toController.text,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      items: [
                                        'إدلب',
                                        'دمشق',
                                        'حلب',
                                        'حمص',
                                        'اللاذقية',
                                        'طرطوس',
                                        'درعا',
                                        'الرقة',
                                        'الحسكة',
                                        'القنيطرة',
                                      ].map((city) {
                                        return DropdownMenuItem<String>(
                                          value: city,
                                          child: Text(city),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        if (value != null) {
                                          controller.toController.text = value;
                                          controller.update();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 120,
                            decoration: BoxDecoration(
                              color: ManagerColors.bgColorcompany,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: ManagerColors.bgFrameColorcompany,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  ManagerStrings.fromTheCity,
                                  style: TextStyle(
                                    fontWeight: ManagerFontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  width: 120,
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF4F4F4),
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: controller.fromController.text.isEmpty ? 'دمشق' : controller.fromController.text,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      items: [
                                        'دمشق',
                                        'إدلب',
                                        'حلب',
                                        'حمص',
                                        'اللاذقية',
                                        'طرطوس',
                                        'درعا',
                                        'الرقة',
                                        'الحسكة',
                                        'القنيطرة',
                                      ].map((city) {
                                        return DropdownMenuItem<String>(
                                          value: city,
                                          child: Text(city),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        if (value != null) {
                                          controller.fromController.text = value;
                                          controller.update();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: ManagerHeight.h16),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
                      width: containerWidth,
                      height: 60,
                      decoration: BoxDecoration(
                        color: ManagerColors.bgColorcompany,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: ManagerColors.bgFrameColorcompany,
                          width: 1,
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 180,
                              height: 38,
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: ManagerColors.bgColorTextTrips,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: TextFormField(
                                  controller: controller.dateController,
                                  readOnly: true,
                                  onTap: () => controller.selectDate(context),
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'dd-mm-yyyy',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: ManagerFontSizes.s18,
                                      fontWeight: ManagerFontWeight.regular,
                                    ),
                                  ),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: ManagerFontSizes.s18,
                                    fontWeight: ManagerFontWeight.regular,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              ManagerStrings.theDate,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: ManagerFontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: ManagerHeight.h16),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 150,
                            height: 120,
                            decoration: BoxDecoration(
                              color: ManagerColors.bgColorcompany,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: ManagerColors.bgFrameColorcompany,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'مدة الرحلة',
                                  style: TextStyle(
                                    fontWeight: ManagerFontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Container(
                                  width: 100,
                                  height: 42,
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: ManagerColors.bgColorTextTrips,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: TextFormField(
                                      controller: controller.timeArriveController,
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.rtl,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '00:00',
                                        hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: ManagerFontSizes.s18,
                                          fontWeight: ManagerFontWeight.regular,
                                        ),
                                      ),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: ManagerFontSizes.s18,
                                        fontWeight: ManagerFontWeight.regular,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 120,
                            decoration: BoxDecoration(
                              color: ManagerColors.bgColorcompany,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: ManagerColors.bgFrameColorcompany,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  ManagerStrings.launch,
                                  style: TextStyle(
                                    fontWeight: ManagerFontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Container(
                                  width: 100,
                                  height: 42,
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: ManagerColors.bgColorTextTrips,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: TextFormField(
                                      controller: controller.timeLeaveController,
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.rtl,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '00:00',
                                        hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: ManagerFontSizes.s18,
                                          fontWeight: ManagerFontWeight.regular,
                                        ),
                                      ),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: ManagerFontSizes.s18,
                                        fontWeight: ManagerFontWeight.regular,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: ManagerHeight.h16),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 150,
                            height: 120,
                            decoration: BoxDecoration(
                              color: ManagerColors.bgColorcompany,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: ManagerColors.bgFrameColorcompany,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  ManagerStrings.ticketPrice,
                                  style: TextStyle(
                                    fontWeight: ManagerFontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Container(
                                  width: 100,
                                  height: 42,
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: ManagerColors.bgColorTextTrips,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: TextFormField(
                                      controller: controller.priceController,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.rtl,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '0',
                                        hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: ManagerFontSizes.s18,
                                          fontWeight: ManagerFontWeight.regular,
                                        ),
                                      ),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: ManagerFontSizes.s18,
                                        fontWeight: ManagerFontWeight.regular,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 120,
                            decoration: BoxDecoration(
                              color: ManagerColors.bgColorcompany,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: ManagerColors.bgFrameColorcompany,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  ManagerStrings.numberOfSeats,
                                  style: TextStyle(
                                    fontWeight: ManagerFontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Container(
                                  height: 42,
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: ManagerColors.bgColorTextTrips,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: controller.decrementSeats,
                                        child: Icon(Icons.remove, color: ManagerColors.primaryColor),
                                      ),
                                      const SizedBox(width: 12),
                                      Obx(() => Text(
                                        controller.seatCount.toString(),
                                        style: TextStyle(
                                          fontSize: ManagerFontSizes.s18,
                                          fontWeight: ManagerFontWeight.regular,
                                          color: Colors.black,
                                        ),
                                      )),
                                      const SizedBox(width: 12),
                                      GestureDetector(
                                        onTap: controller.incrementSeats,
                                        child: Icon(Icons.add, color: ManagerColors.primaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

