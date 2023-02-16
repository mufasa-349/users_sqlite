part of home_view;

class fab extends StatefulWidget {
  const fab({Key? key}) : super(key: key);

  @override
  State<fab> createState() => _fabState();
}

class _fabState extends State<fab> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        setState(() {});
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => KisiKayitSayfa()));
      },
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}
