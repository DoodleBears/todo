import 'package:get/get.dart';
import 'package:todo/modules/login/login_binding.dart';
import 'package:todo/modules/login/login_page.dart';
import 'package:todo/modules/profile/profile_page.dart';
import 'package:todo/modules/signup/sign_up_binding.dart';
import 'package:todo/modules/signup/sign_up_page.dart';
import 'package:todo/modules/splash/splash_binding.dart';
import 'package:todo/modules/splash/splash_page.dart';
import 'package:todo/modules/task/add/add_task_binding.dart';
import 'package:todo/modules/task/add/add_task_page.dart';
import 'package:todo/modules/task/details/task_details.dart';
import 'package:todo/modules/task/edit/edit_task_binding.dart';
import 'package:todo/modules/task/edit/edit_task_page.dart';
import 'package:todo/modules/task/monthly/monthly_binding.dart';
import 'package:todo/modules/task/monthly/monthly_page.dart';
import 'package:todo/modules/task/task/task_binding.dart';
import 'package:todo/modules/task/task/task_page.dart';
part './app_routes.dart';

abstract class AppPages {
  // A list of <GetPage> 来表示不同页面的 name、binding 和 route 信息等
  static final pages = [
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.SIGN_UP,
      page: () => SignUpPage(),
      binding: SiginUpBinding(),
    ),
    GetPage(
      name: Routes.TASK,
      page: () => TaskPage(),
      binding: TaskBinding(),
    ),
    GetPage(
      name: Routes.TASK_ADD,
      page: () => AddTaskPage(),
      binding: AddTaskBinding(),
    ),
    GetPage(
      name: Routes.TASK_DETAILS,
      page: () => TaskDetailsPage(),
    ),
    GetPage(
      name: Routes.TASK_EDIT,
      page: () => EditTaskPage(),
      binding: EditTaskBinding(),
    ),
    GetPage(
      name: Routes.TASK_MOTHLY,
      page: () => MonthlyPage(),
      binding: MonthlyBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfilePage(),
    ),
  ];
}
