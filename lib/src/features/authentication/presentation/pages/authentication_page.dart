import 'package:finance_manager/src/features/authentication/presentation/pages/auth_widget_model.dart';
import 'package:finance_manager/widgets/settings_widgets/currency/currency_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppLocalizations.of(context)!.signIn),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              children: [
                Text(AppLocalizations.of(context)!.email),
              ],
            ),
            TextField(controller: emailController),
            const SizedBox(height: 30),
            Row(
              children: [Text(AppLocalizations.of(context)!.password)],
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: model.isButtonEnabled
                  ? () async {
                      await model
                          .signIn(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                            context,
                            currencyModel,
                          )
                          .whenComplete(
                            () => Navigator.of(context).pushNamed('/start'),
                          );
                    }
                  : null,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  const Color.fromARGB(255, 93, 176, 117),
                ),
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.enter,
                style: const TextStyle(fontSize: 17.5),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/sign_up');
              },
              child: Text(AppLocalizations.of(context)!.noAccountText),
            ),
          ],
        ),
      ),
    );
  }
}
