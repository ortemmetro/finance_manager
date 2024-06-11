import 'package:finance_manager/src/core/di/get_it_provider.dart';
import 'package:finance_manager/src/core/theme/colors/app_colors.dart';
import 'package:finance_manager/src/core/theme/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ContextExt on BuildContext {
  AppStyles get styles => AppStyles();
  AppColors get colors => AppColors();

  AppLocalizations get locale => AppLocalizations.of(this);

  T get<T extends Object>({
    String? instanceName,
    dynamic param1,
    dynamic param2,
  }) =>
      read<GetItProvider>().getIt<T>(
        param1: param1,
        param2: param2,
        instanceName: instanceName,
      );
}
