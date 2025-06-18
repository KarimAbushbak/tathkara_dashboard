import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_font_sizes.dart';
import '../../../../core/resources/manager_font_weight.dart';
import '../../../../core/resources/manager_height.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../../../core/widgets/booking_card.dart';
import '../controller/reservations_controller.dart';
import '../../../booking/presntation/controller/booking_controller.dart';

class ReservationsView extends StatelessWidget {
  final String companyId;
  final ReservationsController controller = Get.put(ReservationsController());
  final BookingController bookingController = Get.put(BookingController());

  ReservationsView({super.key, required this.companyId}) {
    bookingController.fetchCompanyBookings(companyId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.sync, color: ManagerColors.primaryColor, size: 44,),
          onPressed: () => bookingController.fetchCompanyBookings(companyId),
        ),
        title: Text(
          ManagerStrings.reservations,
          style: TextStyle(
            fontSize: 44,
            fontWeight: ManagerFontWeight.bold,
          ),
        ),
        actions: [
          Text(
            'السابق',
            style: TextStyle(
              color: ManagerColors.black,
              fontSize: ManagerFontSizes.s16,
              fontWeight: ManagerFontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios_sharp, color: ManagerColors.primaryColor, size: 44,),
            onPressed: () {},
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double containerWidth = screenWidth > 600 ? 500 : screenWidth * 0.9;
          double horizontalMargin = screenWidth > 600 ? (screenWidth - containerWidth) / 2 : screenWidth * 0.05;

          return Obx(() {
            String selected = controller.selectedReservationStatus.value;
            final bookings = bookingController.bookings;
            final waitingBookings = bookings.where((b) => b.status == 'waiting' || b.status == 'pending').toList();
            final confirmedBookings = bookings.where((b) => b.status == 'confirmed').toList();
            final cancelledBookings = bookings.where((b) => b.status == 'cancelled').toList();

            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: ManagerHeight.h50),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        controller.buildFilterButton(
                          label: ManagerStrings.cancelled,
                          color: ManagerColors.red,
                          isSelected: selected == 'cancelled',
                          onTap: () => controller.selectReservationStatus('cancelled'),
                        ),
                        const SizedBox(width: 12),
                        controller.buildFilterButton(
                          label: ManagerStrings.confirmed,
                          color: ManagerColors.green,
                          isSelected: selected == 'confirmed',
                          onTap: () => controller.selectReservationStatus('confirmed'),
                        ),
                        const SizedBox(width: 12),
                        controller.buildFilterButton(
                          label: ManagerStrings.waiting,
                          color: ManagerColors.amber,
                          isSelected: selected == 'waiting',
                          onTap: () => controller.selectReservationStatus('waiting'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ManagerHeight.h20),
                  if (selected == 'waiting') _bookingList(waitingBookings, containerWidth, horizontalMargin, status: 'waiting'),
                  if (selected == 'confirmed') _bookingList(confirmedBookings, containerWidth, horizontalMargin, status: 'confirmed'),
                  if (selected == 'cancelled') _bookingList(cancelledBookings, containerWidth, horizontalMargin, status: 'cancelled'),
                ],
              ),
            );
          });
        },
      ),
    );
  }

  Widget _bookingList(List bookings, double width, double margin, {required String status}) {
    if (bookings.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(child: Text("لا توجد حجوزات حالياً")),
      );
    }
    return Column(
      children: bookings.map<Widget>((booking) {
        return BookingCard(
          booking: booking,
          status: status,
          bookingController: bookingController,
          width: width,
          margin: margin,
        );
      }).toList(),
    );
  }
}