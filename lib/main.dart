import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Theme Change: Shared Preferences',
            theme: notifier.darkMode! ? dark_mode : light_mode,
            home: const MyHomePage(title: 'Theme: Shared Preferences'),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
              child: Consumer<ThemeNotifier>(
                builder: (context, notifier, child) {
                  return DayNightSwitcherIcon(
                    onStateChanged: (val) {
                      notifier.toggleChangeTheme(val);
                    },
                    isDarkModeEnabled: notifier.darkMode!,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
              child: Consumer<ThemeNotifier>(
                builder: (context, notifier, child) {
                  return DayNightSwitcher(
                    onStateChanged: (val) {
                      notifier.toggleChangeTheme(val);
                    },
                    isDarkModeEnabled: notifier.darkMode!,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
              child: Consumer<ThemeNotifier>(
                builder: (context, notifier, child) => SwitchListTile.adaptive(
                  title: notifier.darkMode!
                      ? const Text('Dark Mode')
                      : const Text("Light Mode"),
                  onChanged: (val) {
                    notifier.toggleChangeTheme(val);
                  },
                  value: notifier.darkMode!,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
