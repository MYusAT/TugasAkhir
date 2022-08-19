import 'package:coba2/barang_model.dart';
import 'package:flutter/material.dart';
import 'Supplier_Model.dart';
import 'barang_gudang_model.dart';
import 'global_var.dart';
import 'package:flutter/foundation.dart';

class detail_barang extends StatelessWidget {
  final barang_model barang;
  late String pesan = "Klik";
 detail_barang({required this.barang});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${barang.namaPaket}"),
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
                      subtitle: Text("${barang.namaPaket}"),
                    ),
                    ListTile(
                      title: Text("id"),
                      subtitle: Text("${barang.id}"),
                    ),
                    ListTile(
                      title: Text("Kode Paket"),
                      subtitle: Text("${barang.kodePaket}"),
                    ),
                    ListTile(
                      title: Text("Tipe Paket"),
                      subtitle: Text("${barang.tipePaket}"),
                    ),
                    ListTile(
                      title: Text("Berat Paket"),
                      subtitle: Text("${barang.beratPaket}"),
                    ),
                    ListTile(
                      title: Text("Harga Per pcs"),
                      subtitle: Text("Rp"+"${barang.hargaPerPcs}"),
                    ),
                    ListTile(
                      title: Text("Isi dalam pcs"),
                      subtitle: Text("${barang.isiPaketPerPcs}"),
                    ),
                    ListTile(
                      title: Text("Id Supplier"),
                      subtitle: Text("${barang.idSupplier}"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}

class Isi extends StatefulWidget {
  const Isi({ Key? key }) : super(key: key);

  @override
  State<Isi> createState() => _IsiState();
}

class _IsiState extends State<Isi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}