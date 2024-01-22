import 'package:flutter/material.dart';
import 'package:ride_with_passenger/Widgets/form_fields/k_text.dart';
import 'package:ride_with_passenger/constants/colors.dart';

class CustomAlertDialog extends StatelessWidget {
  final String? title;
  final Widget? content;
  final VoidCallback? onPressed;
  const CustomAlertDialog({Key? key, this.onPressed, this.title, this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      title: KText(text: title!, color: Colors.black, fontSize: 18),
      content: content,
      backgroundColor: kWhiteColor,
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

class KAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final void Function()? cancelOnPressed;
  final void Function()? okOnPressed;
  final bool isCancel;
  final bool isOk;
  const KAlertDialog({super.key, required this.title, this.cancelOnPressed, this.okOnPressed, required this.isCancel, required this.isOk, required this.content});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      title:  Text(title),
      content: SizedBox(
        width: size.width,
        height: size.height * 0.2,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index){
                    return ListTile(
                      title: Text(content),
                      focusColor: kMainColor,
                      // Customize the design of each list item here
                      // For example, you can add icons, different text styles, etc.
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                isCancel? ElevatedButton(onPressed: cancelOnPressed, child: KText(text: "No", color: kMainColor,)):Container(),
                isOk?
                ElevatedButton(onPressed: okOnPressed, child: KText(text: "Yes", color: kMainColor,)): Container(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
