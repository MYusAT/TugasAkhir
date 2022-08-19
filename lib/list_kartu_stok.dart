import 'package:flutter/material.dart';
import 'global_var.dart';
import 'http_service.dart';
import 'kartu_stok_model.dart';

class list_kartu_stok extends StatelessWidget {
  list_kartu_stok({ Key? key }) : super(key: key);

  final HttpService_kartu_stok httpService = HttpService_kartu_stok();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Pemesanan Barang\nGudang Pusat ${g_id_lokasi_gudang}"),
      ),
      body: FutureBuilder(
        future: httpService.getKartuStok(),
        builder: (BuildContext context, AsyncSnapshot<List<kartu_stok_model>> snapshot) {
          if (snapshot.hasData) {
            List<kartu_stok_model>? kartu_stok = snapshot.data;
            return ListView(
              children: kartu_stok
                  !.map(
                    (kartu_stok_model kartu_stoks) => ListTile(
                      title: 
                      Text("Kode Transaksi : ${kartu_stoks.noTransaksi}, Barang : ${kartu_stoks.namaPaket}, id barang :${kartu_stoks.id}",style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Tanggal transaksi : ${kartu_stoks.tglTransaksi}"),
                          Text("Keterangan : ${kartu_stoks.jmlPaket} ${kartu_stoks.tipePaket}, ${kartu_stoks.keterangan}"),
                          SizedBox(height: 8),
                          
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