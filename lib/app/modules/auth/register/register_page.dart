import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_field.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_logo.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black38,
        elevation: 2,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('TODO LIST', style: context.titleStyle),
              Text('Informe seus dados para cadastrar-se',
                  style: context.titleStyle)
            ],
          ),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: ClipOval(
                child: Container(
                    padding: const EdgeInsets.all(8),
                    color: context.primaryColor,
                    child: const Icon(Icons.arrow_back_ios_outlined,
                        size: 20, color: Colors.white)))),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: const FittedBox(
              child: TodoListLog(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Form(
                child: Column(
              children: [
                TodoListField(label: 'E-mail'),
                const SizedBox(
                  height: 20,
                ),
                TodoListField(
                  label: 'Senha',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                TodoListField(
                  label: 'Confirme asenha',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: context.titleStyle,
                      primary: context.elevateseButtonColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    child: Text(
                      'Cadastrar',
                      style: context.titleStyle,
                    ),
                  ),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
