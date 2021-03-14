import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ApiHeroig extends StatefulWidget {
  @override
  _ApiHeroigState createState() => _ApiHeroigState();
}

class _ApiHeroigState extends State<ApiHeroig> {
  final HttpService httpService = HttpService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api Heroig'),
      ),
      // mengapa future builder?
      // karena future builder adalah
      body: FutureBuilder(
        future: httpService.dapatkanPost(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData) {
            List<Post> posts = snapshot.data;
            return ListView(
              children: posts
                  .map(
                    (Post post) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(post.title),
                        subtitle: Text("user id : ${post.userId}"),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PostDetail(
                              post: post,
                            ),
                          ),
                        ),
                        tileColor: Colors.black45,
                      ),
                    ),
                  )
                  .toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class Post {
  // ini adalah inisiasi variabel pada class Post
  final String userId;
  final String id;
  final String title;
  final String body;

  // ini adalah pembuatan konstruktor Post agar semua variabel dari userid sampai body dapat dimasukkan dalam satu tempat yaitu class Post
  Post({
    @required this.userId,
    @required this.id,
    @required this.title,
    @required this.body,
  });

  // ini maksudnya kita akan membuat jenis data baru dengan nama Post
  factory Post.fromJson(Map<String, dynamic> json) {
    // return post ini akan memegang atau menghandle satu objek dalam list atau array yang ada dalam api
    // satu objek tersebut adalah
    /*
    {
    {{key: value}}
    "userId": 1,
    "id": 1,
    "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
    },
    */
    return Post(
      // seperti yang bisa dilihat dalam data jsonnya,key dari userid sampai body adalah string
      // dan valuenya adalah dynamic atau variabel yang jenis datanya berubah-ubah
      // nah, variabel dengan jenis data yang berubah-ubah ini akan diganti dengan satu jenis variabel data sendiri dengan perintah "as"
      userId: json['id'] as String,
      id: json['token'] as String,
      title: json['debitair'] as String,
      body: json['servo_low'] as String,
    );
  }
}

class HttpService {
  // ini adalah penegasan link mana yang ingin diambil datanya
  // jangan lupa dikasih final agar datanya ngak kemana-mana #konstan
  final linkApi = Uri.https("heroig.iteraiothme.com", "/api/123456789");

  Future<List<Post>> dapatkanPost() async {
    // abmil data yang ada pada link menggunakan perintah ini
    // menggunakan await agar bisa menunggu data yang ingin diperoleh ketika didownload.
    // data yang telah diperoleh dimasukkan kedalam variabel ambilData
    Response ambilData = await get(linkApi);

    // jika variabel ambilData berhasil memperoleh data dari url maka
    if (ambilData.statusCode == 200) {
      // maksud dari tubuh json ini adalah semua data yang ada dalam api yang mana meliputi data dari
      /*
      [
        {
          "userId": 1,
          "id": 1,
          "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
          "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
        },
        {
          "userId": 1,
          "id": 2,
          "title": "qui est esse",
          "body": "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla"
        },
        .
        .
        .
      ]
       */
      // ambil data dari kurung siku pertama sampai kurung siku akhir
      // List<dynamic> artinya adalah buat variabel list (atau array) yang didalamnya memuat data dinamis
      List<dynamic> tubuhJson = jsonDecode(ambilData.body);

      // List<Post> ini maksudnya adalah buat variabel posts list (atau array) yang datanya berupa Post #class.
      List<Post> semuaPostingan = tubuhJson
          .map(
            (dynamic item) => Post.fromJson(item),
          )
          .toList();
      //intinya pada bagian ini artinya memasukkan setiap nilai yang telah diperoleh pada tubuhjson kedalam setiap list yang ada pada variabel semua postingan

      // masukkan semua data yang ada pada variabel semuaPostingan kedalam variabel dapatkanPost
      return semuaPostingan;
    } else {
      throw "tidak dapat mengambil data post pd api jsonplaceholder";
    }
  }
}

// disini kita buat setiap elemen yang akan ditampilkan pada post detail
class PostDetail extends StatelessWidget {
  // buat variabel post dengan jenis data Post
  final Post post;

  // buat konstruktor berupa konstruktor dengan metode named parameter, dan sifatnya harus diisi (@required)
  PostDetail({@required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(post.title),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        title: Text("Title"),
                        subtitle: Text(post.title),
                      ),
                      ListTile(
                        title: Text("ID"),
                        subtitle: Text("${post.id}"),
                      ),
                      ListTile(
                        title: Text("Body"),
                        subtitle: Text(post.body),
                      ),
                      ListTile(
                        title: Text("User ID"),
                        subtitle: Text("${post.userId}"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
