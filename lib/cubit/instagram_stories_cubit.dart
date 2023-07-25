import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:stories_app/model/user_model.dart';
import 'package:stories_app/product/constants/animation_speeds.dart';
import 'package:stories_app/product/widgets/story_image_widget.dart';
import 'package:stories_app/product/widgets/story_video_widget.dart';
import 'package:stories_app/product/utils/kup_class.dart';

import 'package:video_player/video_player.dart';
part 'instagram_stories_state.dart';

class InstagramStoriesCubit extends Cubit<InstagramStoriesState> {
  late Timer mainTimer;

  InstagramStoriesCubit(List<InstagramUser> liste)
      : super(
          InstagramStoriesInitial(
              storyControllerList: List.filled(1, [], growable: true),
              instagramUsers: liste,
              storyList: [
                List.filled(1, Story(storyName: "Start"), growable: true),
              ],
              storyTimerList: List.filled(1, [], growable: true)),
        );

//!Start

  void start(int index, BuildContext context, {int controller = 0}) {
    state.kullanici = index;
    state.yeniGeldim = true;
    state.wait = false;
    Kup.liste.clear();
    Kup.kupyuzuListe.clear();
    timeBarstoScreen(context);

    //Ekrandaki görseli küpün ön yüzüne eşitleme
    Kup.kupyuzuKordinat = Kup.kordinatlar[0];
    Kup.elemanekle(context: context);
  }

  void createList(List<List<Story>> listem) {
    listem.clear();

    for (InstagramUser i in state.instagramUsers) {
      listem.add(i.bakilmayanStoryler);
    }

    //Burda kullanıcı sayısı kadar boş liste oluşturuldu
    state.storyTimerList = List.filled(state.storyList.length, []);
    state.storyControllerList = List.filled(state.storyList.length, []);

    //oluşan boş listelere profillerin için 0 ve false ile dolduruldu
    //[[0,0],[0]...] , [[false,false],[false]...]
    for (int i = 0; i <= state.storyList.length - 1; i++) {
      state.storyTimerList[i] = List.filled(state.storyList[i].length, 0);
      state.storyControllerList[i] =
          List.filled(state.storyList[i].length, false);
    }
  }

//!Timebar

  void timeBarstoScreen(BuildContext context, {int controller = 0}) {
    if (state.storyList[0][0].storyName == "Start") {
      createList(state.storyList);
    }

    if (state.yeniGeldim) {
      state.profileViewer = 0;
      state.yeniGeldim = false;
    }

    mainTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      //!Story, video ise  timebarin video süresine göre ayarlandığı kısım.
      // if (ekrandakiStory().mediaType == MediaType.video &&
      //     !state.videoPlayerController!.value.isInitialized) {
      //   state.storyTimerList[state.kullanici!][state.profileViewer] = 0;

      // }

      if (!(ekrandakiStory().mediaType == MediaType.image)) {
        if (state.videoPlayerController != null &&
            state.increase == TimeBarSpeed.normal &&
            state.videoPlayerController!.value.isInitialized) {
          state.increase = increaseForVideo;
          state.storyTimerList[state.kullanici!][state.profileViewer] = 0;
        }
      }

      if (controller == 1) {
        timer.cancel();
        controller = 0;
        state.wait = false;
      }

      if (state.wait) {
        timer.cancel();
      }

      //!Timebar sayacının çalıştığı kısım

      if (currentTimeBar + state.increase < 1) {
        state.storyTimerList[state.kullanici!][state.profileViewer] +=
            state.increase;
      } else {
        storyViewed;
        timer.cancel();

        if (unseenStory) {
          state.profileViewer += 1;

          nextImage(context);
        } else {
          state.increase = TimeBarSpeed.normal;
          sonrakiProfiliAc(context);
        }
      }

      //!Timebarlardaki hareketi göstermek için emit

      emit(MyInstagramStoriesState(
        increase: state.increase,
        videoCalistir: state.videoCalistir,
        degisti: state.degisti + 1,
        videoplayercont: state.videoPlayerController,
        kontrol: state.kontrol,
        kupAci: state.kupAci,
        offset: state.offset,
        yeniGeldim: false,
        wait: state.wait,
        storyControllerList: state.storyControllerList,
        profileViewer: state.profileViewer,
        storyTimerList: state.storyTimerList,
        instagramUsers: state.instagramUsers,
        storyList: state.storyList,
        kullanici: state.kullanici,
      ));
    });
  }

