import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'router.dart';
import 'theme.dart';

/// Root application widget.
///
/// Uses `MaterialApp.router` with go_router, Material 3 theming,
/// and Easy Localization delegates.
class GhibliApp extends StatelessWidget {
  const GhibliApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: tr('common.app_name'),
      debugShowCheckedModeBanner: false,

      // Theme
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,

      // Routing
      routerConfig: appRouter,

      // Localization
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
