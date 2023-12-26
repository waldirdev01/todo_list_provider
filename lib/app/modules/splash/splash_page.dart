import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_logo.dart';

import '../../core/auth/app_auth_provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    //final provider = context.read<AppAuthProvider>().logout();
    return Scaffold(
        appBar: AppBar(
          title: Text('SplashPage'),
        ),
        body: Center(child: TodoListLogo()));
  }
}
