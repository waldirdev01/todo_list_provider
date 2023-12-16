import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              child: Row(
            children: [
              CircleAvatar(
                child: Image.network(
                    'https://pixabay.com/pt/playlists/halloween-18699821/'),
              ),
              Text(
                'User Name',
                style: context.textTheme.bodyLarge,
              )
            ],
          ))
        ],
      ),
    );
  }
}
