import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:ride_with_passenger/view/history_screen/history_screen.dart';
import 'package:ride_with_passenger/view/home_screen/home_screen.dart';
import 'package:ride_with_passenger/view/profile_screen/profile_screen.dart';
import 'package:ride_with_passenger/view/trips_screen/trips_screen.dart';
import '../../constants/colors.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _tabController.dispose();
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _key,
      // appBar: AppBar(
      //   title: Text(
      //     _getScreenName(_tabController.index),
      //   ),
      //   leading:  const SizedBox(),
      // ),
      backgroundColor: kWhiteColor,
      bottomNavigationBar: MotionTabBar(
        initialSelectedTab: "Home",
        labels: const ["Home","TRIPS", "HISTORY", "Profile", ],
        icons: const [
          Icons.map_outlined,
          Icons.cable_rounded,
          Icons.history,
          Icons.account_circle_rounded,

        ],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: kBlackColor,
          fontWeight: FontWeight.w500,
        ),
        useSafeArea: false,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: kMainColor,
        tabIconSelectedColor: kWhiteColor,
        onTabItemSelected: (int value) {
          setState(() {
            _tabController.index = value;
          });
        },
      ),
      body: Container(
        child: TabBarView(
          viewportFraction: 1,
          physics:
          const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children:  [
            HomeScreen(),
            TripsScreen(),
            HistoryScreen(),
            ProfileScreen()

          ],
        ),
      ),
    );
  }

  String _getScreenName(int index) {
    switch (index) {
      case 0:
        return 'Map';
      case 1:
        return 'Trips';
      case 2:
        return 'History';
      case 3:
        return 'Profile';
      default:
        return 'Unknown';
    }
  }
  // Widget  tabIcons(){
  //   switch(_tabController.index){
  //     case 0:
  //       return SizedBox();
  //     case 1:
  //       return  TextButton(onPressed: (){
  //         inspectionCtrl.getInspectionQuestions();
  //         Get.to(CreateInspectionScreen());
  //       }, child: KText(text: "Create", color: kWhiteColor, fontSize: 16, fontWeight: FontWeight.w500,));
  //     case 2:
  //       return  IconButton(
  //         icon: Image.asset("assets/images/switch.png",width: 25,height: 25,),
  //         onPressed: () {
  //           UserPreference().removeUser();
  //           Get.offAll(SplashScreen());
  //         },
  //       );
  //     case 3:
  //       return  SizedBox();
  //     case 4:
  //       return IconButton(
  //         icon: Icon(Icons.lock, color: kWhiteColor),
  //         onPressed: () {
  //           Get.to(ChangePasswordScreen());
  //         },
  //       );
  //     default:
  //       return SizedBox();
  //   }
  // }
}
