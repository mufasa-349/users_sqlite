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

  Future<void> kisiEkle(String kullaniciAdi, String isim, String soyisim,
      String dogumYili, String tckn) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var bilgiler = <String, dynamic>{};
    bilgiler["kullanici_adi"] = kullaniciAdi;
    bilgiler["isim"] = isim;
    bilgiler["soyisim"] = soyisim;
    bilgiler["dogum_yili"] = dogumYili;
    bilgiler["tckn"] = tckn;

    await db.insert("kisiler", bilgiler);
  }

  Future<void> kisiSil(int kisiId) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    await db.delete("kisiler", where: "kisi_id = ?", whereArgs: [kisiId]);
  }

  Future<void> kisiGuncelle(int kisiId, String kullaniciAd, String isim,
      String soyisim, String dogumYili, String tckn) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var bilgiler = <String, dynamic>{};
    bilgiler["kullanici_adi"] = kullaniciAd;
    bilgiler["isim"] = isim;
    bilgiler["soyisim"] = soyisim;
    bilgiler["dogum_yili"] = dogumYili;
    bilgiler["tckn"] = tckn;

    await db
        .update("kisiler", bilgiler, where: "kisi_id=?", whereArgs: [kisiId]);
  }
}
