import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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

  DateTime dateTime = DateTime.now();

  DateTime? intitialdate;

  void convertepochtonormal() {
    intitialdate =
        DateTime.fromMillisecondsSinceEpoch(int.parse(tfdogum_yili.text));
    setState(() {});
  }

  final _formKey = GlobalKey<FormState>();

  int epochtime = 0;

  Future<void> guncelle(int kisiId, String kullaniciAdi, String isim,
      String soyisim, String dogumYili, String tckn) async {
    await Kisilerdao()
        .kisiGuncelle(kisiId, kullaniciAdi, isim, soyisim, dogumYili, tckn);
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
    convertepochtonormal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit User"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                /*Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: tfdogum_yili,
                    decoration: InputDecoration(hintText: "Year of birth"),
                  ),
                ),*/
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      int numberofinput = value!.length;
                      return numberofinput == 11
                          ? null
                          : "TCKN must be 11 digits.";
                    },
                    controller: tftckn,
                    maxLength: 11,
                    decoration: const InputDecoration(hintText: "TCKN"),
                    obscureText: true,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
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
                                  onPressed: () {
                                    Navigator.pop(context);
                                    tfdogum_yili.text = epochtime.toString();
                                    setState(() {});
                                  },
                                  child: const Text("Done"),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    Text(
                      DateFormat.yMMMd().format(intitialdate!),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print(tfdogum_yili.text);
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Successfully Saved")),
            );
            guncelle(widget.kisi.kisi_id, tfkullanici_adi.text, tfisim.text,
                tfsoyisim.text, tfdogum_yili.text, tftckn.text);
          }
        },
        icon: const Icon(Icons.done),
        label: const Text("Edit"),
      ),
    );
  }

  Widget buildDatePicker() {
    void convertepochtonormal() {
      intitialdate =
          DateTime.fromMillisecondsSinceEpoch(int.parse(tfdogum_yili.text));
    }

    return CupertinoDatePicker(
      minimumYear: 1900,
      mode: CupertinoDatePickerMode.date,
      onDateTimeChanged: (dateTime) {
        setState(() {
          tfdogum_yili.text = epochtime.toString();
          epochtime = dateTime.millisecondsSinceEpoch;
          this.dateTime = dateTime;
          convertepochtonormal();
        });
      },
      maximumYear: DateTime.now().year,
      initialDateTime: intitialdate,
    );
  }
}
