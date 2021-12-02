import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:world_news/layout/news_app/cubit/cubit.dart';
import 'package:world_news/layout/news_app/cubit/states.dart';
import 'package:world_news/layout/news_app/news_layout.dart';
import 'package:world_news/shared/bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_news/shared/network/local/cache_helper.dart';
import 'package:world_news/shared/network/remote/dio_helper.dart';

Future<void> main() async {
  // next line to make sure each finished and then run the app
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'darkMode');

  runApp(MyApp(isDark));
  BlocOverrides.runZoned(
    () {},
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  late final bool? isDark;

  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => NewsCubit()
          ..getBusiness()
          ..getSports()
          ..getScience()
          ..changeThemeMode(isDark: isDark),
        child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            print('isdark inside build  in main ${isDark.toString()}');

            print(
                'darkmode inside build  in main ${NewsCubit.get(context).darkMode.toString()}');

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: NewsLayout(),
              theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.deepOrange),
                  titleSpacing: 16,
                  actionsIconTheme: IconThemeData(color: Colors.deepOrange),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark),
                  titleTextStyle: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                scaffoldBackgroundColor: Colors.white,
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepOrange,
                    backgroundColor: Colors.white,
                    unselectedItemColor: Colors.grey,
                    elevation: 20),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.normal)),
              ),
              darkTheme: ThemeData(
                primarySwatch: Colors.deepOrange,
                appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.white),
                  titleSpacing: 16,
                  actionsIconTheme: IconThemeData(color: Colors.white),
                  backgroundColor: HexColor('333739'),
                  elevation: 0.0,
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('333739'),
                      statusBarIconBrightness: Brightness.light),
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                scaffoldBackgroundColor: HexColor('333739'),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepOrange,
                    backgroundColor: HexColor('333739'),
                    unselectedItemColor: Colors.grey,
                    elevation: 20),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.normal)),
              ),
              themeMode: NewsCubit.get(context).darkMode
                  ? ThemeMode.dark
                  : ThemeMode.light,
            );
          },
        ));
  }
}
