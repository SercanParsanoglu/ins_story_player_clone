import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:stories_app/cubit/instagram_stories_cubit.dart';
import 'package:stories_app/product/constants/paddings.dart';
import 'package:stories_app/product/widgets/progress_bar_builder_widget.dart';
import 'package:stories_app/product/widgets/story_screen_widget.dart';
import 'package:stories_app/product/utils/kup_class.dart';

class StoryGecisler extends StatelessWidget {
  double timeBarOpacity = 1;
  final int index;
  StoryGecisler({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<InstagramStoriesCubit>().start(index, context);
    if (Kup.liste.isEmpty) {
      Kup.elemanekle(context: context);
    }

    return WillPopScope(
      onWillPop: () {
        context.read<InstagramStoriesCubit>().exit(context);

        return Future.value(true);
      },
      child: Scaffold(
        body: Container(
          color: Colors.black,
          child: Stack(
            children: [
              Center(
                child:
                    BlocBuilder<InstagramStoriesCubit, InstagramStoriesState>(
                  builder: (context, state) {
                    return StoryScreen(instagramState: state);
                  },
                ),
              ),
              Padding(
                padding: MyPaddings.timeBarPadding,
                child:
                    BlocBuilder<InstagramStoriesCubit, InstagramStoriesState>(
                  buildWhen: (previous, current) =>
                      previous.degisti != current.degisti,
                  builder: (context, state) {
                    return Opacity(
                      opacity: timeBarOpacity,
                      child: ProgressBarBuilder(instagramState: state),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        context
                            .read<InstagramStoriesCubit>()
                            .previousImage(context);
                      },
                      onDoubleTap: () {},
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onLongPressStart: (details) {
                        context.read<InstagramStoriesCubit>().state.wait = true;
                        timeBarOpacity = 0;
                        context.read<InstagramStoriesCubit>().pauseVideo();
                      },
                      onLongPressEnd: (details) {
                        context.read<InstagramStoriesCubit>().state.wait =
                            false;
                        context
                            .read<InstagramStoriesCubit>()
                            .timeBarstoScreen(context);
                        timeBarOpacity = 1;
                        context.read<InstagramStoriesCubit>().playVideo();
                      },
                      onTap: (() {
                        context.read<InstagramStoriesCubit>().state.wait = true;
                        context.read<InstagramStoriesCubit>().state.increase =
                            1;
                        context
                            .read<InstagramStoriesCubit>()
                            .timeBarstoScreen(context, controller: 1);
                      }),
                      onDoubleTap: () {},
                      onHorizontalDragUpdate: (details) {
                        context
                            .read<InstagramStoriesCubit>()
                            .horizontalDragUpd(details, context);
                      },
                      onHorizontalDragEnd: (details) {
                        context
                            .read<InstagramStoriesCubit>()
                            .horizontalDragEnd(context);
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
