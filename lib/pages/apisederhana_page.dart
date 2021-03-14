import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ApiSederhana extends StatefulWidget {
  @override
  _ApiSederhanaState createState() => _ApiSederhanaState();
}

class _ApiSederhanaState extends State<ApiSederhana> {
  void dapatkanData() async {
    // ini adalah perintah untuk menlakukan deskripsi link api mana yang mau ditampilkan datanya
    final linkurl = Uri.https('jsonplaceholder.typicode.com', '/posts/1');

    // ini perintah mendapatkan data dari apinya dengan menunggu (await) terlebih dahulu datanya terunduh, kemudian dimasukkan kedalam variabel
    var respon = await http.get(linkurl);
    // ini adalah perintah pengendalian error
    // respon.statuscode == 200 artinya, ketika telah menemukan atau mendapatkan data api, akan mendapatkan staus code 200,
    // inilah yang menjadi patokan pembacaan api berhasil atau tidak
    if (respon.statusCode == 200) {
      // jika berhasil, konversikan data pada variabel respon menjadi data json yang dapat dipahami jenis datanya.
      // karena "semua" data pada variabel respon jenisnya adalah "string" dari awal sampai akhir
      /* 
      {
      "userId": 1,
      "id": 1,
      "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
      "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
      }
      */
      // semua data variabel "respon" diatas jenisnya adalah string kebayangkan, gimana kalau kurung kurawal dan data "title"-nya jadi satu jenis dan ngak putus jenisdatanya?
      // gimana nampilin data "title"-doang? gak bisa kan? makannya harus dikonversi dulu atau dipecah satu persatu
      // pemecahannya menggunakan perintah "convert.jsonDecode(respon.body)" dari sini, kita mendapatkan variabel dataKonversi yang jenis datanya adaalh "Map"
      var dataKonversi = convert.jsonDecode(respon.body);
      // kemudian kita akan menampilkan data 'title' yang ada di variabel "dataKonversi" menggunakan penunjuk variabel "Map" yaitu kurung siku
      // yang didalamnya ada string 'title' yang mana merupakan "key" dari "Map"

      // sebagai contoh
      // ini key : ini value
      // "userId": 1,
      var judulPadaApi = dataKonversi['title'];
      // tampilkan data yang telah diperoleh kedalam debug console
      print('data yang diperoleh : $judulPadaApi.');
    } else {
      // jika terjadi error, tampilkan juga dalam debug console (karena tidak ada jaringan, dll)
      print('data gagal didapatkan karena : ${respon.statusCode}.');
    }
  }

  @override
  // function "dapatkandata" yang ada di initState ini akan dieksekusi hanya sekali
  // kenapa hanya sekali? karena function "dapatkandata" berada didalam stateful widget yang mana datanya berubah-ubah
  void initState() {
    super.initState();
    dapatkanData();
  }

  @override
  Widget build(BuildContext context) {
    var respon = 'hai dar respon lokal';
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => print(respon),
      ),
      appBar: AppBar(
        title: Text('Api Sederhana'),
        centerTitle: true,
      ),
      body: Center(
        child: TextButton(
          child: Text('kembali'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
