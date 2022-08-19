import 'package:coba2/isi_gudang.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'add_new_package.dart';
import 'http_service.dart';
import 'post_detail.dart';
import 'gudang_model.dart';

class GudangPage extends StatelessWidget {
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
                      
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => isi_gudang(
                            isi: post,
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
    );
  }
}