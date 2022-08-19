import 'package:flutter/material.dart';
import 'global_var.dart';
import 'http_service.dart';
import 'kartu_stok_model.dart';
import 'list_barang_berdasarkan_supplier_model.dart';

class list_barang_berdasarkan_supplier extends StatelessWidget {
  list_barang_berdasarkan_supplier({ Key? key }) : super(key: key);

  final HttpService_list_supplier_berdasarkan_supplier httpService = HttpService_list_supplier_berdasarkan_supplier();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Supplier ${g_nama_supplier_terpilih}"),
      ),
      body: FutureBuilder(
        future: httpService.getListBarangBerdasarkanSupplier(),
        builder: (BuildContext context, AsyncSnapshot<List<list_barang_berdasarkan_supplier_model>> snapshot) {
          if (snapshot.hasData) {
            List<list_barang_berdasarkan_supplier_model>? list_barang = snapshot.data;
            return ListView(
              children: list_barang
                  !.map(
                    (list_barang_berdasarkan_supplier_model list_barangs) => ListTile(
                      title: 
                      Text("Barang : ${list_barangs.namaPaket}",style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Kode Paket : ${list_barangs.kodePaket}"),
                        ],
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