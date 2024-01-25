import 'package:flutter/material.dart';
import 'package:ride_with_passenger/Widgets/form_fields/k_text.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../constants/colors.dart';
import '../form_fields/expandable_text.dart';

class kRowWithAddress extends StatelessWidget {
  final String address;
  final double nextLat;
  final double nextLong;
  const kRowWithAddress({super.key, required this.address, required this.nextLat, required this.nextLong});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KText(text: "Next Stop", color: kBlackColor, fontSize: 16, fontWeight: FontWeight.w500,),
            ExpandableText(text:
            address,
              style: const TextStyle(
                color: kBlackColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),),
          ],
        ),

        InkWell(
          onTap: () {
            launchUrlString(
                'https://www.google.com/maps/search/?api=1&query=${nextLat},${nextLong}');
          },
          child: const Column(
            children: [
              Icon(
                Icons.directions,
              ),
              Text("Directions")
            ],
          ),
        )
      ],
    );
  }
}
