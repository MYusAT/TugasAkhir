import 'dart:async';

import 'package:flutter/material.dart';
import 'detail_status_pesanan_model.dart';
import 'global_var.dart';
import 'http_service.dart';
import 'detail_kirim_barang_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home.dart'as home;

class detail_pengiriman_barang extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return detail_pengiriman_barang_func();
  }
}

class detail_pengiriman_barang_func extends StatefulWidget {
  const detail_pengiriman_barang_func({ Key? key }) : super(key: key);

  @override
  State<detail_pengiriman_barang_func> createState() => _detail_pengiriman_barang_funcState();
}

class _detail_pengiriman_barang_funcState extends State<detail_pengiriman_barang_func> {
  final HttpService_kirim_barang httpService = HttpService_kirim_barang(); 

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

  Future<void> SendUpdatePesananDikirim() async {
    String postsURL = 'https://kecapy.com/webservice.php';
    
    var res = await http.post(Uri.parse(postsURL), body: {
        "CMD":"update_data_pesanan_dan_transaksi",
        "nomor_pesanan":g_id_kirim_brg,
        "status":"dikirim"
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

  Future<void> SendTolakPesanan() async {
    String postsURL = 'https://kecapy.com/webservice.php';
    
    var res = await http.post(Uri.parse(postsURL), body: {
        "CMD":"update_data_pesanan_dan_transaksi",
        "nomor_pesanan":g_id_kirim_brg,
        "status":"ditolak"
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
        title: Text("Detail Pengiriman ${g_nomor_kirim_brg}"),
      ),
      body: FutureBuilder(
        future: httpService.getKirimBarang(),
        builder: (BuildContext context, AsyncSnapshot<List<detail_kirim_barang_model>> snapshot) {
          if (snapshot.hasData) {
            List<detail_kirim_barang_model>? kirim_barang = snapshot.data;
            return ListView(
              children: kirim_barang
                  !.map(
                    (detail_kirim_barang_model kirim_model_barang) => ListTile(
                      title: 
                      Text("Nama Barang : ${kirim_model_barang.namaPaket}",style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Jml yang di pesan : ${kirim_model_barang.jmlPaket} ${kirim_model_barang.tipePaket}, \nKode Paket : ${kirim_model_barang.kodePaket}"),
                          Text("Berat Paket/${kirim_model_barang.tipePaket} : ${kirim_model_barang.beratPaket} Kg"),
                          if(kirim_model_barang.statusPesanan == "diterima")
                          Text("Status Penerimaan : \n${kirim_model_barang.statusTerima} oleh ${kirim_model_barang.gudangTujuan}",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                          if(kirim_model_barang.statusPesanan == "proses")
                          Text("Status Penerimaan : \n${kirim_model_barang.statusTerima} oleh ${kirim_model_barang.gudangTujuan}",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                          if(kirim_model_barang.statusPesanan == "dikirim")
                          Text("Status Penerimaan : sedang ${kirim_model_barang.statusTerima}",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                          if(kirim_model_barang.statusPesanan == "ditolak")
                          Text("Status Penerimaan : ${kirim_model_barang.statusTerima}",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
                          if(kirim_model_barang.statusPesanan == "diterima")
                          Text("Status Pesanan : ${kirim_model_barang.statusPesanan}",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                          if(kirim_model_barang.statusPesanan == "proses")
                          Text("Status Pesanan : ${kirim_model_barang.statusPesanan}",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                          if(kirim_model_barang.statusPesanan == "dikirim")
                          Text("Status Pesanan : ${kirim_model_barang.statusPesanan}",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                          if(kirim_model_barang.statusPesanan == "ditolak")
                          Text("Status Pesanan : ${kirim_model_barang.statusPesanan}",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
                          Text("Gudang Asal : ${kirim_model_barang.gudangAsal}, \nGudang Tujuan : ${kirim_model_barang.gudangTujuan}"),
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
          if(g_status_proses == "proses")
          FloatingActionButton.extended(
            heroTag: "btn6",
            backgroundColor: Colors.blue,
            label: Text('Kirim Barang',
              textAlign: TextAlign.center,),
            onPressed: () {
              //what to do here
              setState(() {
                sending = true;
              });
              SendUpdatePesananDikirim();
            },
          ),
          SizedBox(height: 10),
          if(g_status_proses == "proses")
          FloatingActionButton.extended(
            heroTag: "btn7",
            backgroundColor: Colors.redAccent,
            label: Text('Tolak Permintaan',
              textAlign: TextAlign.center,),
            onPressed: () {
              //what to do here
              setState(() {
                sending = true;
              });
              SendTolakPesanan();
            },
          ),
        ],
      ),

    );
  }
}