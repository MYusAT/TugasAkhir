import 'package:coba2/get_list_supplier_model.dart';
import 'package:coba2/list_barang_berdasarkan_supplier.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'http_service.dart';
import 'list_admin_super_model.dart';
import 'tambah_user_super.dart';

class list_admin_super extends StatelessWidget {
  final HttpService_list_admin_super httpService = HttpService_list_admin_super();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      FutureBuilder(
        future: httpService.getListAdmin(),
        builder: (BuildContext context, AsyncSnapshot<List<list_admin_super_model>> snapshot) {
          if (snapshot.hasData) {
            List<list_admin_super_model>? listAdmins = snapshot.data;
            return ListView(
              children: listAdmins
                  !.map(
                    (list_admin_super_model listAdmin) => ListTile(
                      title: 
                      Text("${listAdmin.namaLengkap}",style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("kode Pegawai : ${listAdmin.kodePegawai}"),
                          Text("Email : ${listAdmin.email}"),
                          Text("Nomor Telefon : ${listAdmin.nomorTelfon}"),
                          Text("bekerja di : ${listAdmin.namaGudang}"),
                          Text("Role : ${listAdmin.role}"),
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
      floatingActionButton: 
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget> [
          FloatingActionButton.extended(
            heroTag: "btn1",
            backgroundColor: Colors.blue,
            icon: Icon(Icons.add),
            label: const Text('Tambah Admin Baru'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => tambah_user_super()),
              );
            },
          ),
        ]
      ),
    );
  }
}