import 'package:finance_manager/src/core/common/presentation/widgets/app_button.dart';
import 'package:finance_manager/src/core/utils/extensions/context_ext.dart';
import 'package:finance_manager/src/core/utils/overlay_loader.dart';
import 'package:finance_manager/src/features/authentication/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:finance_manager/src/features/authentication/presentation/widgets/auth_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          OverlayLoader.show(context);
        }
        if (state is! AuthLoadingState) {
          OverlayLoader.hide();
        }
        if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
        } else if (state is AuthSuccessState) {
          Navigator.of(context).pushReplacementNamed('/main_page');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              context.locale.signIn,
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      context.locale.email,
                      style: context.styles.s16w400,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                AuthTextField(
                  controller: _emailController,
                  enableSuggestions: false,
                  autoCorrect: false,
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      context.locale.password,
                      style: context.styles.s16w400,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                AuthTextField(
                  controller: _passwordController,
                  obscureText: true,
                  enableSuggestions: false,
                  autoCorrect: false,
                ),
                const SizedBox(height: 30),
                AppButton(
                  label: 'Sign in',
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          AuthSignInEvent(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                  },
                ),
                const Spacer(),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'No account? Click ',
                        style: context.styles.s16w400.copyWith(
                          color: context.colors.gray,
                        ),
                      ),
                      TextSpan(
                        text: 'here',
                        style: context.styles.s16w500.copyWith(
                          color: context.colors.mainGreen,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushNamed('/sign_up');
                          },
                      ),
                      TextSpan(
                        text: ' to register.',
                        style: context.styles.s16w400.copyWith(
                          color: context.colors.gray,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }
}
