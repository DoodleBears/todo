/*
 * @Author: your name
 * @Date: 2020-12-08 20:57:12
 * @LastEditTime: 2020-12-13 01:22:52
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /todo/lib/data/repositories/login_repository.dart
 */
import 'package:get/get.dart';
import 'package:todo/data/api/login_api.dart';
import 'package:todo/data/model/login_bean.dart';

class LoginRepository {
  // 这里的 api 其实是作者将 网络请求和 Model 层分开，单独来写
  final LoginApi api = Get.find<LoginApi>();

  Future<LoginBean> login(String username, String password) {
    return api.login(username, password);
  }

  Future<LoginBean> register(
      String username, String password, String repassword) {
    return api.register(username, password, repassword);
  }
}
