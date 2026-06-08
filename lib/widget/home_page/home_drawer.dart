import 'package:ramyeon_counter/widget/layered_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeDrawer extends Drawer {
  const HomeDrawer({super.key});

  static const drawerWidth = 200.0;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextStyle aboutTextStyle = Theme.of(context).textTheme.bodyMedium!;
    final Color tileHoverColor = colorScheme.tertiaryFixedDim;
    final Color tileIconColor = colorScheme.onTertiaryFixed;

    return Drawer(
      backgroundColor: colorScheme.tertiaryFixed,
      width: drawerWidth,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: colorScheme.tertiaryContainer),
            margin: EdgeInsets.all(0),
            child: LayeredText(
              'Ramyeon Counter',
              color: .primary,
              fontSize: 40,
            ),
          ),
          ListTile(
            hoverColor: tileHoverColor,
            iconColor: tileIconColor,
            leading: const Icon(Icons.add),
            title: const Text('登録'),
            // TODO:Inline?
            onTap: () {
              context.push('/regist');
            },
          ),
          ListTile(
            hoverColor: tileHoverColor,
            iconColor: tileIconColor,
            leading: const Icon(Icons.warehouse),
            title: const Text('在庫'),
            onTap: () {
              context.push('/stock');
            },
          ),
          ListTile(
            hoverColor: tileHoverColor,
            iconColor: tileIconColor,
            leading: const Icon(Icons.list),
            title: const Text('統計'),
            onTap: () {
              context.push('/stat');
            },
          ),
          // TODO:remainder About
          AboutListTile(
            icon: Icon(Icons.info, color: tileIconColor),
            applicationIcon: const FlutterLogo(),
            applicationName: 'App',
            applicationVersion: 'August 2019',
            applicationLegalese: '\u{a9} 2014 The Flutter Authors',
            aboutBoxChildren: [
              const SizedBox(height: 24),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      style: aboutTextStyle,
                      text:
                          "Flutter is Google's UI toolkit for building beautiful, "
                          'natively compiled applications for mobile, web, and desktop '
                          'from a single codebase. Learn more about Flutter at ',
                    ),
                    TextSpan(
                      style: aboutTextStyle.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      text: 'https://flutter.dev',
                    ),
                    TextSpan(style: aboutTextStyle, text: '.'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
