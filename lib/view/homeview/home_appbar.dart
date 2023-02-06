part of home_view;

class ArarkenTitle extends StatefulWidget {
  const ArarkenTitle({Key? key}) : super(key: key);

  @override
  State<ArarkenTitle> createState() => _ArarkenTitleState();
}

class _ArarkenTitleState extends State<ArarkenTitle> {
  /**/

  @override
  Widget build(BuildContext context) {
    return Consumer<AnasayfaModel>(
        builder: (context, AnasayfaModelNesne, child) {
      return TextField(
        decoration: InputDecoration(hintText: "Search by username"),
        onChanged: (search) {
          print("Search result : $search");
          setState(() {
            AnasayfaModelNesne.aramaKelimesi = search;
            AnasayfaModelNesne.arakelime();
          });
        },
      );
    });
  }
}

class AramazkenTitle extends StatefulWidget {
  const AramazkenTitle({Key? key}) : super(key: key);

  @override
  State<AramazkenTitle> createState() => _AramazkenTitleState();
}

class _AramazkenTitleState extends State<AramazkenTitle> {
  @override
  Widget build(BuildContext context) {
    return const Text("User SQLite");
  }
}

class AramazkenIcon extends StatefulWidget {
  const AramazkenIcon({Key? key}) : super(key: key);

  @override
  State<AramazkenIcon> createState() => _AramazkenIconState();
}

class _AramazkenIconState extends State<AramazkenIcon> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AnasayfaModel>(
        builder: (context, AnasayfaModelNesne, child) {
      return IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          setState(() {
            AnasayfaModelNesne.aramaaktif();
          });
        },
      );
    });
  }
}

class ArarkenIcon extends StatefulWidget {
  const ArarkenIcon({Key? key}) : super(key: key);

  @override
  State<ArarkenIcon> createState() => _ArarkenIconState();
}

class _ArarkenIconState extends State<ArarkenIcon> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AnasayfaModel>(
        builder: (context, AnasayfaModelNesne, child) {
      return IconButton(
        icon: const Icon(Icons.cancel),
        onPressed: () {
          setState(() {
            AnasayfaModelNesne.aramaaktifdegil();
            AnasayfaModelNesne.aramaKelimesi = "";
          });
        },
      );
    });
  }
}
