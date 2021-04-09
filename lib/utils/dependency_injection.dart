/*
 * @Author: your name
 * @Date: 2020-12-08 20:57:12
 * @LastEditTime: 2020-12-11 01:38:08
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /todo/lib/utils/dependency_injection.dart
 */
import 'package:get/get.dart';
import 'package:todo/data/providers/app_sp_service.dart';
import 'package:todo/data/providers/dio_config_service.dart';
import 'package:todo/data/providers/login_provider.dart';
import 'package:todo/data/providers/task_dao_service.dart';
import 'package:todo/data/remote/dio_client.dart';

/// 依赖注入
class DenpendencyInjection {
  static Future<void> init() async {
    // shared_preferences
    // 判断用户是否已经登录，登录和注册的时候会将信息存入用户设备
    // putAsync 异步put，只有当用到的时候才会初始化
    // AppSpController() 之后在 LoginProvider处被调用，用于检测登录状态
    await Get.putAsync(() => AppSpController().init());
    // dio配置信息, 用于网络请求的初始化设置
    // putAsync 异步put，只有当用到的时候才会初始化
    await Get.putAsync(() => DioConfigController().init());
    //  网络请求，创建一个 DioClient 类型的 Object，之后会用到（使用find从hashmap中找出来使用）
    Get.put(DioClient());
    // 登录信息提供者，会检查 SharedPreferences 中是否存有用户登录信息，如果有就直接登录
    // 如果没有则会要求用户登录，从 SplashScreen 不会直接进入 home，而是进入 Login
    Get.put(LoginProvider());
    // 数据库
    Get.put(TaskDaoController().init());
  }
}
