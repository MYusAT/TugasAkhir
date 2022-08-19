import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'add_new_package.dart';
import 'http_service.dart';
import 'post_detail.dart';
import 'post_model.dart';
import 'barang_gudang_model.dart';
import 'global_var.dart';
import 'tambah_stok_barang.dart';

class PostsPage extends StatelessWidget {
  final HttpService_barang_di_gudang httpService = HttpService_barang_di_gudang();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      FutureBuilder(
        future: httpService.getBarangGudang(),
        builder: (BuildContext context, AsyncSnapshot<List<barang_gudang_model>> snapshot) {
          if (snapshot.hasData) {
            List<barang_gudang_model>? posts = snapshot.data;
            return ListView(
              children: posts
                  !.map(
                    (barang_gudang_model post) => ListTile(
                      title: 
                      Text("${post.namaPaket}",style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Stok : "+"${post.stok}"+" ${post.tipePaket}"+"/isi "+"${post.isiPaketPerPcs}"+"pcs"),
                          Text("Berada di Gudang ""${post.idLokasiGudang}")
                        ],
                      ),
                      
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PostDetail(
                            post: post,
                          ),
                        ),
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
      floatingActionButton: 
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget> [
          
          const SizedBox(height: 10),
          FloatingActionButton.extended(
            heroTag: "btn2",
            backgroundColor: Colors.blue,
            icon: Icon(Icons.add),
            label: const Text('Tambah Stok Barang'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => tambah_stok_barang()),
              );
            },
          ),
        ]
      ),
    );
  }
}