import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial());

  void toggleTheme() {
    final newTheme = (state.themeMode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    emit(state.copyWith(themeMode: newTheme));
  }

  void setTheme(ThemeMode mode) {
    emit(state.copyWith(themeMode: mode));
  }
}
