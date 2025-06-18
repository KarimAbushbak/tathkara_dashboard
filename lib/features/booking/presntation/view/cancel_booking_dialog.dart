import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_font_sizes.dart';
import '../../../../core/resources/manager_font_weight.dart';
import '../../../../core/resources/manager_height.dart';
import '../../../../core/resources/manager_strings.dart';

Future<void> showCancelBookingDialog(
  BuildContext context,
  String bookingId,
  String userName,
  String userPhone,
 {
  Function()? onCancelled,
}) async {
  final List<String> reasons = [
    'تغيير في الخطة',
    'ظروف طارئة',
    'وجدت عرضاً أفضل',
    'أسباب أخرى',
  ];

  await showDialog(
    context: context,
    builder: (ctx) {
      double width = MediaQuery.of(ctx).size.width > 600 ? 500 : MediaQuery.of(ctx).size.width * 0.9;
      double margin = MediaQuery.of(ctx).size.width > 600 ? (MediaQuery.of(ctx).size.width - width) / 2 : MediaQuery.of(ctx).size.width * 0.05;

      return AlertDialog(
        backgroundColor: ManagerColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'اختر سبب الإلغاء',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: ManagerFontSizes.s18,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Divider(
              thickness: 1,
              height: 1,
              color: Colors.grey.shade400,
              indent: 76,
              endIndent: 76,
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: reasons.map((reason) => _reasonButton(ctx, reason, bookingId, onCancelled)).toList(),
        ),
      );
    },
  );
}

Widget _reasonButton(BuildContext ctx, String text, String bookingId, Function()? onCancelled) {
  return GestureDetector(
    onTap: () {
      Navigator.of(ctx).pop();
      if (text == 'أسباب أخرى') {
        showCustomReasonDialog(ctx, bookingId, onCancelled);
      } else {
        _cancelBooking(ctx, bookingId, text, onCancelled);
      }
    },
    child: Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(25),
      ),
      alignment: Alignment.center,
      child: Text(text),
    ),
  );
}

void showCustomReasonDialog(BuildContext context, String bookingId, Function()? onCancelled) {
  TextEditingController customReasonController = TextEditingController();

  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        backgroundColor: ManagerColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'يرجى ذكر السبب',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: ManagerFontSizes.s18,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Divider(
              thickness: 1,
              height: 1,
              color: Colors.grey.shade400,
              indent: 76,
              endIndent: 76,
            ),
          ],
        ),
        content: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: customReasonController,
            maxLines: 6,
            textAlign: TextAlign.center,
            decoration: InputDecoration.collapsed(
              hintStyle: TextStyle(
                color: ManagerColors.black,
              ),
              hintText: 'نص مخصص',
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              String reason = customReasonController.text.trim();
              Navigator.of(ctx).pop();
              _cancelBooking(context, bookingId, reason, onCancelled);
            },
            child: Text(
              'تأكيد',
              style: TextStyle(
                color: ManagerColors.black,
                fontSize: ManagerFontSizes.s16,
              ),
            ),
          ),
        ],
      );
    },
  );
}

void _cancelBooking(BuildContext context, String bookingId, String reason, Function()? onCancelled) async {
  await FirebaseFirestore.instance
      .collection('bookings')
      .doc(bookingId)
      .update({
    'status': 'cancelled',
    'cancellationReason': reason,
  });
  Get.snackbar("تم", "تم إلغاء الحجز");
  if (onCancelled != null) onCancelled();
} 