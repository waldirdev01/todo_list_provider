import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/app_auth_provider.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class HomeDrawer extends StatelessWidget {
  final nameVN = ValueNotifier<String>('');
  HomeDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration:
                  BoxDecoration(color: context.primaryColor.withAlpha(200)),
              child: Row(
                children: [
                  Selector<AppAuthProvider, String>(
                    selector: (context, autProvider) {
                      return autProvider.user?.photoURL ??
                          'https://avatars.githubusercontent.com/u/1609975?s=200&v=4';
                    },
                    builder: (_, value, __) {
                      return CircleAvatar(
                        backgroundImage: NetworkImage(value),
                        radius: 30,
                      );
                    },
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    child: Selector<AppAuthProvider, String>(
                      selector: (context, autProvider) {
                        return autProvider.user?.displayName ?? 'User Name';
                      },
                      builder: (_, value, __) {
                        return Text(
                          value,
                          style: context.textTheme.bodyLarge,
                        );
                      },
                    ),
                  )
                ],
              )),
          ListTile(
            onTap: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Alterar nome'),
                content: TextField(
                    onChanged: (value) => nameVN.value = value,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome',
                    )),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancelar')),
                  TextButton(
                      onPressed: () async {
                        var name = nameVN.value;
                        if (name.isEmpty) {
                          Messages.of(context)
                              .showError('Nome não pode ser vazio');
                        } else {
                          await context
                              .read<UserService>()
                              .updateDisplayName(name);

                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text('Salvar'))
                ],
              ),
            ),
            title: const Text('Alterar nome'),
          ),
          ListTile(
            onTap: () => context.read<AppAuthProvider>().logout(),
            title: const Text('Sair'),
          ),
        ],
      ),
    );
  }
}
