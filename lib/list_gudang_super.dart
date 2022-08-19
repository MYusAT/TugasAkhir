import 'package:coba2/isi_gudang.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'add_new_package.dart';
import 'http_service.dart';
import 'post_detail.dart';
import 'gudang_model.dart';
import 'tambah_gudang.dart';
import 'update_gudang_super.dart';
import 'global_var.dart';

class list_gudang_super extends StatelessWidget {
  final HttpService_gudang httpService = HttpService_gudang();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      FutureBuilder(
        future: httpService.getGudang(),
        builder: (BuildContext context, AsyncSnapshot<List<Gudang_Model>> snapshot) {
          if (snapshot.hasData) {
            List<Gudang_Model>? posts = snapshot.data;
            return ListView(
              children: posts
                  !.map(
                    (Gudang_Model post) => ListTile(
                      title: 
                      Text("${post.namaGudang}",style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Id Gudang : "+"${post.id}"),
                          Text("Alamat Gudang : "+"${post.alamatLengkap}")],
                      ),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => update_gudang()),
                        );
                        g_id_gudang_terpilih_super = post.id.toString();
                        g_nama_gudang_terpilih_super = post.namaGudang.toString();
                        g_alamat_gudang_terpilih_super = post.alamatLengkap.toString();
                      },
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
          FloatingActionButton.extended(
            heroTag: "btn2",
            backgroundColor: Colors.blue,
            icon: Icon(Icons.add),
            label: const Text('Tambah Gudang Baru'),
            onPressed: () {
              
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => tambah_gudang()),
              );
            },
          ),
        ]
      ),
    );
  }
}