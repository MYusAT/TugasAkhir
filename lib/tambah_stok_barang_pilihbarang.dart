import 'package:flutter/material.dart';
import 'global_var.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'http_service.dart';
import 'barang_model.dart';
import 'tambah_stok_barang_jmlBrg.dart' as jml_brg;
import 'detail_pilihbarang.dart' as detail_brg;

class tambah_stok_pilih_barang extends StatefulWidget {
  const tambah_stok_pilih_barang({ Key? key }) : super(key: key);

  @override
  State<tambah_stok_pilih_barang> createState() => _tambah_stok_pilih_barangState();
}

class _tambah_stok_pilih_barangState extends State<tambah_stok_pilih_barang> {
  final HttpService httpService = HttpService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Stok Barang - pilih barang'),
      ),
      body: FutureBuilder(
        future: httpService.getBarang(),
        builder: (BuildContext context, AsyncSnapshot<List<barang_model>> snapshot) {
          if (snapshot.hasData) {
            List<barang_model>? barang_models = snapshot.data;
            return ListView(
              children: barang_models
                  !.map(
                    (barang_model barang_model) => ListTile(
                      title: 
                      Text("${barang_model.namaPaket}",style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Kode Barang : "+"${barang_model.kodePaket}"),
                        ],
                      ),
                      
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => detail_brg.pilihbarang_detail(
                            barang: barang_model,
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
          FloatingActionButton.extended(
            backgroundColor: Colors.blue,
            icon: Icon(Icons.arrow_forward ),
            label: const Text('Selanjutnya'),
            onPressed: () {
              if(g_id_List_barang_terpilih.length != 0 && g_nama_List_barang_terpilih.length != 0){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => jml_brg.tambah_stok_jmlBrg()),
                );
              }else{
                String pesan = "Belum ada item yang di pilih";
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(pesan)),
                );
              }
            },
          ),
        ]
      ),
    );
  }
}