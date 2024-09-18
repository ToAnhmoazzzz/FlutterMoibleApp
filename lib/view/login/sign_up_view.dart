import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/color_extension.dart';
import '../../common_widget/line_textfield.dart';
import '../../common_widget/round_button.dart';
import '../../view_model/sign_up_view_model.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {

  final signUpVM = Get.put(SignUpViewModel());

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Stack(children: [
      Container(
        color: Colors.white,
        child: Image.asset("assets/img/bottom_bg.png",
            width: media.width, height: media.height, fit: BoxFit.cover),
      ),
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset(
                "assets/img/back.png",
                width: 20,
                height: 20,
              )),
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/img/iconff.png",
                        width: 40,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: media.width * 0.15,
                  ),
                  Text(
                    "Đăng kí",
                    style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 26,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: media.width * 0.03,
                  ),
                  Text(
                    "Nhập thông tin xác thực của bạn để tiếp tục",
                    style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: media.width * 0.1,
                  ),
                  LineTextField(
                    title: "Tên đăng nập",
                    placeholder: "Điền tên đăng nhập",
                    controller: signUpVM.txtUsername.value,
                  ),
                  SizedBox(
                    height: media.width * 0.07,
                  ),
                  LineTextField(
                    title: "Email",
                    placeholder: "Điền địa chỉ email",
                    controller: signUpVM.txtEmail.value,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: media.width * 0.07,
                  ),
                  Obx(() => 
                  LineTextField(
                    title: "Password",
                    placeholder: "Điền mật khẩu",
                    controller: signUpVM.txtPassword.value,
                    obscureText: !signUpVM.isShowPassword.value,
                    right: IconButton(
                        onPressed: () {
                          signUpVM.showPassword();
                        },
                        icon: Icon(
                           !signUpVM.isShowPassword.value ? Icons.visibility_off : Icons.visibility,
                          color: TColor.textTittle,
                        )),
                  )),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                          color: TColor.secondaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      children: [
                        const TextSpan(text: "Bằng cách tiếp tục, bạn đồng ý với chúng tôi "),
                        TextSpan(
                            text: "Điều khoản dịch vụ",
                            style: TextStyle(
                                color: TColor.primary,
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
                                color: TColor.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print("Privacy Policy Click");
                              })
                      ],
                    ),
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  RoundButton(
                    title: "Đăng kí",
                    onPressed: () {
                      signUpVM.serviceCallSignUp();
                    },
                  ),
                  SizedBox(
                    height: media.width * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Đã có tài khoản?",
                                style: TextStyle(
                                    color: TColor.primaryText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Đăng nhập",
                                style: TextStyle(
                                    color: TColor.primary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
