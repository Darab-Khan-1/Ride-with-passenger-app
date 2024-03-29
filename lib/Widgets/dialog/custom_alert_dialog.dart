import 'package:flutter/material.dart';
import 'package:ride_with_passenger/Widgets/form_fields/k_text.dart';

class CustomAlertDialog extends StatelessWidget {
  String? title;
  Widget? content;
  final VoidCallback? onPressed;
  CustomAlertDialog({Key? key, this.onPressed, this.title, this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      title: KText(text: title!, color: Colors.black, fontSize: 18),
      content: content,
      actions: [
        // Define actions like "OK" button
        TextButton(
          onPressed: () {
            // Close the dialog
            Navigator.of(context).pop();
          },
          child: KText(text: "OK", color: Colors.black, fontSize: 16)
        ),
      ],
    );
  }
}