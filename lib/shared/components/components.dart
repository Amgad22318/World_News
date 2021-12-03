import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:world_news/layout/news_app/theme_cubit/theme_cubit.dart';
import 'package:world_news/modules/web_view/web_view_screen.dart';

Widget defaultButton({
  bool isUpperCase = true,
  double width = double.infinity,
  double radius = 0,
  Color background = Colors.blue,
  required VoidCallback onPressed, // voidCallback = void Function()
  required String text,
}) =>
    Container(
      height: 40,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

Widget imageTest(itemMap) {
  return FadeInImage.assetNetwork(
    height: 150,
    width: 150,
    fit: BoxFit.cover,
    fadeInDuration: Duration(milliseconds: 800),
    fadeInCurve: Curves.fastLinearToSlowEaseIn,
    placeholder: 'assets/image/Default_Image.png',
    image: itemMap['urlToImage']??'assets/image/Default_Image.png',
    imageErrorBuilder: (context, error, stackTrace) {
      return Container(
        height: 150,
        width: 150,
        child: Image.asset(
          'assets/image/Default_Image.png',
          fit: BoxFit.cover,
        ),
      );
    },
  );
}

Widget articleItem(itemMap, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(itemMap['url']));
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: imageTest(itemMap),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Container(
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      '${itemMap['title']}',
                      textDirection: TextDirection.rtl,
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,


                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${itemMap['publishedAt']}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget listViewSeparator() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Container(
      width: double.infinity,
      color: Colors.grey,
      height: 1,
    ),
  );
}

Widget articleBuilder(List<dynamic> list, {isSearch = false}) {
  return ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) {
      return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return articleItem(list[index], context);
          },
          separatorBuilder: (context, index) => listViewSeparator(),
          itemCount: 10);
    },
    fallback: (context) =>
        isSearch ? Container() : Center(child: CircularProgressIndicator()),
  );
}

void navigateTo(BuildContext context, Widget widget) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
}

Widget defaultFormField(
        {required BuildContext context,
        required TextEditingController controller,
        required String labelText,
        required TextInputType keyboardType,
        required IconData prefixIcon,
        required String? Function(String?)? validator,
        void Function()? onEditingComplete,
        void Function(String)? onChanged,
        VoidCallback? suffixIconOnPressed,
        IconData? suffixIcon,
        bool obscureText = false,
        VoidCallback? onTap,
        Function? onFieldSubmitted // mohem
        }) =>
    TextFormField(
      style: TextStyle(
          color:
              ThemeCubit.get(context).darkMode ? Colors.white : Colors.black),
      onEditingComplete: onEditingComplete,
      onTap: onTap,
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: ThemeCubit.get(context).darkMode
                    ? Colors.white
                    : Colors.deepOrange)),
        labelStyle: TextStyle(
            color:
                ThemeCubit.get(context).darkMode ? Colors.white : Colors.grey),
        labelText: labelText,
        border: OutlineInputBorder(),
        prefixIcon: Icon(
          prefixIcon,
          color: ThemeCubit.get(context).darkMode
              ? Colors.white
              : Colors.deepOrange,
        ),
        suffixIcon: IconButton(
          onPressed: suffixIconOnPressed,
          icon: Icon(suffixIcon),
        ),
      ),
      keyboardType: keyboardType,
      // or like this
      onChanged: onChanged,
      validator: validator,
      onFieldSubmitted: (value) {},
    );
