import 'dart:async';

import 'package:flutter/material.dart';
import 'detail_status_pesanan_model.dart';
import 'global_var.dart';
import 'http_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home.dart'as home;

class detail_status_pemesanan_barang extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return status_pemesanan_func();
  }
}

class status_pemesanan_func extends StatefulWidget {
  const status_pemesanan_func({ Key? key }) : super(key: key);

  @override
  State<status_pemesanan_func> createState() => _status_pemesanan_funcState();
}

class _status_pemesanan_funcState extends State<status_pemesanan_func> {
  final HttpService_detail_status_pemesanan httpService = HttpService_detail_status_pemesanan();

  late bool error, sending, success;
  late String msg;
  late List <String> isi_jml = [];
  late String pesan = "";
  
  @override
  void initState() {
      error = false;
      sending = false;
      success = false;
      msg = "";
      super.initState();
  }

  Future<void> SendTerimaPesanan() async {
    String postsURL = 'https://kecapy.com/webservice.php';
    
    var res = await http.post(Uri.parse(postsURL), body: {
        "CMD":"update_data_pesanan_dan_transaksi",
        "nomor_pesanan":g_id_status_pesanan_brg,
        "status":"diterima"
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var decoded_Json_data = json.decode(res.body); //decoding json to array

      if(decoded_Json_data["berhasil"]==true){
        pesan = decoded_Json_data["message"];
        print(pesan);
        
        //Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Update Data Berhasil')),
        );

        Timer(const Duration(seconds: 3), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => home.myhome()),
          );
        });

        setState(() {
            sending = false;
            success = true; //mark success and refresh UI with setState
        });
      }else if(decoded_Json_data["error"]==true){
        setState(() { //refresh the UI when error is recieved from server
            sending = false;
            error = true;
            msg = decoded_Json_data["message"]; //error message from server
        });
      }
      
    }else{
        //there is error
        setState(() {
            error = true;
            msg = "Error during sendign data.";
            sending = false;
            //mark error and refresh UI with setState
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Pemesanan ${g_nomor_pesanan_status_pesanan_brg}"),
      ),
      body: FutureBuilder(
        future: httpService.getDetailStatusPemesanan(),
        builder: (BuildContext context, AsyncSnapshot<List<detail_status_pesanan_barang_model>> snapshot) {
          if (snapshot.hasData) {
            List<detail_status_pesanan_barang_model>? pesanan_barang = snapshot.data;
            return ListView(
              children: pesanan_barang
                  !.map(
                    (detail_status_pesanan_barang_model Status_pemesanan_barang) => ListTile(
                      title: 
                      Text("Nama Barang : ${Status_pemesanan_barang.namaPaket}",style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Jml yang di pesan : ${Status_pemesanan_barang.jmlPaket} ${Status_pemesanan_barang.tipePaket}, \nKode Paket : ${Status_pemesanan_barang.kodePaket}"),
                          Text("Berat Paket : ${Status_pemesanan_barang.beratPaket} Kg"),
                          if(Status_pemesanan_barang.statusPesanan == "diterima")
                          Text("Status Penerimaan : \n${Status_pemesanan_barang.statusTerima} oleh ${Status_pemesanan_barang.gudangTujuan}",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                          if(Status_pemesanan_barang.statusPesanan == "proses")
                          Text("Status Penerimaan : \n${Status_pemesanan_barang.statusTerima} oleh ${Status_pemesanan_barang.gudangTujuan}",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                          if(Status_pemesanan_barang.statusPesanan == "dikirim")
                          Text("Status Penerimaan : sedang ${Status_pemesanan_barang.statusTerima}",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                          if(Status_pemesanan_barang.statusPesanan == "ditolak")
                          Text("Status Penerimaan : ${Status_pemesanan_barang.statusTerima}",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
                          if(Status_pemesanan_barang.statusPesanan == "diterima")
                          Text("Status Pesanan : ${Status_pemesanan_barang.statusPesanan}",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                          if(Status_pemesanan_barang.statusPesanan == "proses")
                          Text("Status Pesanan : ${Status_pemesanan_barang.statusPesanan}",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                          if(Status_pemesanan_barang.statusPesanan == "dikirim")
                          Text("Status Pesanan : ${Status_pemesanan_barang.statusPesanan}",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                          if(Status_pemesanan_barang.statusPesanan == "ditolak")
                          Text("Status Pesanan : ${Status_pemesanan_barang.statusPesanan}",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
                          Text("Gudang Asal : ${Status_pemesanan_barang.gudangAsal}, \nGudang Tujuan : ${Status_pemesanan_barang.gudangTujuan}"),
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
      floatingActionButton: 
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget> [
          if(g_status_pesanan_brg == "dikirim")
          FloatingActionButton.extended(
            heroTag: "btn6",
            backgroundColor: Colors.blue,
            label: Text('Barang di Terima',
              textAlign: TextAlign.center,),
            onPressed: () {
              //what to do here
              setState(() {
                sending = true;
              });
              SendTerimaPesanan();
            },
          ),
        ],
      ),

    );
  }
}