import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_groceries/model/my_order_model.dart';

import '../common/color_extension.dart';

class MyOrderRow extends StatelessWidget {
  final MyOrderModel mObj;
  final VoidCallback onTap;
  const MyOrderRow({super.key, required this.mObj, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 2)
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Mã đơn: #",
                    style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  Expanded(
                      child: Text(
                    mObj.orderId?.toString() ?? "",
                    style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  )),
                  Text(
                    getOrderStatus(mObj),
                    style: TextStyle(
                        color: getOrderStatusColor(mObj),
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              Text(
                mObj.createdDate ?? "",
                style: TextStyle(color: TColor.secondaryText, fontSize: 12),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if ((mObj.images?.length ?? 0) > 0)
                    CachedNetworkImage(
                      imageUrl: mObj.images?[0] ?? "",
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Mặt hàng: ",
                                style: TextStyle(
                                    color: TColor.primaryText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              Expanded(
                                child: Text(
                                  mObj.names ?? "",
                                  style: TextStyle(
                                      color: TColor.secondaryText,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                         
                          Row(
                            children: [
                              Text(
                                "Vận chuyển: ",
                                style: TextStyle(
                                    color: TColor.primaryText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              Expanded(
                                  child: Text(
                                getDeliverType(mObj),
                                style: TextStyle(
                                    color: TColor.primaryText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )),
                            ],
                          ),
                          
                          Row(
                            children: [
                              Text(
                                "Thanh toán: ",
                                style: TextStyle(
                                    color: TColor.primaryText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              Expanded(
                                  child: Text(
                                getPaymentType(mObj),
                                style: TextStyle(
                                    color: TColor.primaryText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )),
                            ],
                          ),
                          
                          Row(
                            children: [
                              Text(
                                "Tình trạng thanh toán: ",
                                style: TextStyle(
                                    color: TColor.primaryText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              Expanded(
                                  child: Text(
                                getPaymentStatus(mObj),
                                style: TextStyle(
                                    color: getPaymentStatusColor(mObj),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              )),
                            ],
                          ),
                        ]),
                  ),
                ],
              ),
            ],
          )),
    );
  }

}

String getOrderStatus(MyOrderModel mObj) {
  //1: new, 2: order_accept, 3: order_delivered, 4: cancel, 5: order declined
  switch (mObj.orderStatus) {
    case 1:
      return "Đã đặt";
    case 2:
      return "Được đóng gói";
    case 3:
      return "Đã vận chuyển";
    case 4:
      return "Huỷ đơn";
    case 5:
      return "Declined";
    default:
      return "";
  }
}

String getDeliverType(MyOrderModel mObj) {
  switch (mObj.deliverType) {
    case 1:
      return "Ship hoả tốc";
    case 2:
      return "Collection";
    default:
      return "";
  }
}

String getPaymentType(MyOrderModel mObj) {
  switch (mObj.paymentType) {
    case 1:
      return "Cash On Delivery";
    case 2:
      return "Thanh toán qua thẻ";
    default:
      return "";
  }
}

String getPaymentStatus(MyOrderModel mObj) {
  //1: waiting, 2: done, 3: fail, 4: refund

  if (mObj.paymentType == 1) {
    return "COD";
  }
  switch (mObj.paymentStatus) {
    case 1:
      return "Đang tiến hành";
    case 2:
      return "Thành công";
    case 3:
      return "Thất bại";
    case 4:
      return "Refunded";
    default:
      return "";
  }
}

Color getPaymentStatusColor(MyOrderModel mObj) {
  //1: waiting, 2: done, 3: fail, 4: refund

  if (mObj.paymentType == 1) {
    return Colors.orange;
  }
  switch (mObj.paymentStatus) {
    case 1:
      return Colors.blue;
    case 2:
      return Colors.green;
    case 3:
      return Colors.red;
    case 4:
      return Colors.green;
    default:
      return Colors.white;
  }
}

Color getOrderStatusColor(MyOrderModel mObj) {
  //1: new, 2: order_accept, 3: order_delivered, 4: cancel, 5: order declined
  switch (mObj.orderStatus) {
    case 1:
      return Colors.blue;
    case 2:
      return Colors.green;
    case 3:
      return Colors.green;
    case 4:
      return Colors.red;
    case 5:
      return Colors.red;
    default:
      return TColor.primary;
  }
}
