import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';

class KElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed, onDisableTap;
  final Color backgroundColor;
  final String title;
  final RxBool isEnable;
  const KElevatedButton({Key? key, required this.title, required this.isEnable,this.onDisableTap, this.onPressed, this.backgroundColor = kMainColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => InkWell(
      child: ElevatedButton(
        style: isEnable.value ? ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),) :
        ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(kBlueColor.withOpacity(0.3)),),
        onPressed: isEnable.value ? onPressed: onDisableTap,
        child: Text(
          title,
          style:  TextStyle(
              color: isEnable.value ? kWhiteColor : kWhiteColor,
              fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    ),);
  }
}

class CheckButton extends StatelessWidget {
  String title;
  final VoidCallback? onPressed;
 CheckButton({Key? key, required this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Ink(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 10), // changes position of shadow
            ),
          ],
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.green],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: 40,
          alignment: Alignment.center,
          child: Text(
          title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}