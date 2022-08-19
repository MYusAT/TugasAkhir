import 'package:flutter/material.dart';
import 'post_model.dart';
import 'barang_gudang_model.dart';
import 'global_var.dart';
import 'list_kartu_stok.dart' as kartu_stok;


class PostDetail extends StatelessWidget {
  final barang_gudang_model post;

  PostDetail({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${post.namaPaket}"),
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
                      title: Text("Nama Barang"),
                      subtitle: Text("${post.namaPaket}"),
                    ),
                    ListTile(
                      title: Text("id"),
                      subtitle: Text("${post.id}"),
                    ),
                    ListTile(
                      title: Text("Banyak Stok",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                      subtitle: Text("${post.stok}",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                    ),
                    ListTile(
                      title: Text("Dalam Bentuk"),
                      subtitle: Text("${post.tipePaket}"),
                    ),
                    ListTile(
                      title: Text("Berada di"),
                      subtitle: Text("Gudang "+"${post.idLokasiGudang}"),
                    ),
                    ListTile(
                      title: Text("Berat Paket"),
                      subtitle: Text("${post.beratPaket}"),
                    ),
                    ListTile(
                      title: Text("Harga Per pcs"),
                      subtitle: Text("Rp"+"${post.hargaPerPcs}"),
                    ),
                    ListTile(
                      title: Text("Isi Per pcs"),
                      subtitle: Text("${post.isiPaketPerPcs}"),
                    ),
                    ListTile(
                      title: Text("Nama Supplier"),
                      subtitle: Text("${post.namaSupplier}"),
                    ),
                  ],
                ),
              ),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                child : ButtonTheme( //submit button
                  minWidth: double.infinity,
                  
                  child: MaterialButton(
                    color: Colors.blueAccent,     //  <-- dark color
                    textTheme: ButtonTextTheme.primary,
                    height: 50,
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => kartu_stok.list_kartu_stok()),
                      );
                      g_id_brg_kartu_stok = post.id!;
                    },
                    child: const Text('Buka Kartu Stok',
                      style: TextStyle(
                        fontSize: 18.0,),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}