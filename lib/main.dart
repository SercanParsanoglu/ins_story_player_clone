import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stories_app/cubit/instagram_stories_cubit.dart';
import 'package:stories_app/products/text.dart';
import 'package:stories_app/theme/custom_theme.dart';

import 'instagram_profiles.dart';
import 'pages/main_page_stories.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<InstagramStoriesCubit>(
      create: (context) => InstagramStoriesCubit(instagramUserList),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: ProjectTexts.appBarTittle,
        theme: CustomTheme().theme,
        // ThemeData.light().copyWith(
        //     scaffoldBackgroundColor: ProjectColor.athensGrey,
        //     appBarTheme: const AppBarTheme(
        //         color: Colors.grey,
        //         titleTextStyle: TextStyle(
        //             fontSize: 24,
        //             fontStyle: FontStyle.italic,
        //             color: Colors.white),
        //         centerTitle: true)),
        home: MainPageStories(),
      ),
    );
  }
}
