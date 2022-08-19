import 'package:flutter/material.dart';
import 'global_var.dart';
import 'http_service.dart';
import 'status_pesanan_model.dart';
import 'detail_status_pemesanan_barang.dart' as detail_status_pesanan;

class List_Status_Pemesanan_Barang extends StatelessWidget {
  const List_Status_Pemesanan_Barang({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return list_pemesanan_func();
  }
}

class list_pemesanan_func extends StatefulWidget {
  const list_pemesanan_func({ Key? key }) : super(key: key);

  @override
  State<list_pemesanan_func> createState() => _list_pemesanan_funcState();
}

class _list_pemesanan_funcState extends State<list_pemesanan_func> {
  final HttpService_status_pemesanan httpService = HttpService_status_pemesanan();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Pemesanan Barang\n ${g_nama_lengkap_gudang}"),
      ),
      body: FutureBuilder(
        future: httpService.getStatusPemesanan(),
        builder: (BuildContext context, AsyncSnapshot<List<status_pesanan_model>> snapshot) {
          if (snapshot.hasData) {
            List<status_pesanan_model>? pesanan_barang = snapshot.data;
            return ListView(
              children: pesanan_barang
                  !.map(
                    (status_pesanan_model Status_pemesanan_barang) => ListTile(
                      title: 
                      Text("Nomor pesanan : ${Status_pemesanan_barang.nomorPesanan}",style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Asal : Gudang ${Status_pemesanan_barang.idLokasiGudangAsal}, Tujuan : Gudang ${Status_pemesanan_barang.idLokasiGudangTujuan}"),
                          Text("Tanggal : ${Status_pemesanan_barang.tanggalWaktu}"),
                          if(Status_pemesanan_barang.statusPesanan == "diterima")
                          Text("Status Terima: ${Status_pemesanan_barang.statusTerima}, Status Pesanan : ${Status_pemesanan_barang.statusPesanan}",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                          if(Status_pemesanan_barang.statusPesanan == "proses"||Status_pemesanan_barang.statusPesanan == "dikirim")
                          Text("Status Terima: ${Status_pemesanan_barang.statusTerima}, Status Pesanan : ${Status_pemesanan_barang.statusPesanan}",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                          if(Status_pemesanan_barang.statusPesanan == "ditolak")
                          Text("Status Terima: ${Status_pemesanan_barang.statusTerima}, Status Pesanan : ${Status_pemesanan_barang.statusPesanan}",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
                          SizedBox(height: 8),
                          /*ElevatedButton.icon(
                            onPressed: () {
                                // Respond to button press
                            },
                            icon: Icon(Icons.arrow_forward_rounded, size: 18),
                            label: Text("Terima"),
                          )*/
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => detail_status_pesanan.detail_status_pemesanan_barang()),
                        );
                        g_nomor_pesanan_status_pesanan_brg = Status_pemesanan_barang.nomorPesanan!;
                        g_id_status_pesanan_brg = Status_pemesanan_barang.id!;
                        g_status_terima_brg = Status_pemesanan_barang.statusTerima!;
                        g_status_pesanan_brg = Status_pemesanan_barang.statusPesanan!;
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