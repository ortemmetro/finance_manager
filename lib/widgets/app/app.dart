import 'package:finance_manager/widgets/add_widget/add_widget.dart';
import 'package:flutter/material.dart';

import '../main_page/main_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 93, 176, 117),
          disabledColor: const Color.fromARGB(255, 232, 232, 232),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 93, 176, 117),
          ),
        ),
        routes: {
          'main_page': (context) => const MainPage(),
          'main_page/add': (context) => const AddWidget(),
        },
        initialRoute: 'main_page',
      ),
    );
  }
}
