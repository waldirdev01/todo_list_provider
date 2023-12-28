import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';

class TodoCardFilter extends StatefulWidget {
  const TodoCardFilter({super.key});

  @override
  State<TodoCardFilter> createState() => _TodoCardFilterState();
}

class _TodoCardFilterState extends State<TodoCardFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 120, maxWidth: 150),
      decoration: BoxDecoration(
          color: context.primaryColor,
          border: Border.all(width: 1, color: Colors.grey.withOpacity(0.8)),
          borderRadius: BorderRadius.circular(30)),
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            '10 TESK',
            style:
                context.titleStyle.copyWith(fontSize: 10, color: Colors.white),
          ),
          Text(
            'HOJE',
            style: context.titleStyle.copyWith(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          LinearProgressIndicator(
            backgroundColor: context.primaryColorLight,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            value: 0.4,
          )
        ],
      ),
    );
  }
}
