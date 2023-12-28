import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  const Task({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1)
            ]),
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: IntrinsicHeight(
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: Checkbox(
              value: false,
              onChanged: (value) {},
            ),
            title: const Text(
              'Task 1',
              style: TextStyle(decoration: TextDecoration.lineThrough),
            ),
            subtitle: const Text(
              'data da task 1',
              style: TextStyle(decoration: TextDecoration.lineThrough),
            ),
          ),
        ));
  }
}
