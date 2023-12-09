import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/notifier/default_listener_notofier.dart';
import 'package:todo_list_provider/app/modules/auth/register/register_controller.dart';
import 'package:validatorless/validatorless.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_field.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_logo.dart';
import '../../../core/validators/validators.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailEC = TextEditingController();

  final _passwordEC = TextEditingController();

  final _confirmPasswordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final defaultListener = DefaultListenerNotifier(
        changeNotifier: context.read<RegisterController>());
    defaultListener.listener(
        context: context,
        successCallBack: (notifier, listenerInstance) {
          listenerInstance.dispose();
          Navigator.of(context).pop();
        },
        errorCallback: (notifier, listenerInstance) {
          print('Erro ao registrar usuário');
        });
  }

//TODO integrando a tela de login
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
              child: TodoListLogo(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TodoListField(
                      controller: _emailEC,
                      label: 'E-mail',
                      validator: Validatorless.multiple([
                        Validatorless.required('E-mail obrigatório'),
                        Validatorless.email('E-mail inválido'),
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TodoListField(
                      controller: _passwordEC,
                      label: 'Senha',
                      validator: Validatorless.multiple([
                        Validatorless.required('Senha obrigatória'),
                        Validatorless.min(6, 'Senha muito curta'),
                      ]),
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TodoListField(
                      controller: _confirmPasswordEC,
                      label: 'Confirme asenha',
                      obscureText: true,
                      validator: Validatorless.multiple([
                        Validatorless.required('Senha obrigatória'),
                        Validatorless.min(6, 'Senha muito curta'),
                        Validators.compare(_passwordEC, 'Senhas não coincidem'),
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            textStyle: context.titleStyle,
                            backgroundColor: context.elevateseButtonColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () {
                          final formValid =
                              _formKey.currentState?.validate() ?? false;
                          if (formValid) {
                            final email = _emailEC.text;
                            final password = _passwordEC.text;
                            context
                                .read<RegisterController>()
                                .registerUser(email, password);
                          }
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
