import 'package:get/get.dart';

import 'logic.dart';

class NotePadBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotePadLogic>(() => NotePadLogic());
  }
}
