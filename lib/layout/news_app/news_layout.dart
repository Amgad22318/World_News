import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:world_news/layout/news_app/news_cubit/states.dart';
import 'package:world_news/layout/news_app/theme_cubit/theme_cubit.dart';
import 'package:world_news/modules/serarch/search_screen.dart';
import 'package:world_news/shared/components/components.dart';

import 'news_cubit/cubit.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(onPressed: () {
                navigateTo(context, SearchScreen());
              }, icon: Icon(Icons.search)),
              IconButton(onPressed: () {
                ThemeCubit.get(context).changeThemeMode();
              }, icon: Icon(Icons.brightness_4_outlined))
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomNavItems,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBarIndex(index);
            },
          ),
        );
      },
    );
  }
}
