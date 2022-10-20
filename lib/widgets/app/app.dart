import 'package:flutter/material.dart';

import '../main_page/main_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        disabledColor: const Color.fromARGB(255, 232, 232, 232),
      ),
      home: const MainPage(),
    );
  }
}
