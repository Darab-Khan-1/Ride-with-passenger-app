import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Constants/colors.dart';
import 'logging.dart';

class Common {
  static void showDioErrorDialog(BuildContext context,
      {required DioException e}) {
    showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: const Text('Oops!'),
        content: Text(getErrorMsgOfDio(e)),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }

  static String getErrorMsgOfDio(DioException e) {
    try {
      Logger.error(
          'Status Code: ${e.response?.statusCode} - Body: ${e.response?.data}');
      String errorMsg = 'Please, check your internet connection';
      if (e.response?.statusCode == 406) {
        errorMsg = '${e.response?.data}';
      } else if (e.response != null && e.response!.data != null) {
        log('*****');
        if (e.response!.data.runtimeType == String) {
          errorMsg = e.response!.data;
        } else if (e.response!.data['detail'] != null) {
          log('121');
          errorMsg = e.response!.data['detail'].toString();
        } else if (e.response!.data['message'] != null) {
          log('121');
          errorMsg = e.response!.data['message'].toString();
        } else if (e.response?.data['error'] != null) {
          log('111');
          errorMsg = e.response!.data['error'].toString();
        } else {
          log('2222');
          errorMsg = e.response!.data.toString();
        }
      } else if (e.message != null) {
        log('23452');
        errorMsg = e.message!;
      }
      return errorMsg;
    } catch (e) {
      Logger.error('Errorexxx: $e');
      return 'Something went wrong';
    }
  }

  static Future<bool?> showOkCancelAdaptiveDialog(
    BuildContext context, {
    String? title,
    Widget? content,
    String? okLabel,
    String? cancelLabel,
    bool isDestructveAction = false,
    bool isPrimaryAction = false,
  }) async {
    return showAdaptiveDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: title != null ? Text(title) : null,
            content: content,
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: kBlackColor,
                ),
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  cancelLabel ?? 'Cancel',
                  style: const TextStyle(fontWeight: FontWeight.w300),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: isDestructveAction ? kSecondaryColor : null,
                ),
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  okLabel ?? 'Ok',
                  style: TextStyle(
                      fontWeight: isPrimaryAction ? FontWeight.w500 : null),
                ),
              ),
            ],
          );
        });
  }
}
class AppSnackbar {
  static void showErrorSnackBar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: kErrorColor,
      colorText: kWhiteColor,
      icon: const Icon(
        Icons.error_outline,
        color: kWhiteColor,
      ),
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      duration: const Duration(seconds: 3),
    );
  }

  static void showWarningSnackbar(String message) {
    Get.snackbar(
      'Warning',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: kErrorColor,
      colorText: kWhiteColor,
      icon: const Icon(
        Icons.warning_amber_outlined,
        color: kWhiteColor,
      ),
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      duration: const Duration(seconds: 3),
    );
  }

  static void showSuccessSnackbar(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: kGreenColor,
      colorText: kWhiteColor,
      icon: const Icon(
        Icons.check_circle_outline,
        color: kWhiteColor,
      ),
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      duration: const Duration(seconds: 3),
    );
  }
}
