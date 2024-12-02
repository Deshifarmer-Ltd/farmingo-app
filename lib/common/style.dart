import 'package:flutter/material.dart';

class MStyle {
  static BoxDecoration drawerRgbDecoration = const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF04ABBC), // #04ABBC
        Color(0xFFFA8C19), // #FA8C19
        Color(0xFFF9231B), // #F9231B
        Color(0xFF0D8596), // #0D8596
      ],
      stops: [0.1, 0.5, 0.8, 1.0], // Adjust stops to control color transition
    ),
    boxShadow: [
      BoxShadow(
        color: Color(0xFF646464), // #646464
        offset: Offset(1, 2), // x and y offset
        blurRadius: 8, // blur radius
        spreadRadius: 1, // spread radius
      ),
    ],
  );

  static SliverGridDelegateWithFixedCrossAxisCount MyGridDelegate(
      {required double mainAxisExtent}) {
    return SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 0,
        crossAxisSpacing: 2,
        mainAxisExtent: mainAxisExtent);
  }

  Color headerTextColor = const Color(0xff6C727F);

  static Color pageColor = const Color(0xffE8EBF6);
  static TextStyle appBarTitleStyle = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white);
  static TextStyle headerStyle = const TextStyle(
      fontSize: 10.0, fontWeight: FontWeight.w400, color: Color(0xff6C727F));
  static TextStyle value1Style = const TextStyle(
      fontSize: 11.0, fontWeight: FontWeight.w400, color: Colors.black);

  static TextStyle fieldTitleStyle = const TextStyle(
      fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xff121826));

  static TextStyle fieldValueStyle = const TextStyle(
      fontSize: 11, fontWeight: FontWeight.w400, color: Color(0xff6C727F));

  // static TextStyle floatingTitleStyle = const TextStyle(
  //     fontSize: 15,
  //     fontWeight: FontWeight.w600,
  //     color: Color(0xff121826));

  static TextStyle hintStyle = const TextStyle(
      fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xff6C727F));

  static OutlineInputBorder formEnableBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(6.82),
    borderSide: const BorderSide(color: Color(0xffD2D5DA), width: 0.85),
  );

  static OutlineInputBorder formFocusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(6.82),
    borderSide: BorderSide(color: Colors.blue.shade100, width: 0.85),
  );

  static OutlineInputBorder formErrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(6.82),
    borderSide: BorderSide(color: Colors.redAccent.shade100, width: 0.85),
  );

  static TextStyle filterDropDownHintStyle = const TextStyle(
      color: Color(0xff6C727F), fontSize: 10.5, fontWeight: FontWeight.w400);

  static ButtonStyle elevatedBtnStyle = const ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(Color(0xFF16A34A)),
    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)))),
  );

  static InputBorder filterEnabledInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
      borderSide: BorderSide(color: Color(0xffD2D5DA), width: 0.75));
}