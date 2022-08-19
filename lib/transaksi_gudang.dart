import 'package:flutter/material.dart';
import 'global_var.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'transaksi_gudang_keranjang.dart' as kode_transaksi_page;

class transaksi_gudang extends StatefulWidget {
  const transaksi_gudang({ Key? key }) : super(key: key);
  @override
  State<transaksi_gudang> createState() => _transaksi_gudangState();
}

class _transaksi_gudangState extends State<transaksi_gudang> {
  
  final _formKey = GlobalKey<FormState>();
  
  TextEditingController kode_transaksi = TextEditingController();
  //text controller for TextField

  late String pesan = "";
  late bool error, sending, success;
  late String msg;
  late List <String> isi_jml = [];

  
  @override
  void initState() {
      error = false;
      sending = false;
      success = false;
      msg = "";
      super.initState();

      getData_kode_gudang();
  }

  Future<void> getData_kode_gudang() async {
    String postsURL = 'https://kecapy.com/webservice.php';
    
    var res = await http.post(Uri.parse(postsURL), body: {
        "CMD":"get_kode_transaksigudang",
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var decoded_Json_data = json.decode(res.body); //decoding json to array

      if(decoded_Json_data["berhasil"]==true){
        String kode_transaksi_didapat = decoded_Json_data["message"];
        kode_transaksi.text = kode_transaksi_didapat;
        
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
        title: const Text('Transaksi Gudang'),
      ),
      body: SingleChildScrollView(
        child : Form(
        key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                child: TextFormField(
                  enabled: false,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    icon: Icon(Icons.bookmark_outlined),
                    labelText: 'Kode Transaksi',
                  ),
                  controller: kode_transaksi,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong isi Kode Transaksi';
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                child : ButtonTheme( //submit button
                  minWidth: double.infinity,
                  
                  child: MaterialButton(
                    color: Colors.blueAccent,     //  <-- dark color
                    textTheme: ButtonTextTheme.primary,
                    height: 50,
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        g_kode_transaksi_pesanan = kode_transaksi.text;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => kode_transaksi_page.transaksi_gudang_keranjang()),
                        );
                        print(g_id_gudang_lain_terpilih);
                        print(g_kode_transaksi_pesanan);
                      }
                    },
                    child: const Text('Selanjutnya',
                      style: TextStyle(
                        fontSize: 24.0,),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                child: Text(pesan,
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),

            ],
          ),
        )
      )
        
    );
  }
}