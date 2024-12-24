import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:farmingo/app/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../common/style.dart';

class LoginPage extends GetView<AuthController> {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Image.asset('assets/images/app_title.png'),
                  ),
                  const Gap(50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      controller: controller.loginNameOrEmail,
                      style: const TextStyle(fontSize: 22),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                          labelText: "Email or Phone",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'Enter your email /phone',
                          hintStyle: MStyle.hintStyle,
                          focusedBorder: MStyle.formFocusBorder,
                          enabledBorder: MStyle.formEnableBorder,
                          errorBorder: MStyle.formErrorBorder),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email or mobile';
                        }
                        // Regular expression for validating a mobile number starting with '01' and length of 11 digits
                        // final mobileRegex = RegExp(r'^01[0-9]{9}$');
                        // if (!mobileRegex.hasMatch(value)) {
                        //   return 'Please enter a valid mobile number';
                        // }
                        return null;
                      },
                    ),
                  ),
                  const Gap(20),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        obscureText: controller.isPassObscure.value,
                        controller: controller.loginPassword,
                        style: const TextStyle(fontSize: 22),
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        decoration: InputDecoration(
                            // errorText: regLogInController.errorText.value.toString() == ""
                            //     ? null
                            //     : regLogInController.errorText.value.toString(),
                            prefixIcon: const Icon(
                              Icons.key_outlined,
                              color: Colors.grey,
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
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: 'Enter your password',
                            hintStyle: MStyle.hintStyle,
                            focusedBorder: MStyle.formFocusBorder,
                            enabledBorder: MStyle.formEnableBorder,
                            errorBorder: MStyle.formErrorBorder),
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
                  const Gap(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 15,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
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
                  const Gap(80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? Sign Up"),
                      const Gap(15),
                      TextButton(
                          onPressed: () {
                            // Get.toNamed(AppRoutes.userAccountPath);
                          },
                          child: const Text(
                            'Forget Password',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
