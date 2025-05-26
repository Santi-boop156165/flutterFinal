import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'color_utils.dart';

class UIUtils {
  static final loader = SpinKitThreeBounce(
    color: ColorUtils.blueGrey,
    size: 50.0,
  );

 
  static Column createHeader(title) {
    return Column(children: [
      Container(
        padding: const EdgeInsets.only(left: 0, top: 12),
        child: Text(
          title,
          style: TextStyle(
              color: ColorUtils.blueGrey,
              fontSize: 28,
              fontWeight: FontWeight.bold),
        ),
      ),
      const Divider(),
    ]);
  }

  
  static FloatingActionButton createBackButton(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'back_button',
      backgroundColor: ColorUtils.main,
      elevation: 4.0,
      child: Icon(
        Icons.arrow_back,
        color: ColorUtils.white,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
