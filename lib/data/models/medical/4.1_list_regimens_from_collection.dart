

import 'package:cloud_firestore/cloud_firestore.dart';

import '4_regimen.dart';

class ListRegimensFromCollection{

  static List<Regimen> regimens( ref) {
    List<Regimen> regimens = [];
    List<dynamic> list = ref.data()  .map((e) => e.data()).toList();
    for (dynamic x in list) {
      regimens.add(Regimen.fromMap(x));
    }
    return regimens;
  }

}