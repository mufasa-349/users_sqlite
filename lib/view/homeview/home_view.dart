library home_view;

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:userswithmvvm/models/HomePageModel.dart';
import 'package:userswithmvvm/widgets/ListViewBuilderWidget.dart';

import '../../viewmodels/home_viewmodel.dart';
import '../kisikayitview/KisiKayitSayfa.dart';

part 'home_appbar.dart';
part 'home_body.dart';
part 'home_fab.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  Future<bool> uygulamayiKapat() async {
    await exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AnasayfaModel>(
        builder: (context, AnasayfaModelNesne, child) {
      return Scaffold(
        appBar: AppBar(
          title: AnasayfaModelNesne.aramaYapiliyorMu
              ? ArarkenTitle()
              : AramazkenTitle(),
          actions: [
            AnasayfaModelNesne.aramaYapiliyorMu
                ? ArarkenIcon()
                : AramazkenIcon()
          ],
        ),
        body: WillPopScope(
          onWillPop: uygulamayiKapat,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[HomeBody()],
            ),
          ),
        ),
        floatingActionButton: const fab(),
      );
    });
  }
}
