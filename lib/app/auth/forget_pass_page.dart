import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:farmingo/app/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
class ForgetPassPage extends GetView<AuthController> {
  ForgetPassPage({super.key});

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child:     Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.2),
                      child: Image.asset('assets/images/app_title.png'),
                    ),
                    const Gap(50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        maxLength: 11,
                        controller: controller.resetPhoneNumber,
                        style: const TextStyle(fontSize: 22),
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                          labelText: "Phone",
                          hintText: 'Enter your phone',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }

                          return null;
                        },
                      ),
                    ),

                    const Gap(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 15,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              var message = await controller.resetPassword();

                              if (message!=null) {
                                AwesomeDialog(
                                  context: context,
                                  animType: AnimType.scale,
                                  dialogType: DialogType.success,
                                  title: message,
                                  titleTextStyle: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  btnOkOnPress: () {
                                    Get.back();
                                  },
                                ).show();
                              } else {
                                AwesomeDialog(
                                  context: context,
                                  animType: AnimType.scale,
                                  dialogType: DialogType.error,
                                  title: ' Failed',
                                  titleTextStyle: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  btnOkOnPress: () {
                                    Get.back();
                                  },
                                ).show();
                              }
                            }
                          },
                          child: const Text(
                            "Send Reset Link",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
