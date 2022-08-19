import 'package:coba2/barang_model.dart';
import 'package:flutter/material.dart';
import 'Supplier_Model.dart';
import 'barang_gudang_model.dart';
import 'global_var.dart';
import 'package:flutter/foundation.dart';

class pilihbarang_detail extends StatelessWidget {
  final barang_model barang;
  late String pesan = "Klik";
 pilihbarang_detail({required this.barang});

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
              Padding(padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                child : ButtonTheme( //submit button
                  minWidth: double.infinity,
                  
                  child: MaterialButton(
                    color: Colors.blueAccent,     //  <-- dark color
                    textTheme: ButtonTextTheme.primary,
                    height: 50,
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.

                      if (g_id_List_barang_terpilih.contains(barang.id.toString())){
                        pesan = "Sudah ada Barang nya";
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(pesan)),
                        );
                      }else {
                        g_id_List_barang_terpilih.add(barang.id.toString());
                        g_nama_List_barang_terpilih.add(barang.namaPaket.toString());
                        
                        print(g_nama_List_barang_terpilih);
                        pesan = "Barang Berhasil di Insert";
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(pesan)),
                        );
                      }
                      
                    },
                    child: const Text('Insert Item',
                      style: TextStyle(
                        fontSize: 24.0,),
                    ),
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                child : ButtonTheme( //submit button
                  minWidth: double.infinity,
                  
                  child: MaterialButton(
                    color: Colors.redAccent,     //  <-- dark color
                    textTheme: ButtonTextTheme.primary,
                    height: 50,
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.

                      if (g_id_List_barang_terpilih.contains(barang.id.toString())){
                        g_id_List_barang_terpilih.remove(barang.id.toString());
                        g_nama_List_barang_terpilih.remove(barang.namaPaket.toString());
                        
                        print(g_nama_List_barang_terpilih);
                        pesan = "Barang Berhasil di Hapus";
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(pesan)),
                        );
                      }else{
                        print(g_nama_List_barang_terpilih);
                        pesan = "Barang Belum Ada";
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(pesan)),
                        );
                      }
                      
                    },
                    child: const Text('Delete Item',
                      style: TextStyle(
                        fontSize: 24.0,),
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