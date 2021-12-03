import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:world_news/layout/news_app/news_cubit/states.dart';
import 'package:world_news/modules/business/business_screen.dart';
import 'package:world_news/modules/science/science_screen.dart';

import 'package:world_news/modules/sports/sports_screen.dart';

import 'package:world_news/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business_center_outlined),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science_outlined),
      label: 'Science',
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBarIndex(index) {
    currentIndex = index;
    emit(ChangeNewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': 'bf30a97e1d5d43fbbb83d0885b8f5582',
      },
    ).then((value) {
      business = value.data['articles'];
      print(value.data['articles'][0]['title']);

      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      emit(NewsGetBusinessErrorState(error.toString()));
      print('get data error :*: ${error.toString()} :*:');
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'sports',
      'apiKey': 'bf30a97e1d5d43fbbb83d0885b8f5582',
    }).then((value) {
      sports = value.data['articles'];
      print(value.data['articles'][0]['title']);
      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      emit(NewsGetSportsErrorState(error));
      print('get data error :*: ${error.toString()} :*:');
    });
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'science',
      'apiKey': 'bf30a97e1d5d43fbbb83d0885b8f5582',
    }).then((value) {
      science = value.data['articles'];
      print(value.data['articles'][0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      emit(NewsGetScienceErrorState(error));
      print('get data error :*: ${error.toString()} :*:');
    });
  }

  List<dynamic> search = [];

  void getSearch(String? searchValue) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(url: 'v2/everything', query: {
      'q': '$searchValue',
      'apiKey': 'bf30a97e1d5d43fbbb83d0885b8f5582',
    }).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      emit(NewsGetSearchErrorState(error.toString()));
      print('get data error :*: ${error.toString()} :*:');
    });
  }
}
