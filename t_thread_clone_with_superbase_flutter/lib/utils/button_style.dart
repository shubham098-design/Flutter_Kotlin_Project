import 'package:flutter/material.dart';

ButtonStyle customOutlinedStyle(){
  return ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      )
    )
  );
}