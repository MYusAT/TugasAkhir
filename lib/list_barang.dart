import 'package:flutter/material.dart';
import 'global_var.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'http_service.dart';
import 'barang_model.dart';
import 'tambah_stok_barang_jmlBrg.dart' as jml_brg;
import 'detail_pilihbarang.dart' as detail_brg;
import 'add_new_package.dart' as tambah_barang;
import 'detail_barang_home.dart' as detail;

class list_barang extends StatefulWidget {
  const list_barang({ Key? key }) : super(key: key);

  @override
  State<list_barang> createState() => _list_barangState();
}

class _list_barangState extends State<list_barang> {
  final HttpService httpService = HttpService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          builder: (context) => detail.detail_barang(
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
            heroTag: "btn1",
            backgroundColor: Colors.blue,
            icon: Icon(Icons.add),
            label: const Text('Tambah Barang Baru'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => tambah_barang.add_new_package()),
              );
            },
          ),
        ]
      ),
    );
  }
}