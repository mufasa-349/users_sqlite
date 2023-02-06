import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:userswithmvvm/view/homeview/home_view.dart';

import '../../models/Kisiler.dart';
import '../../models/Kisilerdao.dart';

class KisiEditSayfa extends StatefulWidget {
  Kisiler kisi;

  KisiEditSayfa({required this.kisi});

  @override
  State<KisiEditSayfa> createState() => _KisiEditSayfaState();
}

class _KisiEditSayfaState extends State<KisiEditSayfa> {
  var tfkullanici_adi = TextEditingController();
  var tfisim = TextEditingController();
  var tfsoyisim = TextEditingController();
  var tfdogum_yili = TextEditingController();
  var tftckn = TextEditingController();

  Future<void> guncelle(int kisi_id, String kullanici_adi, String isim,
      String soyisim, String dogum_yili, String tckn) async {
    await Kisilerdao()
        .kisiGuncelle(kisi_id, kullanici_adi, isim, soyisim, dogum_yili, tckn);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Anasayfa()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var kisi = widget.kisi;
    tfkullanici_adi.text = kisi.kullanici_adi;
    tfisim.text = kisi.isim;
    tfsoyisim.text = kisi.soyisim;
    tfdogum_yili.text = kisi.dogum_yili.toString();
    tftckn.text = kisi.tckn.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit User"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: tfkullanici_adi,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp("[A-Za-z0-9#+-.]*")),
                  ],
                  decoration: InputDecoration(hintText: "Username"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: tfisim,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                  ],
                  decoration: InputDecoration(hintText: "Name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: tfsoyisim,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                  ],
                  decoration: InputDecoration(hintText: "Surname"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: tfdogum_yili,
                  decoration: InputDecoration(hintText: "Year of birth"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: tftckn,
                  maxLength: 11,
                  decoration: InputDecoration(hintText: "TCKN"),
                  obscureText: true,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          guncelle(widget.kisi.kisi_id, tfkullanici_adi.text, tfisim.text,
              tfsoyisim.text, tfdogum_yili.text, tftckn.text);
        },
        icon: Icon(Icons.done),
        label: Text("Edit"),
      ),
    );
  }
}
