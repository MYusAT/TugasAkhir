import 'dart:async';

import 'package:coba2/global_var.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'home.dart'as home;

class transaksi_gudang_keranjang extends StatefulWidget {
  const transaksi_gudang_keranjang({ Key? key }) : super(key: key);

  @override
  State<transaksi_gudang_keranjang> createState() => _transaksi_gudang_keranjangState();
}

class _transaksi_gudang_keranjangState extends State<transaksi_gudang_keranjang> {
  final List<GlobalKey> _formKey = List.generate(g_list_id_barang_keranjang_gudang.length, (i) => GlobalKey());
  List<TextEditingController> jml_barang = List.generate(g_list_id_barang_keranjang_gudang.length, (i) => TextEditingController());

  late bool error, sending, success;
  late String msg;
  late String pesan = "";
  late List <String> isi_jml = [];

  @override
  void initState() {
      error = false;
      sending = false;
      success = false;
      msg = "";
      super.initState();
  }

  Future<void> sendData_gudang() async {
    String postsURL = 'https://kecapy.com/webservice.php';
    
    var res = await http.post(Uri.parse(postsURL), body: {
        "CMD":"transaksi_antar_gudang",
        "id_admin":g_id_admin,
        "id_barang":g_list_id_barang_keranjang_gudang.toString(),
        "id_lokasi_gudang_asal":g_id_gudang_lain_terpilih,
        "id_lokasi_gudang_tujuan":g_id_lokasi_gudang,
        "jml_paket": isi_jml.toString(),
        "kode_transaksi":g_kode_transaksi_pesanan,
        "status_terima":"belum_diterima"
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var decoded_Json_data = json.decode(res.body); //decoding json to array

      if(decoded_Json_data["berhasil"]==true){
        pesan = decoded_Json_data["message"];

        for(int index = 0 ; index<g_list_id_barang_keranjang_gudang.length ; index++){
          jml_barang[index].text = "";
        }
        g_list_id_barang_keranjang_gudang = [];
        g_list_nama_barang_keranjang_gudang = [];
        isi_jml = [];
        g_list_stok_barang_gudang_lain = [];

        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tambah Pesanan ke gudang pusat ${g_id_gudang_lain_terpilih} berhasil, Mohon Tunggu Sebentar')),
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => home.myhome()),
        );
        
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
            msg = "Error during sending data.";
            sending = false;
            //mark error and refresh UI with setState
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaksi Gudang - Keranjang"),
      ),
      body: ListView.builder(
        // the number of items in the list
        itemCount: g_list_id_barang_keranjang_gudang.length,

        // display each item of the product list
        itemBuilder: (context, int index) {
          return Card(
            // In many cases, the key isn't mandatory
            key: UniqueKey(),
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text("${g_list_nama_barang_keranjang_gudang[index]} Stok : ${g_list_stok_barang_gudang_lain[index]}",
                      style: TextStyle(
                        fontSize: 20.0,),
                    ),
                    TextFormField(
                      key: _formKey[index],
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Jumlah barang request',
                      ),
                      controller: jml_barang[index],
                      /*onChanged: (value) {
                        final controller = jml_barang[index];
                        print('Current field index is $index and new value is $value');
                      },*/
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tolong isi Jumlah barang request';
                        }
                        return null;
                      },
                    ),
                  ],
                )
            ),
          );
        }),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.blue,
          icon: Icon(Icons.arrow_forward ),
          label: const Text('Pesan'),
          onPressed: () {
            isi_jml.clear();
            List<String> izin_isi = [];
            for(int index = 0 ; index<g_list_id_barang_keranjang_gudang.length ; index++){
              isi_jml.add(jml_barang[index].text);
              if(int.parse(jml_barang[index].text.toString())<=0){
                izin_isi.add("Tidak");
              }else {
                if(int.parse(jml_barang[index].text.toString()) <= int.parse(g_list_stok_barang_gudang_lain[index])){
                  izin_isi.add("Boleh");
                }else{
                  izin_isi.add("Tidak");
                }
              }
            }
            print(isi_jml);
            print(g_list_id_barang_keranjang_gudang);
            print(g_list_nama_barang_keranjang_gudang);
            print(g_list_stok_barang_gudang_lain);
            print(izin_isi);
            
            if(!izin_isi.contains("Tidak")){
              
              setState(() {
                sending = true;
              });
              sendData_gudang();
              print("test");
            }else{
              String pesan = "Angka yang di input > 0 dan tidak melebihi stok yang ada";
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(pesan)),
              );
            }
            
          },
        ),
    );
  }
}