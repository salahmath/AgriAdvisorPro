// ignore_for_file: file_names, prefer_const_constructors, sort_child_properties_last, deprecated_member_use

import 'package:app_commerce/const/AppColors.dart';
import 'package:flutter/material.dart';


Widget customButton (String buttonText,onPressed){
  return SizedBox(

    height: 56,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(
            color: Colors.white, fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        primary: AppColors.deep_orange,
        elevation: 3,
      ),
    ),
  );
}