//!İleri

  void nextImage(BuildContext context) {
    if (Kup.liste.length == 1) {
      Kup.liste[0] = returnTransformWidget(context);
      state.increase = TimeBarSpeed.normal;
    }
    timeBarstoScreen(context);
  }

  void sonrakiProfiliAc(BuildContext context) {
    timeBarstoScreen(context);

    //!False yoksa tüm storyler izlendi demek circle gri yap

    if (!unseenStory) {
      allStoriesViewed;
    }

    //! Son profil ise
    if (state.kullanici == state.storyList.length - 1 &&
        state.profileViewer == guncelStoryList.length - 1) {
      if (!unseenStory) {
        allStoriesViewed;
      }

      mainTimer.cancel();
      Navigator.of(context).pop();
    } else {
      kubikileSonrakiProfileGit(context);
    }
  }

  void kubikileSonrakiProfileGit(BuildContext context) {
    state.storyTimerList[state.kullanici!][state.profileViewer] = 0;

    Kup.kupyuzuguncelle(
        context: context,
        text: "SagaDonuyor",
        yeniKupyuzu: Kup.kupyuzuListe[0]);

    //!KÜBİK İLE SONRAKİ PROFİLE GİTMEK İÇİN

    //!Kübik geçişten önce video ise fotoğrafa çevir

    if (guncelStoryList.last.mediaType == MediaType.video &&
        state.videoCalistir == true) {
      state.videoCalistir = false;
      Kup.liste[0] = returnTransformWidget(context, lastStoryisVideo: true);
    }

    state.increase = 0;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (state.offset.dx + 10 < state.kupAci + 91) {
        // state.storyTimerList[state.kullanici!][state.profileViewer] = 0;

        state.offset = Offset(state.offset.dx + 10, 0);
      } else {
        state.kupAci += 90;
        state.offset = Offset(state.kupAci, 0);
        timer.cancel();
        mainTimer.cancel();

        state.increase = 0.01;
        start(state.kullanici!, context);

        if (ekrandakiStory().mediaType == MediaType.video &&
            state.videoCalistir == false) {
          state.videoCalistir = true;
          Kup.liste[0] = returnTransformWidget(context);
        }

        state.kontrol = true;
      }
    });
    emit(
      MyInstagramStoriesState(
        increase: state.increase,
        videoCalistir: state.videoCalistir,
        degisti: state.degisti,
        videoplayercont: state.videoPlayerController,
        kontrol: state.kontrol,
        kupAci: state.kupAci,
        offset: state.offset,
        yeniGeldim: false,
        wait: state.wait,
        storyControllerList: state.storyControllerList,
        profileViewer: 0,
        storyTimerList: state.storyTimerList,
        instagramUsers: state.instagramUsers,
        storyList: state.storyList,
        kullanici: state.kullanici! + 1,
      ),
    );
  }

//!Geri

  previousImage(BuildContext context) {
    state.increase = TimeBarSpeed.normal;
    try {
      if (state.storyControllerList[state.kullanici!]
              [state.profileViewer - 1] ==
          true) {
        state.storyTimerList[state.kullanici!][state.profileViewer] = 0;
        state.storyControllerList[state.kullanici!][state.profileViewer - 1] =
            false;
        state.storyTimerList[state.kullanici!][state.profileViewer - 1] = 0;

        state.profileViewer -= 1;

        Kup.liste[0] = returnTransformWidget(context);
      }
    } catch (e) {
      if (state.kullanici != 0) {
        kubikileOncekiProfileGit(context);
      }
    }
  }

  kubikileOncekiProfileGit(BuildContext context) {
    //! Current timebari 0la
    state.storyTimerList[state.kullanici!][state.profileViewer] = 0;

    //!İlk profilin sola doğru kübik geçiş yapmaması için
    if (state.kullanici! - 1 < 0) {
      state.kullanici = state.kullanici! + 1;
    }

    Kup.kupyuzuguncelle(
        context: context,
        text: "SolaDonuyor",
        yeniKupyuzu: Kup.kupyuzuListe[0]); //*************** */
    state.kontrol = false;
    //!Kübik geri dönüş için

    //!Video var ise geçiş işin image çevrildi
    if (ekrandakiStory().mediaType == MediaType.video &&
        state.videoCalistir == true) {
      state.videoCalistir = false;
      Kup.liste[0] = returnTransformWidget(context);
    }

    //!Küp dönüşü
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (state.offset.dx - 10 > state.kupAci - 90) {
        state.offset = Offset(state.offset.dx - 10, 0);
      } else {
        state.kupAci -= 90;
        state.offset = Offset(state.kupAci, 0);
        timer.cancel();
        mainTimer.cancel();
        state.videoCalistir = true;

        start(state.kullanici!, context, controller: 0);

        if (ekrandakiStory().mediaType == MediaType.video) {
          state.videoCalistir = true;

          Kup.liste[0] = returnTransformWidget(context);
        }

        state.kontrol = true;
      }
    });
    emit(MyInstagramStoriesState(
        increase: state.increase,
        videoCalistir: state.videoCalistir,
        degisti: state.degisti,
        videoplayercont: state.videoPlayerController,
        kontrol: state.kontrol,
        kupAci: state.kupAci,
        offset: state.offset,
        wait: state.wait,
        storyControllerList: state.storyControllerList,
        kullanici: state.kullanici! - 1,
        profileViewer: 0,
        instagramUsers: state.instagramUsers,
        storyTimerList: state.storyTimerList,
        storyList: state.storyList,
        yeniGeldim: state.yeniGeldim));
  }

