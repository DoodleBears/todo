import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/data/model/login_bean.dart';

class LocalLoginModelRepository {
  static final String keyLoginModel = 'key_login_model';

  // 登录和注册之后都会调用下面这个 Function，用来存储用户登录信息在用户设备的 disk 上，方便下次自动登录
  static saveLoginModel(LoginBean bean) {
    SharedPreferences sp = Get.find<SharedPreferences>();
    sp.setString(keyLoginModel, jsonEncode(bean.toJson()));
  }

  static LoginBean getLoginModel() {
    // 此时之前异步put的putAsync() 的 SharedPreferences 被find()调用，
    SharedPreferences sp = Get.find<SharedPreferences>();
    try {
      // 试图从sp中getString，看看有没有这个key-value，pair，如果没有说明之前未登录过（没有存储登录状态到 disk）
      // 此时会 getString 会出发 error被catch，然后return null，说明用户未登录，需要再登录
      var json = sp.getString(keyLoginModel);
      return LoginBean.fromJson(jsonDecode(json));
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
