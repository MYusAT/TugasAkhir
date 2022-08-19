import 'package:coba2/get_list_supplier_model.dart';
import 'package:coba2/list_barang_berdasarkan_supplier.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'http_service.dart';
import 'get_list_supplier_model.dart';
import 'tambah_supplier.dart';
import 'global_var.dart';

class list_supplier extends StatelessWidget {
  final HttpService_get_list_supplier httpService = HttpService_get_list_supplier();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      FutureBuilder(
        future: httpService.getListSupplier(),
        builder: (BuildContext context, AsyncSnapshot<List<get_list_supplier_model>> snapshot) {
          if (snapshot.hasData) {
            List<get_list_supplier_model>? listSuppliers = snapshot.data;
            return ListView(
              children: listSuppliers
                  !.map(
                    (get_list_supplier_model listSupplier) => ListTile(
                      title: 
                      Text("${listSupplier.namaSupplier}",style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("id supplier : ${listSupplier.id}")
                        ],
                      ),
                      onTap: () {
                        //ngapain kl di klik
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => list_barang_berdasarkan_supplier()),
                        );
                        g_id_supplier_terpilih = listSupplier.id!;
                        g_nama_supplier_terpilih = listSupplier.namaSupplier!;
                      }
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
            heroTag: "btn3",
            backgroundColor: Colors.blue,
            icon: Icon(Icons.add),
            label: const Text('Tambah Supplier Baru'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => tambah_supplier()),
              );
            },
          ),
        ]
      ),
    );
  }
}