//!Kaydırmalı İşlemler

  horizontalDragUpd(DragUpdateDetails details, BuildContext context) {
    if (mainTimer.isActive) {
      mainTimer.cancel();
    }

    if (ekrandakiStory().mediaType == MediaType.video &&
        state.videoCalistir == true) {
      state.videoCalistir = false;

      Kup.liste[0] = returnTransformWidget(context);
    }

    state.offset -= details.delta * CubeSensitivity.normal;

    //!SOLA DÖNÜŞ
    //!ÇEVİRME X EKSENİNDE KUP ACISINDAN KÜÇÜKSE SOLA DÖNÜYOR DEMEK
    if (state.offset.dx < state.kupAci && state.kontrol) {
      if (state.kullanici != 0) {
        Kup.kupyuzuguncelle(
            context: context,
            text: "SolaDonuyor",
            yeniKupyuzu: Kup.kupyuzuListe[0]);
      }

      state.kontrol = false; //KONT

      //!SAĞA DÖNÜŞ
    } else if (state.kontrol && state.offset.dx > state.kupAci) {
      if (state.kullanici != state.storyList.length - 1) {
        Kup.kupyuzuguncelle(
            context: context,
            text: "SagaDonuyor",
            yeniKupyuzu: Kup.kupyuzuListe[0]);
      }

      state.kontrol = false;
    }
    donusleriSinirla;

    //! DÖNÜŞLERİN EKRANA YANSIMASI İÇİN

    emit(MyInstagramStoriesState(
        increase: state.increase,
        videoCalistir: state.videoCalistir,
        degisti: state.degisti,
        videoplayercont: state.videoPlayerController,
        kontrol: state.kontrol,
        kupAci: state.kupAci,
        offset: state.offset,
        wait: state.wait,
        storyControllerList: state.storyControllerList,
        profileViewer: state.profileViewer,
        instagramUsers: state.instagramUsers,
        storyTimerList: state.storyTimerList,
        storyList: state.storyList,
        kullanici: state.kullanici!,
        yeniGeldim: state.yeniGeldim));
  }

  horizontalDragEnd(BuildContext context) {
    state.increase = TimeBarSpeed.normal;

    timeBarstoScreen(context);
    state.videoCalistir = true;

    //! 45 dereceden fazla döndürüldüyse 90 dereceye tamamla
    if (state.offset.dx >= state.kupAci + 45) {
      state.kupAci += 90;
      //! HorDragUpdt çalışması için kontrol true;

      state.kontrol = true;

      storyGuncellenmesi;

      state.offset = Offset(state.kupAci, 0);
      state.kullanici = state.kullanici! + 1;

      mainTimer.cancel();
      start(state.kullanici!, context);

      //!45 dereceden fazla sola doğru döndürüldüyse 90a tamamla
    } else if (state.offset.dx <= state.kupAci - 45) {
      state.kupAci += -90;
      state.kontrol = true;
      storyGuncellenmesi;

      state.offset = Offset(state.kupAci, 0);
      state.kullanici = state.kullanici! - 1;

      mainTimer.cancel();
      start(state.kullanici!, context, controller: 0);
    } else {
      //!SON PROFİL YADA İLK PROFİL İSE
      if ((state.kullanici == state.storyList.length - 1 &&
              state.offset.dx > state.kupAci) ||
          (state.kullanici == 0 && state.offset.dx == 0)) {
        storyGuncellenmesi;
        mainTimer.cancel();
        Navigator.of(context).pop();
      }
      //!AYNI STORYDE KALINDI
      else {
        state.offset = Offset(state.kupAci, 0);
        state.kontrol = true;
        if (Kup.liste.length > 1) {
          Kup.elemansil(1);
        }
        if (ekrandakiStory().mediaType == MediaType.video) {
          state.profileViewer = 0;
        }
        Kup.liste[0] = returnTransformWidget(context);
      }
    }
  }

  void get donusleriSinirla {
    //! SON PROFİLE GELDİĞİNDE MAX 30 DERECE DÖN
    if (state.kullanici == state.storyList.length - 1 &&
        state.offset.dx >= state.kupAci + 30.0) {
      state.offset = Offset(state.kupAci + 30, 0);
    } else if (state.offset.dx >= state.kupAci + 90.0) {
      state.offset = Offset(state.kupAci + 90, 0);
    }

    //!1 DERECE İLERİ VEYA GERİYE GİTTİĞİNDE
    if (state.offset.dx > state.kupAci - 1 &&
        state.offset.dx < state.kupAci + 1) {
      // print("0 ÇALIŞTI");
      if (Kup.liste.length > 1) {
        Kup.elemansil(1);
      }
      state.kontrol = true;
    }

    //! İLK PROFİLDE İKEN
    if (state.offset.dx < state.kupAci && state.kullanici == 0) {
      state.offset = const Offset(0, 0);
    } else if (state.offset.dx <= state.kupAci - 90) {
      state.offset = Offset(state.kupAci - 90, 0);
    }
  }

