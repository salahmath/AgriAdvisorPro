// ignore_for_file: file_names

import 'package:flutter/material.dart';

Widget myTextField(String hintText,keyBoardType,controller){
  return TextField(
    keyboardType: keyBoardType,
    controller: controller,
    decoration: InputDecoration(hintText: hintText),
  );
}