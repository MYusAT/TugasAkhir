import 'dart:async';

import 'package:flutter/material.dart';
import 'global_var.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home_super.dart'as home;

class tambah_gudang extends StatefulWidget {
  const tambah_gudang({ Key? key }) : super(key: key);
  @override
  State<tambah_gudang> createState() => _tambah_gudangState();
}

class _tambah_gudangState extends State<tambah_gudang> {
  
  final _formKey = GlobalKey<FormState>();
  
  TextEditingController nama_gudang = TextEditingController();
  TextEditingController alamat_gudang = TextEditingController();
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
  }

  Future<void> sendData() async {
    String postsURL = 'https://kecapy.com/webservice.php';
    var res = await http.post(Uri.parse(postsURL), body: {
        "CMD":"tambah_gudang",
        "nama_gudang": nama_gudang.text,
        "alamat_lengkap":alamat_gudang.text,
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var decoded_Json_data = json.decode(res.body); //decoding json to array

      if(decoded_Json_data["berhasil"]==true){
        pesan = decoded_Json_data["message"];
        nama_gudang.text = "";
        alamat_gudang.text = "";
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tambah Gudang berhasil, Mohon Tunggu Sebentar')),
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => home.home_super()),
        );

        setState(() {
            sending = false;
            success = true; //mark success and refresh UI with setState
        });
      }else if(decoded_Json_data["error"]=true){
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
        title: const Text('Tambah Gudang Baru'),
      ),
      body: SingleChildScrollView(
        child : Form(
        key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                child: Text("Note : Pastikan Nama dan alamat gudang yang akan di tambah benar - benar baru dan tidak ada di list",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Masukkan Nama gudang',
                  ),
                  controller: nama_gudang,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong Masukkan Nama gudang';
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
                    labelText: 'Masukkan Alamat gudang',
                  ),
                  controller: alamat_gudang,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong Masukkan Alamat gudang';
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
                        sendData();

                      }
                    },
                    child: const Text('Tambah gudang',
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