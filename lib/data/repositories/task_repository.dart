/*
 * @Author: your name
 * @Date: 2020-12-08 20:57:12
 * @LastEditTime: 2020-12-13 01:34:47
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /todo/lib/data/repositories/task_repository.dart
 */
import 'package:get/get.dart' hide Value;
import 'package:moor/moor.dart';
import 'package:todo/data/api/task_api.dart';
import 'package:todo/data/db/task_dao.dart';
import 'package:todo/data/db/task_database.dart';
import 'package:todo/data/model/task_model.dart';
import 'package:todo/data/providers/login_provider.dart';

class TaskRepository {
  // api 用于网络请求
  final TaskApi api = Get.find<TaskApi>();
  // DAO 用于本地存储，数据持久化
  // TaskDao 在一开始 dependency_injection.dary
  // 通过 Get.put(TaskDaoController().init()) 注入
  final TaskDao taskDao = Get.find<TaskDao>();
  // loginProvider 用来判断是否登录（登录状态）
  final LoginProvider loginProvider = Get.find<LoginProvider>();

  Future<TaskModel> getTask({int pageNum = 1}) async {
    // 在登录状态下，从 remote Database 获取资料，并存入 local Database
    if (loginProvider.isLogin()) {
      try {
        // 网络请求 remote Database 的 data
        TaskModel model = await api.getTasks(pageNum: pageNum);
        //** 如果 data 不为空,
        //** 就 insert 到本地 local DB
        //** 然后下面的 var data = await taskDao.getTasks() 再从local取得资料
        if (model.datas.isNotEmpty == true)
          await taskDao.insertMultipleTasks(model.datas);
      } catch (e) {
        print('TaskRepository==getTask:$e');
      }
    }
    // 有无网络连接，都从 local DB 取得资料（LINE消息等都会存在本机，即使断网也能打开）
    //** 如果有网络, 再上面会先从 remote DB 取得资料, 然后insert到 local DB */
    // 这就是所谓的缓存文件，注意这边调用的是 taskDao，上面try中，先调用 api，在调用 taskDao，插入本地
    var data = await taskDao.getTasks(20, offset: (pageNum - 1) * 20);
    TaskModel model = TaskModel(
        curPage: pageNum,
        datas: data,
        // over 判断条件：数据量小于20笔，则可以知道 Database 中一个page 有 20笔 data
        // 若回传的 data 长度不足20 说明这应该是最后一页了
        over: ((data?.length ?? 0 < 20) == true));
    return model;
  }

  Future<Task> addTask(String title,
      {String content, String date, int type = 0, int priority = 0}) async {
    Task task;
    if (loginProvider.isLogin()) {
      try {
        task = await api.addTask(title,
            content: content, date: date, type: type, priority: priority);
      } catch (e) {
        print('TaskRepository==addTask:$e');
      }
    }
    TasksCompanion tasksCompanion = TasksCompanion(
      title: Value(task?.title ?? title),
      content: Value(task?.content ?? content),
      id: task?.id == null ? Value<int>.absent() : Value(task?.id),
      date: Value(task?.date ??
          DateTime.parse(task?.dateStr ?? date).microsecondsSinceEpoch),
      dateStr: Value(task?.dateStr ?? date),
      type: Value(task?.type ?? type),
      priority: Value(task?.priority ?? priority),
    );
    return await taskDao.createTask(tasksCompanion);
  }

  Future<bool> deleteTask(int id) async {
    if (loginProvider.isLogin()) {
      try {
        await api.deleteTask(id);
      } catch (e) {
        print('TaskRepository==deleteTask:$e');
      }
    }
    int row = await taskDao.deleteTaskById(id);
    return row > 0;
  }

  Future<void> modifyTaskStatus(Task task) async {
    if (loginProvider.isLogin()) {
      try {
        await api.modifyTaskStatus(task.id, task.status);
      } catch (e) {
        print('TaskRepository==modifyTaskStatus:$e');
      }
    }
    taskDao.modifyTask(task);
  }

  Future<void> updateTask(Task task) async {
    if (loginProvider.isLogin()) {
      try {
        await api.updateTask(
            id: task.id,
            title: task.title,
            content: task.content,
            date: task.dateStr,
            status: task.status,
            type: task.type,
            priority: task.priority);
      } catch (e) {
        print('TaskRepository==updateTask:$e');
      }
    }
    await taskDao.modifyTask(task);
  }
}
