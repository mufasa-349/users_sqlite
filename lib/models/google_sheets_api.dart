import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "avid-reference-376509",
  "private_key_id": "8f1beba9c2cc5226cf51d60efc60a434232dfee9",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEugIBADANBgkqhkiG9w0BAQEFAASCBKQwggSgAgEAAoIBAQClecv2eGdjvrHf\npFWcyBpCxTl10HBQbL+0LTh+md/2IWUv7HqV1rhTIjWEEPp2fayJFg4DUk7CFcl2\nvF5FrMg/Pfgy7b5D/d+4N2t1d9MIfQf3wfmKhVligg1BQofp77RlwUVboS7UGafo\nCYJ7FHqFH0PvPhhcb3VVKwJaCd+n8aGijWvFuaet8+9RNZvVsUQitTM8vh7aK7Xi\nKBsqha7+kj9oyWK3hkD2ccjw7oRxxjTtGbtXz1jl2Yd2aCkXkNfO7WGKl/5KTID3\nyx8Bbxvd1oIBZX5RH7cMTnrs0+ObzJxMI1yIpCQVenhdPH/JwRG3SHwHvV2CYhIG\nvA+4witTAgMBAAECggEAALMqLKyZJYcfw3eQjjjs+4IKN4nMyIjXZOf2mgYcZqd1\nUo5LN4Z5al/ekvvIfZXN8RkIU8a5QC/78pqFiEcuKf/D6oP0K/a36oMWlYjgS4b8\nk4yuYlNTVHSCuJF77AoBxZbyrD1bR56NQBDN3gSrViuHC8FbBe4mwBJIZ88VPs5Q\nnTSueqr8e6hFbB/wSkAQQtnNLz2ty8WPuCxDZOXEKJbrP81BjbZYS8HmK5qy+wd3\nOBhEBVge2jiwcpjV5DuvhQmRWoWdLb04sdhpeB1WBpl++E7JrmrpixjxWybrnJL/\npw644nI90O1C0NoPKUMrH8Plsk3R2jydBlBsFknLuQKBgQDjiF02Arkpjy/Qgm9n\nMvnh4tEU4MGG49JM0wXtUL4aVWD64Y60dEoIOfuC6cRaQ2VCBxkaNCSD3/iJv6Tr\nrFP62JIq3pnQmGldIkfTBiHRE9Wc99nxO93soWCB9ICmeCN6p3fXgzIgJgLTIyOQ\nj0oMkYWS2ILwp/jiyrJe9/X1rQKBgQC6LdBy0K17mDvxxjZqXV+B0H/rWu/3GEaR\nsLE699uYh8m5PcyyvenY7M/X/iIm59u5SWKslSMiyrBuS12dUvGGkcXnabFgwOH7\nznILxKeW6wW+AiDYdYRTGUoUbAV02mLQUPMb1EuSAvWS/KsvKYk4AXhYlYVXuf25\nQD43RpLE/wKBgHrXBivAsKLFUTUrFmYK2WmggOzaouDmYoVjcFG9Q8UHz0HjQJ4g\nIk/qreTxvDZXKHXLSzwgZo5j/tSviKRL91L4VYGbiENb5ZaIiWpeZydvo+YI0bsx\nbRDx1x6SGFrHhbAUddj+VbORkfjXgb3r/jhm4Ex1Y8v1g6M9d6taB4pJAoGAfEKp\ntof60dv4XlT56qHpZb4gMpheQuAr8X8puv7EzRgMFhveLIo+sq7TxghzCN6FMzR8\nrE1ZxxXbDbI1iBRc6YEPwnUzky0JZ0QRsDMP29V+3qOTAoXkzIW7gMfcGHLNstXk\nfHWD/q8E8pa7Nl4VnJC2nwEknzme027CV6g9u0cCf11lATqaYJiMtbpAS7qSTC4X\nwF/kl5jbXvzoo0yFxCnx/aG3qb+xPEJSHZUIC9p4ywfVbxdccB1k6KvZcD8Y5LjN\nBR6DhoZBz9md+1o4iXyZcijIKbGkKpdgeue7A8biUEWr4VX/z5afeP78u5eglAl4\nubSahMKI6P6nPkyK9W4=\n-----END PRIVATE KEY-----\n",
  "client_email": "fluttertest@avid-reference-376509.iam.gserviceaccount.com",
  "client_id": "109664807563025439448",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/fluttertest%40avid-reference-376509.iam.gserviceaccount.com"
}

  ''';
  static final _spreadsheetID = "16jDq-OPCX0PDGR-ntF3V8WQfB089tfcUY7gtVoIy3A4";
  static final gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

  static int numberOfUsers = 0;

  static int kisi_id = 0;
  static List<List<dynamic>> kisiler = [];

  Future init() async {
    final ss = await gsheets.spreadsheet(_spreadsheetID);
    _worksheet = ss.worksheetByTitle("Worksheet1");
  }

  static Future insert(String? kullanici_adi, String? isim, String? soyisim,
      String? dogum_yili, String? tckn) async {
    await _worksheet!.values
        .appendRow([kisi_id, kullanici_adi, isim, soyisim, dogum_yili, tckn]);
  }

// Google Sheets'ten veri alma başarısız

/*static Future countRows() async {
    while (
        (await _worksheet!.values.value(column: 1, row: numberOfUsers)) != '') {
      numberOfUsers++;
    }
    loadUsers();
  }

  static Future loadUsers() async {
    for (int i = 2; i < numberOfUsers; i++) {
      final dynamic newUser =
          await _worksheet!.values.value(column: 1, row: i + 1);
      if (kisiler.length < numberOfUsers) {
        kisiler.add(newUser);
      }
    }
  }*/
}
