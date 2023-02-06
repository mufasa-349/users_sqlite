import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:userswithmvvm/view/homeview/home_view.dart';

import '../../models/Kisilerdao.dart';
import '../../models/google_sheets_api.dart';

class KisiKayitSayfa extends StatefulWidget {
  const KisiKayitSayfa({Key? key}) : super(key: key);

  @override
  State<KisiKayitSayfa> createState() => _KisiKayitSayfaState();
}

class _KisiKayitSayfaState extends State<KisiKayitSayfa> {
  var tfkullanici_adi = TextEditingController();
  var tfisim = TextEditingController();
  var tfsoyisim = TextEditingController();
  var tfdogum_yili = TextEditingController();
  var tftckn = TextEditingController();
  DateTime dateTime = DateTime.now();

  Future<void> kayit(String kullanici_adi, String isim, String soyisim,
      String dogum_yili, String tckn) async {
    await Kisilerdao().kisiEkle(kullanici_adi, isim, soyisim, dogum_yili, tckn);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Anasayfa()));
  }

  /* Future<void> ekle(int kisi_id, String kullanici_adi, String isim,
      String soyisim, int dogum_yili, int tckn) async {
    await Kisilerdao().kisiEkle(kullanici_adi, isim, soyisim, dogum_yili, tckn);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AnaSayfa()));
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User"),
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
                  decoration: const InputDecoration(hintText: "Username"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: tfisim,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                  ],
                  decoration: const InputDecoration(hintText: "Name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: tfsoyisim,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                  ],
                  decoration: const InputDecoration(hintText: "Surname"),
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
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "TCKN"),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.calendar_month),
                    label: const Text("Please select your birthday"),
                    onPressed: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        context: context,
                        builder: (context) => Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                  height: 72,
                                  width: 300,
                                  child: buildDatePicker()),
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Done"),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Text(
                    DateFormat.yMMMd().format(dateTime),
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //tfdogum_yili = DateFormat.yMMMd().format(dateTime);
          kayit(tfkullanici_adi.text, tfisim.text, tfsoyisim.text,
              tfdogum_yili.text, tftckn.text);
          GoogleSheetsApi.insert(tfkullanici_adi.text, tfisim.text,
              tfsoyisim.text, tfdogum_yili.text, tftckn.text);
          setState(() {});
        },
        icon: const Icon(Icons.save),
        label: const Text("Save"),
      ),
    );
  }

  Widget buildDatePicker() => CupertinoDatePicker(
        minimumYear: 1900,
        maximumYear: DateTime.now().year,
        initialDateTime: DateTime.now(),
        mode: CupertinoDatePickerMode.date,
        onDateTimeChanged: (dateTime) =>
            setState(() => this.dateTime = dateTime),
      );
}
