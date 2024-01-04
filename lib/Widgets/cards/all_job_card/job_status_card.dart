import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/enums.dart';
import '../../../controller/trip_controller/trip_controller.dart';
StatelessWidget loadStatus(
    String status, DateTime pickupDate, String id, BuildContext context) {
  final allJobViewModel = Get.put(AllJobViewModel());
  if (status == "available") {
    DateTime date = DateTime.parse(DateFormat("yyyy-MM-dd").format(pickupDate));
    DateTime todayDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now())); //DateTime.now().day.toString();
    var yesterday = todayDate.subtract(Duration(days: 1)).toString();
    var tomorrow = todayDate.add(Duration(days: 1));
    if( date.isAtSameMomentAs(todayDate)){
      return InkWell(
        onTap: (){
          // allJobViewModel.startTrip(id);
        },
        child: Container(
          width: 80,
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              color: Colors.green.shade300,
              borderRadius: new BorderRadius.all(Radius.circular(5))),
          child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                JobStatus.Start.name,
                style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              )),
        ),
      );
    }
    else if(date.isAfter(todayDate)){
      return Container(
        width: 80,
        alignment: Alignment.center,
        decoration: new BoxDecoration(
            color: kBlueColor.withOpacity(0.3),
            borderRadius: new BorderRadius.all(Radius.circular(5))),
        child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "Pending",
              style: TextStyle(
                  color: kWhiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
            )),
      );
    }
    else{
      return Container(
        width: 80,
        alignment: Alignment.center,
        decoration: new BoxDecoration(
            color: kErrorColor.withOpacity(0.3),
            borderRadius: new BorderRadius.all(Radius.circular(5))),
        child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "Expired",
              style: TextStyle(
                  color: kWhiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
            )),
      );
    }
  } else if (status == "in-transit") {
    return InkWell(
      onTap: (){
        // allJobViewModel.completeTrip(id);
      },
      child: Container(
        width: 90,
        alignment: Alignment.center,
        decoration: new BoxDecoration(
            color: Colors.blueAccent[100],
            borderRadius: new BorderRadius.all(Radius.circular(5))),
        child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "Complete",
              style: TextStyle(
                  color: kWhiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
            )),
      ),
    );
  } else if (status == "completed") {
    return Container(
      width: 100,
      alignment: Alignment.center,
      decoration: new BoxDecoration(
          color: kMainColor.withOpacity(0.5),
          borderRadius: new BorderRadius.all(Radius.circular(5))),
      child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            JobStatus.Completed.name,
            style: TextStyle(
                color: kWhiteColor,
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
          )),
    );
  }
  else if (status == "started") {
    return InkWell(
      onTap: (){
        // allJobViewModel.pickupTrip(id);
      },
      child: Container(
        width: 80,
        alignment: Alignment.center,
        decoration: new BoxDecoration(
            color: Colors.green.shade300,
            borderRadius: new BorderRadius.all(Radius.circular(5))),
        child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "Pick Up",
              style: TextStyle(
                  color: kWhiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
            )),
      ),
    );
  }
  else {
    return Container(
      decoration: new BoxDecoration(
          color: Colors.orange,
          borderRadius: new BorderRadius.all(Radius.circular(5))),
      child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            'No Status',
            style: Theme.of(context).textTheme.bodyText1,
          )),
    );
  }
}