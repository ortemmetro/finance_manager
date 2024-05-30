import 'package:finance_manager/src/core/theme/colors/app_colors.dart';
import 'package:finance_manager/src/core/theme/styles/app_styles.dart';
import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  AppStyles get styles => const AppStyles();
  AppColors get colors => AppColors();
}
