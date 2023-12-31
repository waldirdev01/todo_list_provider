import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/database/sqlite_admin.dart';
import 'package:todo_list_provider/app/core/navigator/todo_navigator.dart';
import 'package:todo_list_provider/app/core/ui/todo_list_ui_config.dart';
import 'package:todo_list_provider/app/modules/auth/auth_module.dart';
import 'package:todo_list_provider/app/modules/home/home_module.dart';
import 'package:todo_list_provider/app/modules/splash/splash_page.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final sqliteAdminConnection = SqliteAdminConnection();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(sqliteAdminConnection);
    // ignore: unused_local_variable
    final auth = FirebaseAuth.instance;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(sqliteAdminConnection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List Provider',
      theme: TodoListUiConfig.themeCustom,
      navigatorKey: TodoListNavigator.navigatorKey,
      routes: {
        ...AuthModule().routes,
        ...HomeModule().routes,
      },
      home: const SplashPage(),
    );
  }
}
