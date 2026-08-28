// Package
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Widget
import 'package:ramyeon_counter/widget/other/layered_text.dart';

// Partial
part 'home_about_list_tile.dart';

class const HomeDrawer({super.key}) extends Drawer {
  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    return Drawer(
      backgroundColor: cs.tertiaryFixed,
      width: 200.0, // Drawer width.
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: cs.tertiaryContainer),
            margin: EdgeInsets.all(0),
            child: LayeredText(
              vm: .new(
                context,
                title: 'Ramyeon Counter',
                color: .primary,
                fontSize: 40,
              ),
            ),
          ),
          ...[
            (icon: Icons.add, title: '登録', location: '/regist'),
            (icon: Icons.warehouse, title: '在庫', location: '/stock'),
            (icon: Icons.list, title: '統計', location: '/stat'),
          ].map(
            ((e) => ListTile(
              hoverColor: cs.tertiaryFixedDim,
              iconColor: cs.onTertiaryFixed,
              leading: Icon(e.icon),
              title: Text(e.title),
              onTap: () => context.push(e.location),
            )),
          ),
          HomeAboutListTile(),
        ],
      ),
    );
  }
}
