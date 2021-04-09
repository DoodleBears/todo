/*
 * @Author: your name
 * @Date: 2020-12-08 20:56:00
 * @LastEditTime: 2020-12-11 23:06:07
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /todo/lib/main.dart
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/modules/splash/splash_binding.dart';
import 'package:todo/modules/splash/splash_page.dart';
import 'package:todo/routes/app_pages.dart';
import 'package:todo/theme/app_theme.dart';

import 'utils/dependency_injection.dart';
import 'utils/gloab_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GloabConfig.init();
  // 初始依赖注入，包括：1.登录状态 2.网络请求功能 3.登录功能 4.数据库功能
  await DenpendencyInjection.init();
  runApp(GetMaterialApp(
    // 取消显示右上角的 Debug mode 标志
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.INITIAL, // 设置初始路由 route 为 '/'
    builder: (context, child) => Scaffold(
      // Global GestureDetector that will dismiss the keyboard
      body: GestureDetector(
        onTap: () {
          hideKeyboard(context); // 让用户可以点击其他地方取消 focus（聚焦）
        },
        child: child,
      ),
    ),
    theme: appThemeData, // 设置 App 主题，主要是方便接下来不同页面调用 颜色主题
    defaultTransition: Transition.fade, // 默认页面切换效果 —— 淡入淡出(fade)
    getPages:
        AppPages.pages, // 初始化页面 Route 路由信息（路由信息包含 Dependency Injection 的数据等）
    initialBinding: SplashBinding(), // 初始界面的 Bingding信息
    home: SplashPage(),
  ));
}

// 让用户可以点击其他地方取消 focus（聚焦）， 类似于点击界面其他地方，来达到取消的效果
void hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus.unfocus();
  }
}
