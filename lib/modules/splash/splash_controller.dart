import 'package:get/get.dart';
import 'package:todo/data/providers/login_provider.dart';
import 'package:todo/routes/app_pages.dart';

class SplashController extends GetxController {
  // 即，调用阶段，往往是进入某个页面，展示某个元素时，当我们用 GetBuilder<SplashController>
  // 的时候，便会唤起 onReady()
  @override
  void onReady() async {
    super.onReady();

    await Future.delayed(Duration(seconds: 3)); // 一般等3秒是为了让用户看广告（advertisement）
    // 在 main 的时候我们 put() 的 LoginProvider 我们这时候 find() 出来用
    LoginProvider loginProvider = Get.find<LoginProvider>();
    print(loginProvider);
    // 如果未登录就登录
    // 如果已登录就去task页面
    if (loginProvider.isLogin()) {
      // offNamed 即从 Navigation Stack，中删除
      // 此时我们手机按back后退键，不会回到上一界面，而会直接退出（几乎所有App都会这么设计）
      Get.offNamed(Routes.TASK);
    } else {
      Get.offNamed(Routes.LOGIN);
    }
  }
}
