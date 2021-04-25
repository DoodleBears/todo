/*
 * @Author: your name
 * @Date: 2020-12-09 20:10:32
 * @LastEditTime: 2020-12-09 23:14:37
 * @LastEditors: your name
 * @Description: In User Settings Edit
 * @FilePath: /todo/lib/modules/task/monthly/monthly_binding.dart
 */
import 'package:get/get.dart';
import 'package:todo/data/api/task_api.dart';
import 'package:todo/data/repositories/task_repository.dart';
import 'package:todo/modules/task/monthly/monthly_controller.dart';

// 实现 Bindings 来用于 getPages 初始化时候 binding 用
// 采用 lazyPut，仅当需要用到该 Controller 时候注册 Controller（事先binding好，可以提高效率
// 按住 ctrl 点击 class 名，可以跳转到用 Class 的地方
class MonthlyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskApi>(() => TaskApi());
    Get.lazyPut<TaskRepository>(() => TaskRepository());
    Get.lazyPut<MonthlyController>(() => MonthlyController());
  }
}
