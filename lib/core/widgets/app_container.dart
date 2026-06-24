import 'package:flutter/material.dart';
import 'package:flutter_weather_app/core/common/constants/app_spacing.dart';

class AppContainer extends StatelessWidget {
  final Widget child;
  const AppContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12.0),
        //border: Border.all(color: Colors.white70),
      ),
      child: child,
    );
  }
}
