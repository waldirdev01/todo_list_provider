import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/toto_list_icons.dart';

class TodoListField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final IconButton? suffixIcon;
  bool? obscureText;
  final ValueNotifier<bool> obscureTextVN;
  TodoListField(
      {super.key,
      required this.label,
      this.controller,
      this.validator,
      this.suffixIcon,
      this.obscureText = false})
      : assert(obscureText == true ? suffixIcon == null : true,
            'obscureText não pode ser passado em conjunto com suffixIcon'),
        obscureTextVN = ValueNotifier(obscureText!);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: obscureTextVN,
        builder: (_, obscureTextValue, child) {
          return TextFormField(
            controller: controller,
            validator: validator,
            obscureText: obscureTextValue,
            decoration: InputDecoration(
              isDense: true,
              labelText: label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.red)),
              suffixIcon: suffixIcon ??
                  (obscureText == true
                      ? IconButton(
                          onPressed: () {
                            obscureTextVN.value = !obscureTextVN.value;
                          },
                          icon: Icon(
                            obscureTextValue
                                ? TodoListIcons.eye
                                : TodoListIcons.eye_slash,
                            size: 12,
                          ),
                        )
                      : null),
            ),
          );
        });
  }
}
