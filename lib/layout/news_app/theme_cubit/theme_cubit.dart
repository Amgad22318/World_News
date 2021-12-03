import 'package:bloc/bloc.dart';



import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:world_news/layout/news_app/theme_cubit/theme_states.dart';

import 'package:world_news/shared/network/local/cache_helper.dart';


class ThemeCubit extends Cubit<ThemeStates> {
  ThemeCubit() : super(ThemeInitialStates());

  static ThemeCubit get(context) => BlocProvider.of(context);

  bool darkMode = false;

  void changeThemeMode({bool? isDark}) {
    if (isDark != null) {
      darkMode = isDark;
      emit(ThemeModeChangedState());
    } else {
      darkMode = !darkMode;
      CacheHelper.putData(key: 'darkMode', value: darkMode).then((value) {});
      emit(ThemeModeChangedState());
    }
  }
}
