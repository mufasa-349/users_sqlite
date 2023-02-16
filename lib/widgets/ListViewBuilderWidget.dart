import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:userswithmvvm/viewmodels/home_viewmodel.dart';

import '../models/HomePageModel.dart';
import '../models/Kisiler.dart';
import '../models/Kisilerdao.dart';
import '../view/kisidetayview/KisiDetaySayfa.dart';
import '../view/kisieditview/KisiEditSayfa.dart';

class ListViewGoster extends StatefulWidget {
  const ListViewGoster({Key? key}) : super(key: key);

  @override
  State<ListViewGoster> createState() => _ListViewGosterState();
}

class _ListViewGosterState extends State<ListViewGoster> {
  Future<List<Kisiler>> aramaYap(String aramaKelimesi) async {
    var kisilerListesi = await Kisilerdao().kisiArama(aramaKelimesi);
    return kisilerListesi;
  }

  Future<void> silmek(int kisi_id) async {
    await Kisilerdao().kisiSil(kisi_id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AnasayfaModel>(
      builder: (context, AnasayfaModelNesne, child) {
        return FutureBuilder<List<Kisiler>>(
          future: AnasayfaModelNesne.aramaYapiliyorMu
              ? aramaYap(AnasayfaModelNesne.aramaKelimesi)
              : const HomeViewModel().tumKisileriGoster(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var kisilerListesi = snapshot.data;
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: kisilerListesi!.length,
                  itemBuilder: (context, index) {
                    var kisi = kisilerListesi[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => KisiDetaySayfa(
                                      kisi: kisi,
                                    )));
                      },
                      child: Card(
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                kisi.kullanici_adi,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                kisi.isim,
                              ),
                              Text(
                                kisi.soyisim,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: FloatingActionButton(
                                      onPressed: () {
                                        silmek(kisi.kisi_id);
                                      },
                                      child: const Icon(Icons.delete),
                                    ),
                                  ),
                                  SizedBox(
                                      height: 30,
                                      width: 10,
                                      child: Container()),
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: FloatingActionButton(
                                      onPressed: () {
                                        // router class
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  KisiEditSayfa(
                                                kisi: kisi,
                                              ),
                                            ));
                                      },
                                      child: const Icon(Icons.edit),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return const Center();
            }
          },
        );
      },
    );
  }
}
