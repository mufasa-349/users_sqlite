import 'dart:io';
import 'package:excel/excel.dart';
import 'package:userswithmvvm/models/Kisilerdao.dart';

import 'Kisiler.dart';

class excel {
  List<Kisiler> rowdetail = [];
  bool isKready = false;

  excelimport() async {
    var file =
        "/data/user/0/com.example.userswithmvvm/cache/file_picker/flutterexceltest3.xlsx";
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      print(table);
      print(excel.tables[table]!.maxCols);
      print(excel.tables[table]!.maxRows);
      for (int i = 1; i < excel.tables[table]!.rows.length; i++) {
        var row = excel.tables[table]!.rows[i];
        Kisiler kisi = Kisiler(
          int.parse(row[0]!.value.toString()),
          row[1]!.value.toString(),
          row[2]!.value.toString(),
          row[3]!.value.toString(),
          int.parse(row[4]!.value.toString()),
          int.parse(row[5]!.value.toString()),
        );
        rowdetail.add(kisi);
      }
      if (isKready == false) {
        for (var k in rowdetail) {
          print("id: ${k.kisi_id}");
          print("username: ${k.kullanici_adi}");
          print("isim: ${k.isim}");
          print("soyisim: ${k.soyisim}");
          print("dogum yılı: ${k.dogum_yili}");
          print("tckn: ${k.tckn}");

          Kisilerdao().kisiEkle(k.kullanici_adi, k.isim, k.soyisim,
              k.dogum_yili.toString(), k.tckn.toString());
          isKready = true;
        }
      } else {}
    }

    /*for (var row in excel.tables[table]!.rows) {
        print("${row.map((e) => e?.value)}");
        rowdetail.add("${row.map((e) => e?.value)}");
      }*/
  }
}

/*excelimportusers() async {
    var file =
        "/data/user/0/com.example.userswithmvvm/cache/file_picker/flutterexceltest3.xlsx";
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    for (var table in excel.tables.keys) {
      //print(table);
      //print(excel.tables[table]!.maxCols);
      //print(excel.tables[table]!.maxRows);
      for (int i = 1; i < excel.tables[table]!.rows.length; i++) {
        var row = excel.tables[table]!.rows[i];
        Kisiler kisi = Kisiler(
          int.parse(row[0]!.value.toString()),
          row[1]!.value.toString(),
          row[2]!.value.toString(),
          row[3]!.value.toString(),
          int.parse(row[4]!.value.toString()),
          int.parse(row[5]!.value.toString()),
        );
        rowdetail.add(kisi);
      }
      for (var k in rowdetail) {
        print("id: ${k.kisi_id}");
        print("username: ${k.kullanici_adi}");
        print("isim: ${k.isim}");
        print("soyisim: ${k.soyisim}");
        print("dogum yılı: ${k.dogum_yili}");
        print("tckn: ${k.tckn}");

        return Kisiler(k.kisi_id, k.kullanici_adi, k.isim, k.soyisim,
            k.dogum_yili, k.tckn);

        // return Kisiler(k.kisi_id, k.kullanici_adi, k.isim,
        // k.soyisim, k.dogum_yili, k.tckn);
      }
      /*for (var row in excel.tables[table]!.rows) {
        print("${row.map((e) => e?.value)}");
        rowdetail.add("${row.map((e) => e?.value)}");
      }*/
    }
  }*/
