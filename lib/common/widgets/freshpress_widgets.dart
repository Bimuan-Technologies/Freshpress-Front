import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/freshpress_image_path.dart';

SizedBox buildHeader(double w, double h, BuildContext ctx) {
  return SizedBox(
    width: w,
    height: h * .08,
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
            left: 0,
            child: InkWell(
                onTap: (){
                  if(Navigator.canPop(ctx)) {
                    Navigator.of(ctx).pop();
                  }
                  // Navigator.of(context).pushNamed(GetStartedScreen.routeName);
                },
                child: const Icon(FontAwesomeIcons.arrowLeft, size: 20,))
        ),
        Positioned(
          child: SizedBox(
            width: 100, // Adjust width and height as needed
            height: 100,
            child: Image.asset(FreshPressImages.logoPath),
          ),
        )
      ],
    ),
  );
}