import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'global_var.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home_super.dart'as home;

class update_user extends StatefulWidget {
  const update_user({ Key? key }) : super(key: key);
  @override
  State<update_user> createState() => _update_userState();
}

class _update_userState extends State<update_user> {
  
  final _formKey = GlobalKey<FormState>();
  String? id_gudang = g_id_lokasi_gudang;
  
  TextEditingController kode_pegawai = TextEditingController()..text = g_kode_pegawai_admin;
  TextEditingController nama_lengkap = TextEditingController()..text = g_nama_admin;
  TextEditingController email = TextEditingController()..text = g_email_admin;
  TextEditingController nomor_telfon = TextEditingController()..text = g_nomor_telepon_admin;
  TextEditingController password = TextEditingController()..text = g_password_admin;
  
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

  Future<void> sendData() async {
    String postsURL = 'https://kecapy.com/webservice.php';
    var res = await http.post(Uri.parse(postsURL), body: {
        "CMD":"update_user",
        "id_admin" : g_id_admin,
        "nama_lengkap": nama_lengkap.text,
        "email": email.text,
        "nomor_telfon": nomor_telfon.text,
        "password":password.text,
        
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var decoded_Json_data = json.decode(res.body); //decoding json to array

      if(decoded_Json_data["berhasil"]==true){
        pesan = decoded_Json_data["message"];
        g_nama_admin = nama_lengkap.text;
        g_email_admin = email.text;
        g_nomor_telepon_admin = nomor_telfon.text;
        g_password_admin = password.text;
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Update user berhasil, mohon tunggu sebentar')),
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
        title: const Text('Update Akun Saya'),
      ),
      body: SingleChildScrollView(
        child : Form(
        key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                child: Text("Kode Pegawai : ${g_kode_pegawai_admin}",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Masukkan nama lengkap',
                  ),
                  controller: nama_lengkap,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong Masukkan nama lengkap';
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
                    labelText: 'Masukkan email',
                  ),
                  controller: email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong Masukkan email';
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Masukkan nomor telefon',
                  ),
                  controller: nomor_telfon,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong Masukkan nomor telefon';
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                child: Text("Bekerja di ${g_nama_lengkap_gudang}",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Masukkan Password',
                  ),
                  controller: password,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong Masukkan Password';
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                child: Text("Role : ${g_role_admin}",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
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
                    child: const Text('Update Akun Saya',
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