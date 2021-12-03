import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_news/layout/news_app/news_cubit/cubit.dart';
import 'package:world_news/layout/news_app/news_cubit/states.dart';
import 'package:world_news/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchFormFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<dynamic> list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: defaultFormField(
                  context: context,
                  controller: searchFormFieldController,
                  labelText: 'Search',
                  keyboardType: TextInputType.text,
                  prefixIcon: Icons.search,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'search must not be empty';
                    }
                    return null;
                  },
                  onChanged: (String? searchValue) {
                    NewsCubit.get(context).getSearch(searchValue);
                  },
                ),
              ),
              Expanded(child: articleBuilder(list,isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
