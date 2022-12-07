import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stories_app/cubit/instagram_stories_cubit.dart';
import 'package:stories_app/utils/enumim.dart';


class Kup {
  static Kupyuzu kupYuzuIsmi = Kupyuzu.onyuzu;

  static Matrix4 kupyuzuKordinat = kordinatlar[0];
  static List<Matrix4> kordinatlar = [
    //*ÖN
    Matrix4.identity()..translate(0.0, 0.0, -160.0),
    //*SAĞ
    Matrix4.identity()
      ..translate(160.0, 0.0, 0.0)
      ..rotateY(-pi / 2),
    //*ARKA
    Matrix4.identity()
      ..translate(0.0, 0.0, 160.0)
      ..rotateY(pi),
    //*SOL
    Matrix4.identity()
      ..translate(-160.0, 0.0, 0.0)
      ..rotateY(pi / 2),
  ];

  static List<Transform> liste = [];

  static List<Kupyuzu> kupyuzuListe = [];

  static final Kup _singlenton = Kup._internal();

  factory Kup() {
    return _singlenton;
  }

  static elemanekle({required BuildContext context}) {
    liste.add(
      Transform(
        transform: kupyuzuKordinat,
        child: context.read<InstagramStoriesCubit>().gorseligetir(0, context),
      ),
    );

    kupyuzuListe.add(Kupyuzu.onyuzu);
    context.read<InstagramStoriesCubit>().state.kupAci = 0;
    context.read<InstagramStoriesCubit>().state.offset = Offset.zero;
  }

  static elemanguncelle(BuildContext context) {
    elemansil(0);
    elemanekle(context: context);
  }

  static elemansil(index) {
    liste.removeAt(index);
    kupyuzuListe.removeAt(index);
  }

  static kupyuzuguncelle(
      {required Kupyuzu yeniKupyuzu,
      required BuildContext context,
      required String text}) {
    // print("Kupyuzuguncelle");
    switch (yeniKupyuzu) {
      case Kupyuzu.onyuzu:
        if (text == "SagaDonuyor") {
          kupyuzuListe.add(Kupyuzu.sagyuzu);

          liste.add(Transform(
            transform: kordinatlar[1],
            alignment: Alignment.center,
            child: Container(
                color: Colors.black,
                child: context
                    .read<InstagramStoriesCubit>()
                    .gorseligetir(1, context)),

          ));
          // print(kupyuzu_liste.toString());
        } else {
          //SOLYUZ
          kupyuzuListe.add(Kupyuzu.solyuzu);

          liste.add(
            Transform(
                transform: Kup.kordinatlar[3],
                alignment: Alignment.center,
                child: Container(
                  color: Colors.black,
                  child: context
                      .read<InstagramStoriesCubit>()
                      .gorseligetir(-1, context),
                )),
          );
        }
        break;
      case Kupyuzu.arkayuzu:
        if (text == "SagaDonuyor") {
          //SOLYUZ
          kupyuzuListe.add(Kupyuzu.solyuzu);

          liste.add(
            Transform(
              transform: Kup.kordinatlar[3],
              alignment: Alignment.center,
              child: Container(
                  color: Colors.black,
                  child: context
                      .read<InstagramStoriesCubit>()
                      .gorseligetir(1, context)),
            ),
          );
        } else {
          //SAĞ YUZtagr
          kupyuzuListe.add(Kupyuzu.sagyuzu);

          liste.add(Transform(
            transform: Kup.kordinatlar[1],
            alignment: Alignment.center,
            child: Container(
                color: Colors.black,
                child: context
                    .read<InstagramStoriesCubit>()
                    .gorseligetir(-1, context)),
          ));
        }
        break;
      case Kupyuzu.sagyuzu:
        if (text == "SagaDonuyor") {
          //ARKAYUZ
          kupyuzuListe.add(Kupyuzu.arkayuzu);

          liste.add(Transform(
            transform: Kup.kordinatlar[2],
            alignment: Alignment.center,
            child: Container(
                color: Colors.black,
                child: context
                    .read<InstagramStoriesCubit>()
                    .gorseligetir(1, context)),
          ));
        } else {
          //ÖN YÜZ
          kupyuzuListe.add(Kupyuzu.onyuzu);
          liste.add(Transform(
            transform: Kup.kordinatlar[0],
            alignment: Alignment.center,
            child: Container(
                color: Colors.black,
                child: context
                    .read<InstagramStoriesCubit>()
                    .gorseligetir(-1, context)),
          ));


        }
        break;

      case Kupyuzu.solyuzu:
        if (text == "SagaDonuyor") {
          kupyuzuListe.add(Kupyuzu.onyuzu);

          //ÖNYÜZ
          liste.add(Transform(
            transform: Kup.kordinatlar[0],
            alignment: Alignment.center,
            child: Container(
                color: Colors.black,
                child: context
                    .read<InstagramStoriesCubit>()
                    .gorseligetir(1, context)),
          ));

        } else {
          kupyuzuListe.add(Kupyuzu.arkayuzu);

          liste.add(Transform(
            transform: Kup.kordinatlar[2],
            alignment: Alignment.center,
            child: Container(
                color: Colors.black,
                child: context
                    .read<InstagramStoriesCubit>()
                    .gorseligetir(-1, context)),
          ));

          //ÖN YÜZ

        }
        break;
    }
  }

  static fonksiyon() {
    liste.insert(0, liste.last);
    liste.removeLast();
  }

  static fonksiyon2() {
    liste.insert(4, liste.first);
    liste.removeAt(0);
  }

  Kup._internal();
}
