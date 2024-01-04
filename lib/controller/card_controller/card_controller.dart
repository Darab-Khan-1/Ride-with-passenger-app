import 'package:get/get.dart';

class CardController extends GetxController {
  RxDouble cardHeight = 300.0.obs; // initial value of the height
  double initialHeight = 300.0; // initial height
  double shrunkHeight = 150.0; // shrunk height
  RxBool isExpanded = true.obs;

  void toggleCardVisibility() {
    isExpanded.value = !isExpanded.value;
  }

  void toggleCardSize() {
    if (cardHeight.value == initialHeight) {
      cardHeight.value = shrunkHeight;
    } else {
      cardHeight.value = initialHeight;
    }
  }
}