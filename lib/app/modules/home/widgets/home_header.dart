import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/app_auth_provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Selector<AppAuthProvider, String>(
              selector: (_, provider) =>
                  provider.user?.displayName ?? 'Não logado',
              builder: (_, value, __) {
                return Text(
                  'E aí, Waldir',
                  style: context.textTheme.headlineLarge,
                );
              }),
        )
      ],
    );
  }
}
