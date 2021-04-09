/*
 * @Author: your name
 * @Date: 2020-12-08 20:57:12
 * @LastEditTime: 2020-12-11 00:53:29
 * @LastEditors: your name
 * @Description: In User Settings Edit
 * @FilePath: /todo/lib/data/providers/login_provider.dart
 */
import 'package:todo/data/local/local_login_model_reposity.dart';

class LoginProvider {
  // 在涉及需要用户登录后才能操作的功能上，都会事先check一遍登录状态，就会调用这个function
  bool isLogin() {
    // 获得login状态的Model，来判断 —— 如果是null则未登录
    return LocalLoginModelRepository.getLoginModel() != null;
  }
}
