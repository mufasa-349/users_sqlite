import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:userswithmvvm/view/homeview/home_view.dart';

import '../../models/Kisiler.dart';
import '../../models/Kisilerdao.dart';

class KisiDetaySayfa extends StatefulWidget {
  Kisiler kisi;

  KisiDetaySayfa({required this.kisi});

  @override
  State<KisiDetaySayfa> createState() => _KisiDetaySayfaState();
}

class _KisiDetaySayfaState extends State<KisiDetaySayfa> {
  var tfkullanici_adi = TextEditingController();
  var tfisim = TextEditingController();
  var tfsoyisim = TextEditingController();
  var tfdogum_yili = TextEditingController();
  var tftckn = TextEditingController();

  DateTime? thedate;

  void convertepochtonormal() {
    thedate = DateTime.fromMillisecondsSinceEpoch(int.parse(tfdogum_yili.text));
  }

  Future<void> guncelle(int kisiId, String kullaniciAdi, String isim,
      String soyisim, String dogumYili, String tckn) async {
    await Kisilerdao()
        .kisiGuncelle(kisiId, kullaniciAdi, isim, soyisim, dogumYili, tckn);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Anasayfa()));
  }

  @override
  void initState() {
    super.initState();
    var kisi = widget.kisi;
    tfkullanici_adi.text = kisi.kullanici_adi;
    tfisim.text = kisi.isim;
    tfsoyisim.text = kisi.soyisim;
    tfdogum_yili.text = kisi.dogum_yili.toString();
    tftckn.text = kisi.tckn.toString();
    convertepochtonormal();
    print(thedate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kullanıcı Detay"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Username: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(tfkullanici_adi.text)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "İsim: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(tfisim.text)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Soyisim: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(tfsoyisim.text)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Dogum yılı: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(DateFormat.yMMMd().format(thedate!))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "TCKN: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        "${tftckn.text[0]}${tftckn.text[1]}********${tftckn.text[9]}${tftckn.text[10]}"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
