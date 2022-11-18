import 'package:finance_manager/widgets/auth/auth_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AuthWidgetModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Вход'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              children: const [Text("Электронная почта")],
            ),
            TextField(controller: emailController),
            const SizedBox(height: 30),
            Row(
              children: const [Text('Пароль')],
            ),
            TextField(
              controller: passwordController,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => model.signIn(
                emailController.text.trim(),
                passwordController.text.trim(),
                context,
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 93, 176, 117),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                ),
              ),
              child: const Text(
                'Войти',
                style: TextStyle(fontSize: 17.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
