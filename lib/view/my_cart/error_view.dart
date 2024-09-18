import 'package:flutter/material.dart';

import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
     var media = MediaQuery.sizeOf(context);
    return Container(
      width: media.width * 0.9 ,
      
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset(
                  "assets/img/close.png",
                  width: 20,
                  height: 20,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Image.asset(
            "assets/img/cancel.png",
            width: media.width * 0.5,
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            "Ối! Đặt hàng không thành công",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: TColor.primaryText,
                fontSize: 28,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Đã xảy ra lỗi nghiêm trọng.",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: TColor.secondaryText,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),

          const SizedBox(
            height: 40,
          ),
          RoundButton(title: "Vui lòng thử lại", onPressed: () {}),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Về trang chính",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
