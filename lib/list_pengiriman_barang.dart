import 'package:flutter/material.dart';
import 'global_var.dart';
import 'http_service.dart';
import 'kode_pengiriman_barang_model.dart';
import 'detail_pengiriman_barang.dart' as detail_pengiriman_barang;

class list_pengiriman_barang extends StatelessWidget {
  const list_pengiriman_barang({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return list_pengiriman_barang_func();
  }
}

class list_pengiriman_barang_func extends StatefulWidget {
  const list_pengiriman_barang_func({ Key? key }) : super(key: key);

  @override
  State<list_pengiriman_barang_func> createState() => _list_pengiriman_barang_funcState();
}

class _list_pengiriman_barang_funcState extends State<list_pengiriman_barang_func> {
  final HttpService_request_barang_berdasar_gudang httpService = HttpService_request_barang_berdasar_gudang();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Pengiriman Barang Ke\n ${g_nama_lengkap_gudang_lain_terpilih}"),
      ),
      body: FutureBuilder(
        future: httpService.getKodePesanan(),
        builder: (BuildContext context, AsyncSnapshot<List<kode_pengiriman_barang_model>> snapshot) {
          if (snapshot.hasData) {
            List<kode_pengiriman_barang_model>? RequestBarangs = snapshot.data;
            return ListView(
              children: RequestBarangs
                  !.map(
                    (kode_pengiriman_barang_model RequestBarang) => ListTile(
                      title: 
                      Text("Nomor Pesanan : ${RequestBarang.nomorPesanan}",style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Asal : gudang ${RequestBarang.idLokasiGudangAsal}, Tujuan : gudang ${RequestBarang.idLokasiGudangTujuan}"),
                          Text("Tanggal : ${RequestBarang.tanggalWaktu}"),
                          if(RequestBarang.statusPesanan == "diterima")
                          Text("Status Terima: ${RequestBarang.statusTerima}, Status Pesanan : ${RequestBarang.statusPesanan}",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                          if(RequestBarang.statusPesanan == "proses"||RequestBarang.statusPesanan== "dikirim")
                          Text("Status Terima: ${RequestBarang.statusTerima}, Status Pesanan : ${RequestBarang.statusPesanan}",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                          if(RequestBarang.statusPesanan == "ditolak")
                          Text("Status Terima: ${RequestBarang.statusTerima}, Status Pesanan : ${RequestBarang.statusPesanan}",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
                          
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => detail_pengiriman_barang.detail_pengiriman_barang()),
                        );
                        g_nomor_kirim_brg = RequestBarang.nomorPesanan!;
                        g_id_kirim_brg = RequestBarang.id!;
                        g_status_proses = RequestBarang.statusPesanan!;
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
    );
  }
}