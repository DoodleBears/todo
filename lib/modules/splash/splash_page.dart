/*
 * @Author: your name
 * @Date: 2020-12-08 20:56:00
 * @LastEditTime: 2020-12-12 14:38:37
 * @LastEditors: your name
 * @Description: In User Settings Edit
 * @FilePath: /todo/lib/modules/splash/splash_page.dart
 */
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:todo/modules/splash/splash_controller.dart';
import 'package:todo/r.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashController>(
        // 当我们 builder 中的变量用  _ 下划线来表示的时候，一般是说，我们在这个builder中没用到这个传入的变量的function
        builder: (_) {
          return Column(
            children: [
              SizedBox(
                height: 120,
              ),
              Text(
                'WELCOME TO HERE',
                // 通过 Theme.of(context) 调用App主题中的颜色，字体大小等
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    // copyWith主要作用是：复制上面的 Data，并单独修改其中某些内容
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 120,
              ),
              Image.asset(
                R.assetsImagesSplash, //使用Class调用内置图片地址
                fit: BoxFit.fitWidth,
              ),
            ],
          );
        },
      ),
    );
  }
}
