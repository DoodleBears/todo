/*
 * @Author: your name
 * @Date: 2020-12-08 20:57:12
 * @LastEditTime: 2020-12-13 01:24:32
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /todo/lib/modules/login/login_controller.dart
 */
import 'package:get/get.dart';
import 'package:todo/data/model/login_bean.dart';
import 'package:todo/data/local/local_login_model_reposity.dart';
import 'package:todo/data/repositories/login_repository.dart';
import 'package:todo/routes/app_pages.dart';
import 'package:todo/utils/extension/get_extension.dart';

class LoginController extends GetxController {
  // 这里的 repository 其实就是 Model（MVC中的M）
  final LoginRepository repository = Get.find<LoginRepository>();
  String _username;
  String _password;

  void onUsernameChanged(String username) {
    _username = username.trim();
  }

  void onPasswordChanged(String password) {
    _password = password.trim();
  }

  // 应该是 submit
  // view 层调用 LoginController    的该 sumit function
  // [LoginController 的 sumit]     由此 调用 Respository 中的 login function
  // [Respository 的 login]         调用 LoginApi 的 login function
  // [LoginApi 的 login]            通过dio，https 与 Database 做交互
  sumit() async {
    if (_username == null || _username.trim.toString().isEmpty) {
      Get.snackbar('Hi', 'Your Email not be null');
      return;
    }

    if (_password == null || _password.trim.toString().isEmpty) {
      Get.snackbar('Hi', 'Your Password not be null');
      return;
    }
    Get.loading(); // 跳出 loading 转圈画面
    try {
      LoginBean bean = await repository.login(_username, _password);
      Get.dismiss(); // 关闭 loading 转圈画面
      LocalLoginModelRepository.saveLoginModel(bean);
      Get.offAllNamed(Routes.TASK);
    } catch (e) {
      Get.dismiss(); // 关闭 loading 转圈画面
      Get.snackbar('Error', e.message ?? "登录失败");
    }
  }
}
