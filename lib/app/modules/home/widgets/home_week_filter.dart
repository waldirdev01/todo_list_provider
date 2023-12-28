import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';

class HomeWeekFilter extends StatelessWidget {
  const HomeWeekFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          'Dia da Semana',
          style: context.titleStyle,
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 95,
          child: DatePicker(
            DateTime.now(),
            locale: 'pt_BR',
            width: 60,
            height: 80,
            initialSelectedDate: DateTime.now(),
            selectionColor: context.primaryColor,
            selectedTextColor: Colors.white,
            dayTextStyle: const TextStyle(fontSize: 8, color: Colors.black),
            dateTextStyle: const TextStyle(fontSize: 13, color: Colors.black),
            monthTextStyle: const TextStyle(fontSize: 13, color: Colors.black),
            daysCount: 7,
            onDateChange: (date) {
              // New date selected
            },
          ),
        )
      ],
    );
  }
}
