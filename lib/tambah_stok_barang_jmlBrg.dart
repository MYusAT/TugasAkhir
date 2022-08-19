import 'dart:async';

import 'package:coba2/global_var.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home.dart'as home;

class tambah_stok_jmlBrg extends StatefulWidget {
  const tambah_stok_jmlBrg({ Key? key }) : super(key: key);

  @override
  State<tambah_stok_jmlBrg> createState() => _tambah_stok_jmlBrgState();
}

class _tambah_stok_jmlBrgState extends State<tambah_stok_jmlBrg> {
  /*List<TextEditingController> jml_barang = [
    for (int i = 0; i < g_id_List_barang_terpilih.length; i++)
      TextEditingController()
  ];*/
  final List<GlobalKey> _formKey = List.generate(g_id_List_barang_terpilih.length, (i) => GlobalKey());
  List<TextEditingController> jml_barang = List.generate(g_id_List_barang_terpilih.length, (i) => TextEditingController());

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

  Future<void> sendData() async {
    String postsURL = 'https://kecapy.com/webservice.php';
    
    var res = await http.post(Uri.parse(postsURL), body: {
        "CMD":"tambah_do_dan_do_detail",
        "id_barang":g_id_List_barang_terpilih.toString(),
        "id_lokasi_gudang":g_id_lokasi_gudang,
        "jml_paket": isi_jml.toString(),
        "nomor_delivery": g_nomor_DO,
        "tgl_delivery": g_tgl_DO,
        "id_admin": g_id_admin
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var decoded_Json_data = json.decode(res.body); //decoding json to array

      if(decoded_Json_data["berhasil"]==true){
        pesan = decoded_Json_data["message"];

        for(int index = 0 ; index<g_id_List_barang_terpilih.length ; index++){
          jml_barang[index].text = "";
        }
        g_id_List_barang_terpilih = [];
        g_nama_List_barang_terpilih = [];

        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tambah Stok barang berhasil, Mohon Tunggu Sebentar')),
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
        pesan = decoded_Json_data["message"] ;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(pesan)),
        );
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
        title: Text("Tambah Stok Barang - Jumlah Barang"),
      ),
      body: ListView.builder(
        // the number of items in the list
        itemCount: g_id_List_barang_terpilih.length,

        // display each item of the product list
        itemBuilder: (context, int index) {
          return Card(
            // In many cases, the key isn't mandatory
            key: UniqueKey(),
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text(g_nama_List_barang_terpilih[index],
                      style: TextStyle(
                        fontSize: 20.0,),
                    ),
                    TextFormField(
                      key: _formKey[index],
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Jumlah barang masuk',
                      ),
                      controller: jml_barang[index],
                      /*onChanged: (value) {
                        final controller = jml_barang[index];
                        print('Current field index is $index and new value is $value');
                      },*/
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tolong isi Jumlah barang masuk';
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
          label: const Text('Selanjutnya'),
          onPressed: () {
            isi_jml.clear();
            List<String> izin_isi = [];
            for(int index = 0 ; index<g_id_List_barang_terpilih.length ; index++){
              isi_jml.add(jml_barang[index].text);
              if(int.parse(jml_barang[index].text.toString())<=0){
                izin_isi.add("Tidak");
              }else{
                izin_isi.add("Boleh");
              }

            }
            print(isi_jml);
            print(g_id_List_barang_terpilih);
            print(g_nama_List_barang_terpilih);

            if(!izin_isi.contains("Tidak")){
              setState(() {
                sending = true;
              });
              sendData();
            }else{
              String pesan = "Angka yang di input > 0";
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(pesan)),
              );
            }
            
          },
        ),
    );
  }
}