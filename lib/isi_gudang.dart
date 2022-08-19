import 'package:flutter/material.dart';
import 'gudang_model.dart';
import 'add_new_package.dart';
import 'List_Status_Pemesanan_Barang.dart';
import 'list_pengiriman_barang.dart';
import 'http_service.dart';
import 'barang_gudang_model.dart';
import 'detail_isi_gudang.dart'as detail_isi;
import 'global_var.dart';
import 'transaksi_gudang.dart' as transaksi_gudang;
import 'global_var.dart';

class isi_gudang extends StatelessWidget {
  final Gudang_Model isi;
  final HttpService_barang_di_gudang_lain httpService = HttpService_barang_di_gudang_lain();

  isi_gudang({required this.isi});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Stok Barang Di dalam ${isi.namaGudang}"),
      ),
      body: FutureBuilder(
        future: httpService.getBarangGudang("${isi.id}"),
        builder: (BuildContext context, AsyncSnapshot<List<barang_gudang_model>> snapshot) {
          if (snapshot.hasData) {
            List<barang_gudang_model>? barang_gudang_models = snapshot.data;
            
            return ListView(
              children: barang_gudang_models
                  !.map(
                    (barang_gudang_model barang_gudang_model) => ListTile(
                      title: 
                      Text("${barang_gudang_model.namaPaket}",style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Stok Barang :"+"${barang_gudang_model.stok}"+" / "+"${barang_gudang_model.isiPaketPerPcs}"+" pcs"),
                        ],
                      ),
                      
                      onTap: () {Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => detail_isi.detail_isi_gudang(
                              Barang: barang_gudang_model,
                            ),
                          )
                        );
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
            label: Text('List Pengiriman Barang Ke\n${isi.namaGudang}',
              textAlign: TextAlign.center,),
            onPressed: () {
              g_id_gudang_lain_terpilih = isi.id.toString();
              g_nama_lengkap_gudang_lain_terpilih = isi.namaGudang.toString();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>list_pengiriman_barang()),
              );
            },
          ),
          SizedBox(height: 10),
          FloatingActionButton.extended(
            heroTag: "btn4",
            backgroundColor: Colors.blue,
            label: Text('List Pemesanan Barang\nGudang Saya',
              textAlign: TextAlign.center,),
            onPressed: () {
              g_id_gudang_lain_terpilih = isi.id.toString();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => List_Status_Pemesanan_Barang()),
              );
            },
          ),
          SizedBox(height: 10),
          FloatingActionButton.extended(
            heroTag: "btn5",
            backgroundColor: Colors.blue,
            icon: Icon(Icons.shopping_cart ),
            label: const Text('Keranjang Barang'),
            onPressed: () {
              g_id_gudang_lain_terpilih = isi.id.toString();
              if(g_list_id_barang_keranjang_gudang != 0 && g_list_nama_barang_keranjang_gudang.length != 0){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => transaksi_gudang.transaksi_gudang()),
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
      )
    );
  }
}