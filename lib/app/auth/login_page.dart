import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:farmingo/app/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../app_routes.dart';

class LoginPage extends GetView<AuthController> {
  LoginPage({super.key});

  final _loginFormKey = GlobalKey<FormState>();

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
                key: _loginFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.2),
                      child: Image.asset('assets/images/app_title.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
                      child: TextFormField(
                        controller: controller.loginNameOrEmail,
                        style: const TextStyle(fontSize: 22),
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                          labelText: "Email or Phone",
                          hintText: 'Enter your email /phone',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email or mobile';
                          }
                          return null;
                        },
                      ),
                    ),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
                        child: TextFormField(
                          obscureText: controller.isPassObscure.value,
                          controller: controller.loginPassword,
                          style: const TextStyle(fontSize: 22),
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(

                            prefixIcon: const Icon(
                              Icons.key_outlined,
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  controller.isPassObscure.value =
                                      !controller.isPassObscure.value;
                                },
                                icon: controller.isPassObscure.value
                                    ? const Icon(
                                        Icons.visibility_off,
                                      )
                                    : const Icon(Icons.visibility,
                                        color: Colors.blue)),

                            labelText: "Password",
                            hintText: 'Enter your password',
                          ),
                          validator: (value) {
                            if (value == null) {
                              return "password is required";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 15,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_loginFormKey.currentState!.validate()) {
                              var userFound = await controller.doLogin();

                              if (userFound) {
                                AwesomeDialog(
                                  context: context,
                                  animType: AnimType.scale,
                                  dialogType: DialogType.success,
                                  title: 'Successfully Logged In',
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
                                  title: 'Login Failed',
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
                            "LOGIN",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: TextButton(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.registrationPath);

                        },
                        child: const Text(
                          "Don't have an account? Sign Up",
                          style: TextStyle(fontSize: 12),
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
