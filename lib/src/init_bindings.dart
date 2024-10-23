import 'package:get/get.dart';
import 'package:wey_commerce_app/src/pages/home/controller/home_controller.dart';

class InitBindings implements Bindings {
  @override
  void dependencies() {
    /// Api
    Get.put<HomeController>(HomeController(), permanent: true);
  }
}
