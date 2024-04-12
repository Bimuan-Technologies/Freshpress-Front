import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants/freshpress_color.dart';


void showToastMessage({required String message }) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.SNACKBAR,
    backgroundColor: FreshPressColors.lightBlue,
    textColor: Colors.black,
    fontSize: 12.0
);