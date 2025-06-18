import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../resources/manager_colors.dart';
import '../resources/manager_font_sizes.dart';
import '../resources/manager_font_weight.dart';
import '../resources/manager_height.dart';
import '../resources/manager_strings.dart';
import '../../features/booking/presntation/controller/booking_controller.dart';
import '../../features/booking/presntation/model/booking_model.dart';

class BookingCard extends StatelessWidget {
  final Booking booking;
  final String status;
  final BookingController bookingController;
  final double width;
  final double margin;

  const BookingCard({
    Key? key,
    required this.booking,
    required this.status,
    required this.bookingController,
    required this.width,
    required this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin, vertical: 12),
      width: width,
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
              Text('sy001',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: ManagerFontSizes.s24,
                      fontWeight: FontWeight.bold)),
              Text(booking.userName,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: ManagerFontSizes.s24,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: ManagerHeight.h20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(booking.gender,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: ManagerFontSizes.s18,
                          fontWeight: ManagerFontWeight.regular)),
                  Text(ManagerStrings.gender,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: ManagerFontSizes.s18,
                          fontWeight: ManagerFontWeight.regular)),
                ],
              ),
              Row(
                children: [
                  Text(booking.userPhone,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: ManagerFontSizes.s18,
                          fontWeight: ManagerFontWeight.regular)),
                  Text(ManagerStrings.phoneBookATrip,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: ManagerFontSizes.s18,
                          fontWeight: ManagerFontWeight.regular)),
                ],
              ),
            ],
          ),
          SizedBox(height: ManagerHeight.h20),
          if (status == 'waiting')
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    String? reason = await _showCancelDialog(context);
                    if (reason != null && reason.isNotEmpty) {
                      await bookingController.cancelBooking(booking.id, reason);
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
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () async {
                      await bookingController.confirmBooking(booking.id);
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
                ),
                ElevatedButton(
                  onPressed: () async {
                    String? reason = await _showCancelDialog(context);
                    if (reason != null && reason.isNotEmpty) {
                      await bookingController.cancelBooking(booking.id, reason);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  ),
                  child: Text(
                   'تاجيل',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ManagerFontSizes.s18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          if (status == 'confirmed')
            SizedBox(
              width: 450,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
                child: Text(
                  'تم التأكيد',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ManagerFontSizes.s18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          if (status == 'cancelled')
            SizedBox(
              width: 450,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
                child: Text(
                  'تم الالغاء',
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
    );
  }

  Future<String?> _showCancelDialog(BuildContext context) async {
    TextEditingController reasonController = TextEditingController();
    return await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('سبب الإلغاء'),
        content: TextField(
          controller: reasonController,
          decoration: InputDecoration(hintText: 'ادخل سبب الإلغاء'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(reasonController.text),
            child: Text('تأكيد'),
          ),
        ],
      ),
    );
  }
} 