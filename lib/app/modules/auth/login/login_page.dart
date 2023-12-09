import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/notifier/default_listener_notofier.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_field.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_logo.dart';
import 'package:todo_list_provider/app/modules/auth/login/login_controller.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(changeNotifier: context.read<LoginController>())
        .listener(
      context: context,
      successCallBack: (notifier, listenerInstance) {
        debugPrint('sucesso');
      },
    );
  }

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constrains) {
        return SingleChildScrollView(
            child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constrains.maxHeight,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TodoListLogo(),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TodoListField(
                            label: 'e-mail',
                            controller: _emailEC,
                            suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.email)),
                            validator: Validatorless.multiple([
                              Validatorless.required('Campo obrigatório'),
                              Validatorless.email('E-mail inválido')
                            ]),
                          ),
                          const SizedBox(height: 10),
                          TodoListField(
                              label: 'senha',
                              obscureText: true,
                              controller: _passwordEC,
                              validator: Validatorless.multiple([
                                Validatorless.required('Campo obrigatório'),
                                Validatorless.min(
                                    6, 'Senha deve ter no mínimo 6 caracteres')
                              ])),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text('Esqueceu a senha?',
                                    style: context.titleStyle),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: context.elevateseButtonColor,
                                  textStyle: context.titleStyle,
                                ),
                                onPressed: () {
                                  final formValid =
                                      _formKey.currentState!.validate() ??
                                          false;
                                  if (formValid) {
                                    final email = _emailEC.text;
                                    final password = _passwordEC.text;
                                    context
                                        .read<LoginController>()
                                        .login(email, password);
                                  }
                                },
                                child: Text(
                                  'Login',
                                  style: context.titleStyle,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
                const SizedBox(),
                Expanded(
                    child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              width: 1, color: Colors.black.withAlpha(50))),
                      color: const Color.fromARGB(15, 116, 114, 119)),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      SignInButton(
                        Buttons.Google,
                        text: 'Login com Google',
                        onPressed: () {},
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Não tem conta?',
                              style: context.titleStyle,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/register');
                              },
                              child: Text(
                                'Cadastre-se',
                                style: context.titleStyle,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ));
      }),
    );
  }
}
