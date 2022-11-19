import 'package:finance_manager/widgets/auth/sign_up_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SignUpWidgetModel>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              children: const [Text("Электронная почта")],
            ),
            TextField(
              controller: emailController,
            ),
            const SizedBox(height: 30),
            Row(
              children: const [Text('Пароль')],
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              onEditingComplete: () => model.resetErrorText(),
            ),
            const SizedBox(height: 30),
            Row(
              children: const [Text('Подтвердите пароль')],
            ),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              onEditingComplete: () => model.resetErrorText(),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => model.signUp(
                emailController.text,
                passwordController.text,
                confirmPasswordController.text,
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
                'Зарегистрироваться',
                style: TextStyle(fontSize: 17.5),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              model.notValidPasswordString,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
