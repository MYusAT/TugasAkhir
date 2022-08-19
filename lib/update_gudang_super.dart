import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'global_var.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home_super.dart'as home;
import 'barang_gudang_model.dart';

class update_gudang extends StatefulWidget {
  const update_gudang({ Key? key }) : super(key: key);
  @override
  State<update_gudang> createState() => _update_gudangState();
}

class _update_gudangState extends State<update_gudang> {

  final _formKey = GlobalKey<FormState>();
  
  TextEditingController nama_gudang = TextEditingController()..text = g_nama_gudang_terpilih_super;
  TextEditingController alamat_lengkap = TextEditingController()..text = g_alamat_gudang_terpilih_super;
  
  //text controller for TextField

  late bool error, sending, success;
  late String msg;
  late String pesan = "";

  @override
  void initState() {
      error = false;
      sending = false;
      success = false;
      msg = "";
      super.initState();

      sending = true;
  }

  Future<void> UpdateData() async {
    String postsURL = 'https://kecapy.com/webservice.php';
    var res = await http.post(Uri.parse(postsURL), body: {
        "CMD":"update_gudang",
        "id_gudang" : g_id_gudang_terpilih_super,
        "nama_gudang" : nama_gudang.text,
        "alamat_lengkap": alamat_lengkap.text,
        
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var decoded_Json_data = json.decode(res.body); //decoding json to array

      if(decoded_Json_data["berhasil"]==true){
        pesan = decoded_Json_data["message"];
        
        g_nama_gudang_terpilih_super = nama_gudang.text;
        g_alamat_gudang_terpilih_super = alamat_lengkap.text;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Update gudang berhasil, mohon tunggu sebentar')),
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => home.home_super()),
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
        pesan = decoded_Json_data["message"];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(pesan)),
        );
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
        title: const Text('Update Gudang'),
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
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Masukkan nama gudang',
                  ),
                  controller: nama_gudang,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong Masukkan nama gudang';
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Masukkan alamat lengkap',
                  ),
                  controller: alamat_lengkap,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong Masukkan alamat lengkap';
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
                        
                        setState(() {
                          sending = true;
                        });
                        UpdateData();

                      }
                    },
                    child: const Text('Update Gudang',
                      style: TextStyle(
                        fontSize: 24.0,),
                    ),
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