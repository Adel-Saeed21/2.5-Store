import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';


class Homecotroller extends GetxController {
  static Homecotroller get instance => Get.find();
  final currentIndex = 0.obs;
  void updatePageIndex(index) {
    currentIndex.value = index;
  }
}
