import 'package:userswithmvvm/models/HomePageModel.dart';

import 'Kisiler.dart';
import 'VeritabaniYardimcisi.dart';

class Kisilerdao {
  Future<List<Kisiler>> tumKisiler() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM kisiler");

    return List.generate(maps.length, (i) {
      var satir = maps[i];

      return Kisiler(satir["kisi_id"], satir["kullanici_adi"], satir["isim"],
          satir["soyisim"], satir["dogum_yili"], satir["tckn"]);
    });
  }

  Future<List<Kisiler>> kisiArama(String aramaKelimesi) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM kisiler WHERE kullanici_adi like '%$aramaKelimesi%'");

    return List.generate(
      maps.length,
      (i) {
        var satir = maps[i];

        return Kisiler(satir["kisi_id"], satir["kullanici_adi"], satir["isim"],
            satir["soyisim"], satir["dogum_yili"], satir["tckn"]);
      },
    );
  }

  Future<void> kisiEkle(String kullanici_adi, String isim, String soyisim,
      String dogum_yili, String tckn) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var bilgiler = Map<String, dynamic>();
    bilgiler["kullanici_adi"] = kullanici_adi;
    bilgiler["isim"] = isim;
    bilgiler["soyisim"] = soyisim;
    bilgiler["dogum_yili"] = dogum_yili;
    bilgiler["tckn"] = tckn;

    await db.insert("kisiler", bilgiler);
  }

  Future<void> kisiSil(int kisi_id) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    await db.delete("kisiler", where: "kisi_id = ?", whereArgs: [kisi_id]);
  }

  Future<void> kisiGuncelle(int kisi_id, String kullanici_ad, String isim,
      String soyisim, String dogum_yili, String tckn) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var bilgiler = Map<String, dynamic>();
    bilgiler["kullanici_adi"] = kullanici_ad;
    bilgiler["isim"] = isim;
    bilgiler["soyisim"] = soyisim;
    bilgiler["dogum_yili"] = dogum_yili;
    bilgiler["tckn"] = tckn;

    await db
        .update("kisiler", bilgiler, where: "kisi_id=?", whereArgs: [kisi_id]);
  }
}
