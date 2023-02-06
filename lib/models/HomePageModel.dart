import 'package:flutter/foundation.dart';

class AnasayfaModel extends ChangeNotifier {
  bool aramaYapiliyorMu = false;
  String aramaKelimesi = "";

  bool checksearch() {
    return aramaYapiliyorMu;
  }

  void aramaaktif() {
    aramaYapiliyorMu = true;
    notifyListeners();
  }

  void aramaaktifdegil() {
    aramaYapiliyorMu = false;
    notifyListeners();
  }

  String arakelime() {
    return aramaKelimesi;
  }
}
