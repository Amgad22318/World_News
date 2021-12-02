import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_news/layout/news_app/cubit/cubit.dart';
import 'package:world_news/layout/news_app/cubit/states.dart';
import 'package:world_news/shared/components/components.dart';

class ScienceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        List<dynamic>? list = NewsCubit.get(context).science;
        return articleBuilder(list);
      },
    );
  }
}
