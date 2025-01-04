import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:farmingo/app/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../app_routes.dart';

class RegistrationPage extends GetView<AuthController> {
  RegistrationPage({super.key});

  final _regFormKey = GlobalKey<FormState>();
  var textStyle = const TextStyle(fontSize: 14);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: _regFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.2),
                      child: Image.asset('assets/images/app_title.png'),
                    ),
                    const Gap(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        controller: controller.regName,
                        style: textStyle,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                          labelText: "Name",
                          hintText: 'Enter your name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }

                          return null;
                        },
                      ),
                    ),
                    const Gap(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        controller: controller.regEmail,
                        style: textStyle,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_outlined,
                          ),
                          labelText: "Email",
                          hintText: 'Enter your email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const Gap(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        controller: controller.regPhone,
                        style: textStyle,
                        maxLength: 11,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                          ),
                          labelText: "Phone",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'Enter your  phone number',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone number is required';
                          }
                          // Regular expression for validating a mobile number starting with '01' and length of 11 digits
                          final mobileRegex = RegExp(r'^01[0-9]{9}$');
                          if (!mobileRegex.hasMatch(value)) {
                            return 'Please enter a valid mobile number';
                          }
                          return null;
                        },
                      ),
                    ),
                    const Gap(10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        controller: controller.regAddress,
                        style: textStyle,
                        keyboardType: TextInputType.streetAddress,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.home_work_outlined,
                          ),
                          labelText: "Address",
                          hintText: 'Enter your  address here',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Address is required';
                          }

                          return null;
                        },
                      ),
                    ),
                    const Gap(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        controller: controller.regPass,
                        style: textStyle,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.key_outlined,
                          ),
                          labelText: "Password",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'Enter your password',
                        ),
                        validator: (value) {
                          if (value == null) {
                            return "password is required";
                          }
                          if (value.length < 6) {
                            return "minimum 6 character long";
                          } else {
                            return null;
                          }
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
                            if (_regFormKey.currentState!.validate()) {
                              var userFound = await controller.doRegister();

                              if (userFound) {
                                AwesomeDialog(
                                  context: context,
                                  animType: AnimType.scale,
                                  dialogType: DialogType.success,
                                  title:
                                      ' ${controller.user.value!.id.toString()}......Sign Up successful',
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
                                  title: 'Sign up Failed',
                                  titleTextStyle: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  btnOkOnPress: () {
                                    // Get.back();
                                  },
                                ).show();
                              }
                            }
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.forgetPassPath);
                        },
                        child: const Text(
                          'Forget Password',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        )),

                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        "Already have an account? Sign In",
                        style: TextStyle(fontSize: 12),
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
