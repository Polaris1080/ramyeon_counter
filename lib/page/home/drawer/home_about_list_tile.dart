part of 'home_drawer.dart';

// TODO:remainder About
class const HomeAboutListTile({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextStyle ts = Theme.of(context).textTheme.bodyMedium!;

    return AboutListTile(
      icon: Icon(Icons.info, color: cs.onTertiaryFixed),
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
                style: ts,
                text:
                    "Flutter is Google's UI toolkit for building beautiful, "
                    'natively compiled applications for mobile, web, and desktop '
                    'from a single codebase. Learn more about Flutter at ',
              ),
              TextSpan(
                style: ts.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
                text: 'https://flutter.dev',
              ),
              TextSpan(style: ts, text: '.'),
            ],
          ),
        ),
      ],
    );
  }
}
