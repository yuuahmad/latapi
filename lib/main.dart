import 'package:flutter/material.dart';
import 'package:latapi/pages/apisederhana_page.dart';
import 'package:latapi/pages/apibanyaksederhana_page.dart';

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int hitungan = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                hitungan++;
              });
              print(hitungan);
            },
          ),
          appBar: AppBar(
            title: Text('Latihan Api'),
            centerTitle: true,
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                DrawerHeader(child: Center(child: Text('Pilih Menu Anda'))),
                Listsaya(
                  ikonsaya: Icons.add_box,
                  judul: 'Latihan Api Sederhana',
                  halaman: ApiSederhana(),
                ),
                Listsaya(
                  judul: 'Latihan Api Banyak Sederhana',
                  halaman: ApiBanyakSederhana(),
                  ikonsaya: Icons.add_circle,
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text('Selamat Datang Di App Pengenalan Api'),
            ),
          )),
    );
  }
}

class Listsaya extends StatelessWidget {
  final String judul;
  final ikonsaya;
  final halaman;
  Listsaya({this.ikonsaya, this.judul, this.halaman});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(ikonsaya),
      title: Text(judul),
      onTap: () {
        print(judul);
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => halaman,
            ));
      },
    );
  }
}
