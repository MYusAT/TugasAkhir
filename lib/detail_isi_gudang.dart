import 'package:coba2/gudang_model.dart';
import 'package:flutter/material.dart';
import 'post_model.dart';
import 'barang_gudang_model.dart';
import 'global_var.dart';

class detail_isi_gudang extends StatelessWidget {
  
  
  final barang_gudang_model Barang;

  detail_isi_gudang({required this.Barang});
  String pesan = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Isi Gudang"),
      ),
      body:SingleChildScrollView(
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
                      subtitle: Text("${Barang.namaPaket}"),
                    ),
                    ListTile(
                      title: Text("id"),
                      subtitle: Text("${Barang.id}"),
                    ),
                    ListTile(
                      title: Text("Banyak Stok"),
                      subtitle: Text("${Barang.stok}"),
                    ),
                    ListTile(
                      title: Text("Tipe Paket"),
                      subtitle: Text("${Barang.tipePaket}"),
                    ),
                    ListTile(
                      title: Text("Berada di"),
                      subtitle: Text("Gudang "+"${Barang.idLokasiGudang}"),
                    ),
                    ListTile(
                      title: Text("Berat Paket"),
                      subtitle: Text("${Barang.beratPaket}"),
                    ),
                    ListTile(
                      title: Text("Harga Per pcs"),
                      subtitle: Text("Rp"+"${Barang.hargaPerPcs}"),
                    ),
                    ListTile(
                      title: Text("Isi Per pcs"),
                      subtitle: Text("${Barang.isiPaketPerPcs}"),
                    ),
                    ListTile(
                      title: Text("Nama Supplier"),
                      subtitle: Text("${Barang.namaSupplier}"),
                    ),
                  ],
                ),
              ),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                child : ButtonTheme( //add button
                  minWidth: double.infinity,
                  
                  child: MaterialButton(
                    color: Colors.blueAccent,     //  <-- dark color
                    textTheme: ButtonTextTheme.primary,
                    height: 50,
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.

                      if (g_list_id_barang_keranjang_gudang.contains(Barang.id.toString())){
                        pesan = "Barang Sudah ada di keranjang";
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(pesan)),
                        );
                      }else {
                        g_list_id_barang_keranjang_gudang.add(Barang.id.toString());
                        g_list_nama_barang_keranjang_gudang.add(Barang.namaPaket.toString());
                        g_list_stok_barang_gudang_lain.add(Barang.stok.toString());
                        
                        print(g_list_nama_barang_keranjang_gudang);
                        pesan = "Barang Berhasil di masukkan ke keranjang";
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(pesan)),
                        );
                      }
                      
                    },
                    child: const Text('Masukkan ke keranjang',
                      style: TextStyle(
                        fontSize: 24.0,),
                    ),
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                child : ButtonTheme( //delete button
                  minWidth: double.infinity,
                  
                  child: MaterialButton(
                    color: Colors.redAccent,     //  <-- dark color
                    textTheme: ButtonTextTheme.primary,
                    height: 50,
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.

                      if (g_list_id_barang_keranjang_gudang.contains(Barang.id.toString())){
                        g_list_id_barang_keranjang_gudang.remove(Barang.id.toString());
                        g_list_nama_barang_keranjang_gudang.remove(Barang.namaPaket.toString());
                        g_list_stok_barang_gudang_lain.remove(Barang.stok.toString());
                        
                        print(g_list_nama_barang_keranjang_gudang);
                        pesan = "Barang Berhasil di Hapus dari keranjang";
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(pesan)),
                        );
                      }else{
                        print(g_list_nama_barang_keranjang_gudang);
                        pesan = "Barang Belum Ada di keranjang";
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(pesan)),
                        );
                      }
                      
                    },
                    child: const Text('Hapus Dari Keranjang',
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