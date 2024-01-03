import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/notifier/default_listener_notofier.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/modules/task/task_create_controller.dart';
import 'package:todo_list_provider/app/modules/task/widgets/calendar_button.dart';
import 'package:validatorless/validatorless.dart';

class TaskCreatePage extends StatefulWidget {
  final TaskCreateController _controller;

  TaskCreatePage({super.key, required TaskCreateController controller})
      : _controller = controller;

  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  final _formKey = GlobalKey<FormState>();

  final _descriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(changeNotifier: widget._controller).listener(
      context: context,
      successCallBack: (notifier, listernerIntance) {
        listernerIntance.dispose();
        Navigator.of(context).pop();
      },
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primaryColor.withOpacity(0.8),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Criar tarefa'),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Criar Atividade',
                    style: context.titleStyle.copyWith(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: Colors.white)),
                  ),
                  style: const TextStyle(color: Colors.white),
                  validator: Validatorless.required('Descrição obrigatória'),
                ),
                const SizedBox(
                  height: 20,
                ),
                CalendarButton(),
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton.extended(
          shape: ShapeBorder.lerp(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(color: Colors.white)),
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(color: Colors.white)),
              1),
          backgroundColor: context.primaryColor,
          onPressed: () {
            final formValid = _formKey.currentState?.validate() ?? false;
            if (formValid) {
              widget._controller.save(_descriptionController.text);
            }
          },
          label: const Text(
            'Salvar',
            style: TextStyle(color: Colors.white, fontSize: 20),
          )),
    );
  }
}
