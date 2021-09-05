import 'package:f_set/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeMatchingOverlayStyle extends StatelessWidget {
  const ThemeMatchingOverlayStyle({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = AppTheme.of(context).isDark;
    final systemUiOverlayStyle = (isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark)
        .copyWith(statusBarColor: AppTheme.of(context).primary);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiOverlayStyle,
      child: child,
    );
  }
}
