import 'package:flutter/material.dart';

class RateTheAppDialog extends StatelessWidget {
  const RateTheAppDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Я очень сильно стараюсь для Вас и каждый день улучшаю приложение!',
      ),
      content: SizedBox(
        height: 200,
        child: Column(
          children: const [
            Text(
                'Пожалуйста, поставьте мне 5 звезд на странице приложения в Play Market!'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
      ],
    );
  }
}
