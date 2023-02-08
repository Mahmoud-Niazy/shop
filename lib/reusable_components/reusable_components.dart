import 'package:flutter/material.dart';
import 'package:shop_final/functions/fucnctions.dart';

import '../constants/constants.dart';

Navigate(Widget widget, BuildContext context) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
}

NavigateAndFinish(Widget screen, BuildContext context) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => screen), (route) => false);
}

BuildTextFormField({
  required IconData pIcon,
  required String labelAr,
  required String labelEn,
  IconData? sIcon,
  required TextEditingController controller,
  Function(String value)? onChange,
  Function(String value)? onSubmit,
  String? Function(String? value)? validate,
  bool isPassword = false,
  void Function()? onPressedOnSIcon,
  TextInputType? type ,
}) {
  return TextFormField(
    keyboardType: type,
    controller: controller,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      prefixIcon: Icon(pIcon),
      label: TextWith2Lan(
        enLan: enLan,
        ar: labelAr,
        en: labelEn,
      ),
      suffixIcon: IconButton(
        onPressed: onPressedOnSIcon,
        icon: Icon(sIcon),
      ),
    ),
    onChanged: onChange,
    onFieldSubmitted: onSubmit,
    validator: validate,
    obscureText: isPassword,
  );
}

BuildButton({
  required String labelEn,
  required String labelAr,
  required Function()? onPressed,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: MaterialButton(
      onPressed: onPressed,
      child: TextWith2Lan(
        enLan: enLan,
        ar: labelAr,
        en: labelEn,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      color: Colors.blue,
      height: 50,
      minWidth: double.infinity,
    ),
  );
}

BuildTextButton({
  required String labelEn,
  required String labelAr,
  required Function()? onPressed,
}) {
  return TextButton(
    onPressed: onPressed,
    child: TextWith2Lan(
      enLan: enLan,
      ar: labelAr,
      en: labelEn,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
