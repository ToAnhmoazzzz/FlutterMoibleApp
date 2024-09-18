import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries/common_widget/line_textfield.dart';
import 'package:online_groceries/common_widget/round_button.dart';

import '../../common/color_extension.dart';
import '../../view_model/my_detail_view_model.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final detailVM = Get.put(MyDetailViewModel());

  @override
  void initState() {
    super.initState();
    detailVM.clearPassword();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<MyDetailViewModel>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              "assets/img/back.png",
              width: 20,
              height: 20,
            )),
        centerTitle: true,
        title: Text(
          "Đổi mật khẩu",
          style: TextStyle(
              color: TColor.primaryText,
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            children: [
              Column(
                children: [
                  LineTextField(
                      title: "Mật khẩu hiện tại",
                      placeholder: "Nhập mật khẩu hiện tại",
                      obscureText: true,
                      controller: detailVM.txtCurrentPassword.value),
                  const SizedBox(
                    height: 15,
                  ),
                  LineTextField(
                      title: "Mật khẩu mới",
                      placeholder: "Nhập mật khẩu mới",
                      obscureText: true,
                      controller: detailVM.txtNewPassword.value),
                  const SizedBox(
                    height: 15,
                  ),

                  LineTextField(
                      title: "Xác nhận mật khẩu",
                      obscureText: true,
                      placeholder: "Nhập mật khẩu mới",
                      controller: detailVM.txtConfirmPassword.value),
                  const SizedBox(
                    height: 15,
                  ),
                  
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              RoundButton(
                  title: "Đổi mật khẩu",
                  onPressed: () {
                    detailVM.serviceCallSetPassword(() {
                      Navigator.pop(context);
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
