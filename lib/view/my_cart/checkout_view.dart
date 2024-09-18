import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries/common_widget/round_button.dart';
import 'package:online_groceries/view/account/address_list_view.dart';
import 'package:online_groceries/view/account/payment_method_view.dart';
import 'package:online_groceries/view/account/promo_code_view.dart';
import 'package:online_groceries/view_model/cart_view_model.dart';

import '../../common/color_extension.dart';
import '../../common_widget/checkout_row.dart';
import 'error_view.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final cartVM = Get.find<CartViewModel>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Thanh toán",
                    style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      "assets/img/close.png",
                      width: 15,
                      height: 15,
                      color: TColor.primaryText,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.black26,
              height: 1,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    children: [
                      Text(
                        "Giao hàng",
                        style: TextStyle(
                            color: TColor.secondaryText,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      CupertinoSegmentedControl(
                          children: const {
                            "1": Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text("Vận chuyển")),
                            "2": Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text("Tại cửa hàng")),
                          },
                          selectedColor: TColor.primary,
                          groupValue: cartVM.deliveryType.value,
                          onValueChanged: (sObj) {
                            cartVM.deliveryType.value = sObj;
                          }),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.black26,
                  height: 1,
                ),
              ],
            ),
            if (cartVM.deliveryType.value == "1")
              CheckoutRow(
                title: "Vận chuyển",
                value: (cartVM.deliverObj.value.name ?? "") != ""
                    ? (cartVM.deliverObj.value.name ?? "")
                    : "Chọn địa điểm",
                onPressed: () {
                  Get.to(() => AddressListView(
                        didSelect: (aObj) {
                          cartVM.deliverObj.value = aObj;
                        },
                      ));
                },
              ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    children: [
                      Text(
                        "Thanh toán",
                        style: TextStyle(
                            color: TColor.secondaryText,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      CupertinoSegmentedControl(
                          children: const {
                            "1": Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text("COD")),
                            "2": Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text("Online")),
                          },
                          selectedColor: TColor.primary,
                          groupValue: cartVM.paymentType.value,
                          onValueChanged: (sObj) {
                            cartVM.paymentType.value = sObj;
                          }),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.black26,
                  height: 1,
                ),
              ],
            ),
            if (cartVM.paymentType.value == "2")
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => PaymentMethodListView(
                            didSelect: (pObj) {
                              cartVM.paymentObj.value = pObj;
                            },
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          Text(
                            "Thẻ ngân hàng",
                            style: TextStyle(
                                color: TColor.secondaryText,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Image.asset(
                            "assets/img/master.png",
                            width: 30,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            (cartVM.paymentObj.value.name ?? "") != ""
                                ? (cartVM.paymentObj.value.cardNumber ?? "")
                                : "Chọn thẻ",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: TColor.primaryText,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Image.asset(
                            "assets/img/next.png",
                            height: 15,
                            color: TColor.primaryText,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black26,
                    height: 1,
                  ),
                ],
              ),
            CheckoutRow(
              title: "Mã giảm giá",
              value: (cartVM.promoObj.value.code ?? "") != ""
                  ? (cartVM.promoObj.value.code ?? "")
                  : "Chọn mã giảm",
              onPressed: () {
                Get.to(() => PromoCodeView(
                      didSelect: (pObj) {
                        cartVM.promoObj.value = pObj;
                        cartVM.serviceCallList();
                      },
                    ));
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          "tổng",
                          style: TextStyle(
                              color: TColor.secondaryText,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        Expanded(
                          child: Text(
                            "${cartVM.cartTotalPrice.value.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]},')} đ",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: TColor.secondaryText,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         "Phí vận chuyển",
                  //         style: TextStyle(
                  //             color: TColor.secondaryText,
                  //             fontSize: 16,
                  //             fontWeight: FontWeight.w600),
                  //       ),
                  //       Expanded(
                  //         child: Text(
                  //           "+${cartVM.deliverPriceAmount.value}VND",
                  //           textAlign: TextAlign.end,
                  //           style: TextStyle(
                  //               color: TColor.secondaryText,
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.w600),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          "Giảm ",
                          style: TextStyle(
                              color: TColor.secondaryText,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        Expanded(
                          child: Text(
                            "- ${cartVM.discountAmount.value}VND",
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            CheckoutRow(
              title: "Tổng: ",
              value: "${cartVM.userPayPrice.value.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]},')} đ",
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const Dialog(
                        backgroundColor: Colors.transparent,
                        insetPadding: EdgeInsets.symmetric(horizontal: 20),
                        child: ErrorView(),
                      );
                    });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                      color: TColor.secondaryText,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  children: [
                    const TextSpan(
                        text: "Bằng cách tiếp tục, bạn đồng ý với chúng tôi "),
                    TextSpan(
                        text: "Điều kiện",
                        style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print("Terms of Service Click");
                          }),
                    const TextSpan(text: " và "),
                    TextSpan(
                        text: "Chính sách bảo mật.",
                        style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print("Privacy Policy Click");
                          })
                  ],
                ),
              ),
            ),
            RoundButton(
                title: "Thanh toán",
                onPressed: () {
                  cartVM.serviceCallOrderPlace();
                }),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
