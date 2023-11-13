import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
import 'package:goggles_of_revealing/controller/auth.dart';
import 'package:goggles_of_revealing/ui/constants.dart';

class DataUser {
  final Map<String, dynamic> aspects;
  final Array trophies;
  final Array scanned;
  DataUser(
      {required this.aspects, required this.trophies, required this.scanned});

  factory DataUser.fromFirestore(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    return DataUser(
        aspects: data['aspects'],
        trophies: data['trophies'],
        scanned: data['scanned']);
  }
}

class Api {
  var user = Auth().currentUser?.uid;
  var db = FirebaseFirestore.instance;

  List getThropies(List thr) {
    var result = [];
    var index = 0;
    thr.forEach((item) {
      if (Constants.trophies.contains(item)) {
        index = Constants.trophies.indexOf(item);
        if (index >= 9) {
          index = 8;
        }
        result.add([item, Constants.trophies[index], Constants.urls[index]]);
      }
    });
    return result;
  }

  Future<Map<String, dynamic>> increaseAnAspect(
      Map<String, dynamic> aspects) async {
    Map<String, dynamic> list = aspects;
    Random rnd = Random();
    var length = Constants.aspects.length;
    int randomAspect = rnd.nextInt(length);
    int randomAmount = rnd.nextInt(10);
    list[Constants.aspects[randomAspect]] += randomAmount;
    return list;
  }

  Future<void> checkScannedItem(String label) async {
    var data = await db.collection("users").doc(user).get();
    var aspects = data['aspects'];
    if (data['scanned'] == []) {
      var requestedLabel = {
        "scanned": [label]
      };
      db
          .collection("users")
          .doc(user)
          .set(requestedLabel, SetOptions(merge: true));
      for (int i = 0; i < 7; i++) {
        aspects = await increaseAnAspect(aspects);
        print("*****************************************");
        print(aspects);
      }
      db.collection("users").doc(user).update({'aspects': aspects});
    } else {
      if (!data['scanned'].contains(label)) {
        var list = [];
        for (int i = 0; i < data['scanned'].length; i++) {
          list.add(data['scanned'][i]);
        }
        list.add(label);
        db.collection("users").doc(user).update({'scanned': list});
        for (int i = 0; i < 7; i++) {
          aspects = await increaseAnAspect(aspects);
          print("*****************************************");
          print(aspects);
        }
        db.collection("users").doc(user).update({'aspects': aspects});
      }
    }
  }

  Future<void> addUserToStore() async {
    final aspects = <String, int>{
      "aer": 0,
      "alienis": 0,
      "aqua": 0,
      "arbor": 0,
      "auram": 0,
      "bestia": 0,
      "cognitio": 0,
      "corpus": 0,
      "exanimis": 0,
      "fabrico": 0,
      "fames": 0,
      "gelum": 0,
      "herba": 0,
      "humanus": 0,
      "ignis": 0,
      "instrumentum": 0,
      "iter": 0,
      "limus": 0,
      "lucrum": 0,
      "lux": 0,
      "machina": 0,
      "messis": 0,
      "metallum": 0,
      "meto": 0,
      "mortuus": 0,
      "motus": 0,
      "ordo": 0,
      "pannus": 0,
      "perditio": 0,
      "perfodio": 0,
      "permutatio": 0,
      "potentia": 0,
      "praencantatio": 0,
      "sano": 0,
      "sensus": 0,
      "spiritus": 0,
      "telum": 0,
      "tempestas": 0,
      "tenebrae": 0,
      "terra": 0,
      "tutamen": 0,
      "vacuos": 0,
      "venenum": 0,
      "victus": 0,
      "vinculum": 0,
      "vitium": 0,
      "vitreus": 0,
      "volatus": 0,
    };

    final userData = {"aspects": aspects, "trophies": [], "scanned": []};

    db
        .collection("users")
        .doc(user)
        .set(userData)
        .onError((e, _) => print("Error writing document: $e"));
  }
}
