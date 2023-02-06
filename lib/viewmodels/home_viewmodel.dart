import 'dart:io';

import 'package:flutter/material.dart';

import '../models/Kisiler.dart';
import '../models/Kisilerdao.dart';

class HomeViewModel extends StatefulWidget {
  const HomeViewModel({Key? key}) : super(key: key);

  Future<List<Kisiler>> tumKisileriGoster() async {
    var kisilerListesi = await Kisilerdao().tumKisiler();
    return kisilerListesi;
  }

  @override
  State<HomeViewModel> createState() => _HomeViewModelState();
}

class _HomeViewModelState extends State<HomeViewModel> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
