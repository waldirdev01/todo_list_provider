import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/ui/todo_list_icons.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_drawer.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_filters.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_header.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_week_filter.dart';
import 'package:todo_list_provider/app/modules/home/widgets/task.dart';
import 'package:todo_list_provider/app/modules/task/task_create_page.dart';
import 'package:todo_list_provider/app/modules/task/task_module.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  /* void _goToCreateTask(BuildContext context) {
     Navigator.of(context).pushNamed('/task/create'); primera forma (tradicional)
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => TaskModule().getPage('/task/create', context), aqui foi só pra se exibir
    ));
  }*/

  void _goToCreateTask(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secundaryAnimation, child) {
          animation =
              CurvedAnimation(parent: animation, curve: Curves.easeInSine);
          return ScaleTransition(
            scale: animation,
            alignment: Alignment.bottomRight,
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) =>
            TaskModule().getPage('/task/create', context)));
  }
  //o probelma: como passar a controller? se apenas passar o context.read() dá um erro
  //porque o TaskCreateController está abaixo na hierarquia de dependências. A solucao é passar a navegação para o TodoListModule

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: context.primaryColorLight),
        elevation: 0,
        actions: [
          PopupMenuButton(
            icon: const Icon(TodoListIcons.filter),
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<bool>(
                    child: Text('Mostrar tarefas concluídas'))
              ];
            },
          )
        ],
      ),
      drawer: HomeDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxHeight),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const IntrinsicHeight(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeHeader(),
                  Divider(),
                  HomeFilters(),
                  HomeWeekFilter(),
                  Task(),
                  Task(),
                  Task(),
                  Task(),
                  Task(),
                  Task(),
                ],
              )),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.primaryColor,
        onPressed: () => _goToCreateTask(context),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