//!Load Story

  Widget gorseligetir(int i, BuildContext context,
      {bool lastStoryIsVideo = false, Duration? videoGecilmedi}) {
    Story gorsel = ekrandakiStory(i: i);

    if (lastStoryIsVideo) {
      gorsel = guncelStoryList.last;
    }

    if (gorsel.mediaType == MediaType.video) {
      if (i == -1 || i == 1) {
        state.videoCalistir = false;
      }
      if (gorsel.storyVideoName != null) {
        state.videoPlayerController =
            VideoPlayerController.asset(gorsel.storyVideoName!);
      }

      return state.videoCalistir
          ? StoryVideo(
              videoPlayerController: state.videoPlayerController!,
              state: state,
              i: i)
          : StoryImage(state: state, gorsel: gorsel, i: i);
    } else {
      return StoryImage(state: state, gorsel: gorsel, i: i);
    }
  }

//!Yardımcı Fonksiyonlar

  bool get unseenStory {
    return state.storyControllerList[state.kullanici!].contains(false);
  }

  void get storyViewed {
    state.storyTimerList[state.kullanici!][state.profileViewer] = 1;
    state.storyControllerList[state.kullanici!][state.profileViewer] = true;
  }

  void get allStoriesViewed {
    state.instagramUsers[state.kullanici!].circleColor = Colors.grey;

    state.storyTimerList[state.kullanici!] =
        List.filled(state.storyTimerList[state.kullanici!].length, 0);
    state.storyControllerList[state.kullanici!] =
        List.filled(state.storyControllerList[state.kullanici!].length, false);
  }

  void get storyGuncellenmesi {
    storyViewed;
    if (state.profileViewer + 1 == guncelStoryList.length) {
      state.instagramUsers[state.kullanici!].circleColor = Colors.grey;

      state.storyTimerList[state.kullanici!] =
          List.filled(state.storyTimerList[state.kullanici!].length, 0);
      state.storyControllerList[state.kullanici!] = List.filled(
          state.storyControllerList[state.kullanici!].length, false);
    }
  }

  get guncelStoryList {
    return state.storyList[state.kullanici!];
  }

  Story ekrandakiStory({int i = 0}) {
    return state.storyList[state.kullanici! + i]
        [state.storyControllerList[state.kullanici! + i].indexOf(false)];
  }

  get currentTimeBar =>
      state.storyTimerList[state.kullanici!][state.profileViewer];

  double get increaseForVideo {
    return 1 /
        (state.videoPlayerController!.value.duration.inMilliseconds / 50);
  }

  Transform returnTransformWidget(BuildContext context,
      {bool lastStoryisVideo = false}) {
    return Transform(
        transform: Kup.kupyuzuKordinat,
        alignment: Alignment.center,
        child: gorseligetir(0, context, lastStoryIsVideo: lastStoryisVideo));
  }
//!Video

  void pauseVideo() {
    if (state.videoPlayerController != null) {
      state.videoPlayerController!.pause();
    }
  }

  void playVideo() {
    state.videoPlayerController!.play();
  }

//!Exit

  void exit(BuildContext context) async {
    mainTimer.cancel();
    storyGuncellenmesi;
  }
}
