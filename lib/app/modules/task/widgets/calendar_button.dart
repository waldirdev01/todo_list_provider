import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';

import '../task_create_controller.dart';

class CalendarButton extends StatelessWidget {
  CalendarButton({super.key});
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var lastdate = DateTime.now().add(const Duration(days: 10 * 365));
        final DateTime? selectDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2024),
            lastDate: lastdate);
        // ignore: use_build_context_synchronously
        context.read<TaskCreateController>().selectedDate = selectDate;
      },
      child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.calendar_today,
                color: Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              Selector<TaskCreateController, DateTime?>(
                  builder: (context, selectadDdate, child) {
                    if (selectadDdate != null) {
                      return Text(
                        _dateFormat.format(selectadDdate),
                        style: context.titleStyle,
                      );
                    } else {
                      return const Text(
                        'Selecione uma data',
                        style: TextStyle(color: Colors.white),
                      );
                    }
                  },
                  selector: (context, controller) => controller.selectedDate)
            ],
          )),
    );
  }
}
