// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stories_app/cubit/instagram_stories_cubit.dart';
import 'package:stories_app/instagram_profiles.dart';
import 'package:stories_app/product/constants/paddings.dart';
import 'package:stories_app/product/constants/strings.dart';
import 'package:stories_app/model/user_model.dart';
import 'package:stories_app/product/widgets/profile_image_circle._widget.dart';

class MainPageStories extends StatelessWidget {
  MainPageStories({super.key});
  final List<InstagramUser> instagramList = instagramUserList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyStrings.appBarTittle),
      ),
      body: BlocBuilder<InstagramStoriesCubit, InstagramStoriesState>(
        builder: (context, state) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: MyPaddings.mainPageStoriesCirclePaddings,
                    child: CircleProfile(
                      instagramList: instagramList,
                      index: index,
                    ),
                  ),
                ],
              );
            },
            itemCount: instagramList.length,
          );
        },
      ),
    );
  }
}
