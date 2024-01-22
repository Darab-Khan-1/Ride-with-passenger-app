
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/colors.dart';
import '../widgets/form_fields/k_text.dart';
class Utils{
  static toastMessage(String message){
    Fluttertoast.showToast(
      msg: message ,
      backgroundColor: kErrorColor ,
      textColor: kWhiteColor,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
    );
  }
  static toastMessageCenter(String message){
    Fluttertoast.showToast(
      msg: message ,
      backgroundColor: kErrorColor ,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG,
      textColor: kWhiteColor,
    );
  }
  static snackBar(String title, String message){
    Get.snackbar(
        title,
        message ,
        backgroundColor: kWhiteColor.withOpacity(0.3)
    );
  }
  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
Future<OkCancelResult> errorOverlay(BuildContext context,
    {String? title, String? message, String? okLabel}) async {
  return await showOkAlertDialog(
      context: context, title: title, message: message, okLabel: okLabel);
}

Future<dynamic> loadingOverlay(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      backgroundColor: kTransparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: CircleAvatar(
        radius: 60,
        backgroundColor: kWhiteColor,
        child: Lottie.asset('assets/images/loading.json'),
      ),
    ),
  );
}

Future<dynamic> loadingStatusDialog(BuildContext context,
    {required String title}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      backgroundColor: kWhiteColor,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        const LoadingWidget(height: 70),
        KText(text: title, fontWeight: FontWeight.bold, fontSize: 16),
        const SizedBox(width: 8)
      ]),
    ),
  );
}


class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key, this.height}) : super(key: key);
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/json/loading1.json', height: height);
  }
}
