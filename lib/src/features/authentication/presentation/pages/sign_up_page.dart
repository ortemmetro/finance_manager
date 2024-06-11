import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();

  String _selectedCurrencyValue = '₸';

  final List<DropdownMenuItem<String>> _menuCurrencyItems = const [
    DropdownMenuItem(
      value: '₸',
      child: Text('₸ - Kazakhstan Tenge'),
    ),
    DropdownMenuItem(
      value: '₽',
      child: Text('₽ - Russian Ruble'),
    ),
    DropdownMenuItem(
      value: '\$',
      child: Text('\$ - American Dollar'),
    ),
    DropdownMenuItem(
      value: '¥',
      child: Text('¥ - Chinese Yuan'),
    ),
    DropdownMenuItem(
      value: '€',
      child: Text('€ - Europe Euro'),
    ),
    DropdownMenuItem(
      value: '₺',
      child: Text('₺ - Turkish Lira'),
    ),
    DropdownMenuItem(
      value: '£',
      child: Text('£ - England Pound'),
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

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
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Row(
                  children: [Text('Имя')],
                ),
                TextField(
                  controller: _firstNameController,
                ),
                const SizedBox(height: 30),
                const Row(
                  children: [Text('Фамилия')],
                ),
                TextField(
                  controller: _lastNameController,
                ),
                const SizedBox(height: 30),
                const Row(
                  children: [Text('Возраст')],
                ),
                TextField(
                  controller: _ageController,
                ),
                const SizedBox(height: 30),
                const Row(
                  children: [Text('Электронная почта')],
                ),
                TextField(
                  controller: _emailController,
                ),
                const SizedBox(height: 30),
                const Row(
                  children: [Text('Пароль')],
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  // onEditingComplete: () => model.resetErrorText(),
                ),
                const SizedBox(height: 30),
                const Row(
                  children: [Text('Подтвердите пароль')],
                ),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  // onEditingComplete: () => model.resetErrorText(),
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Выберите подходящую вам валюту:'),
                    DropdownButton(
                      items: _menuCurrencyItems,
                      value: _selectedCurrencyValue,
                      onChanged: (value) {
                        setState(() {
                          _selectedCurrencyValue = value!;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      const Color.fromARGB(255, 93, 176, 117),
                    ),
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    ),
                  ),
                  child: const Text(
                    'Зарегистрироваться',
                    style: TextStyle(fontSize: 17.5),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'smodel.notValidPasswordString',
                  style: TextStyle(
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
