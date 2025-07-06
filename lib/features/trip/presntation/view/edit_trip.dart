import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tathkara_dashboard/features/trip_list/presntation/controller/trip_list_controller.dart';

import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_font_sizes.dart';
import '../../../../core/resources/manager_font_weight.dart';
import '../../../../core/resources/manager_height.dart';
import '../../../../core/resources/manager_strings.dart';
import '../controller/trip_controller.dart';
import '../model/trip_model.dart';

class EditTripPage extends StatelessWidget {
  final Trip trip;
  final TripController controller = Get.put(TripController());
  final TripListController listController = Get.put(TripListController());

  EditTripPage({super.key, required this.trip}) {
    controller.fromController.text = trip.from;
    controller.toController.text = trip.to;
    controller.dateController.text = trip.date;
    controller.timeLeaveController.text = trip.timeLeave;
    controller.timeArriveController.text = trip.timeArrive;
    controller.seatCount.value = trip.seats;
    controller.priceController.text = trip.price.toString();
    // If you have notes, add: controller.notesController.text = trip.notes ?? '';
  }

  @override
  Widget build(BuildContext context) {


    return GetBuilder<TripController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'تعديل الرحلة',
            style: TextStyle(
              fontSize: 44,
              fontWeight: ManagerFontWeight.bold,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ManagerColors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: controller.isLoading.value
                    ? null
                    : () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('تأكيد الحذف'),
                      content: Text('هل أنت متأكد أنك تريد حذف هذه الرحلة؟'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text('إلغاء'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text('حذف', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                  if (confirmed == true) {
                    controller.deleteTrip(trip.id!);
                  }
                },
                child: Text(
                  'حذف',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ManagerFontSizes.s16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            double containerWidth = screenWidth > 600 ? 500 : screenWidth * 0.9;
            double horizontalMargin = screenWidth > 600 ? (screenWidth - containerWidth) / 2 : screenWidth * 0.05;
            return SingleChildScrollView(
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
                          Text(
                        trip.tripNumber ?? '',



                            style: TextStyle(
                              color: Colors.black,
                              fontSize: ManagerFontSizes.s20,
                              fontWeight: ManagerFontWeight.regular,
                            ),
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
                                ManagerStrings.access,
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
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
                    child: ElevatedButton.icon(
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
                        final updatedTrip = Trip(
                          id: trip.id,
                          companyId: trip.companyId,
                          from: controller.fromController.text,
                          to: controller.toController.text,
                          date: controller.dateController.text,
                          timeLeave: controller.timeLeaveController.text,
                          timeArrive: controller.timeArriveController.text,
                          seats: controller.seatCount.value,
                          price: double.tryParse(controller.priceController.text) ?? 0.0,
                        );
                        controller.updateTrip(updatedTrip);
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
                          : const Icon(Icons.save, color: Colors.white),
                      label: Text(
                        'حفظ التعديلات',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ManagerFontSizes.s18,
                          fontWeight: ManagerFontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
