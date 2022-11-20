import 'package:finance_manager/widgets/auth/sign_up_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SignUpWidgetModel>(context);
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Row(
                  children: const [Text("Имя")],
                ),
                TextField(
                  controller: _firstNameController,
                ),
                const SizedBox(height: 30),
                Row(
                  children: const [Text("Фамилия")],
                ),
                TextField(
                  controller: _lastNameController,
                ),
                const SizedBox(height: 30),
                Row(
                  children: const [Text("Возраст")],
                ),
                TextField(
                  controller: _ageController,
                ),
                const SizedBox(height: 30),
                Row(
                  children: const [Text("Электронная почта")],
                ),
                TextField(
                  controller: _emailController,
                ),
                const SizedBox(height: 30),
                Row(
                  children: const [Text('Пароль')],
                ),
                TextField(
                  controller: _passwordController,
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
                  controller: _confirmPasswordController,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  onEditingComplete: () => model.resetErrorText(),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => model.signUp(
                    email: _emailController.text,
                    password: _passwordController.text,
                    confirmPassword: _confirmPasswordController.text,
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text,
                    age: int.parse(_ageController.text),
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
        ],
      ),
    );
  }
}
