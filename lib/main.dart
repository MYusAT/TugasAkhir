import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'admin_model.dart';
import 'http_service.dart';
import 'home.dart' as home;
import 'home_super.dart' as home_super;
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'global_var.dart';
import 'supplier_model.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyLoginPage(),
    );
  }

  
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({ Key? key }) : super(key: key);
  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final _formKey = GlobalKey<FormState>();
  /*
  Dio dio = Dio();

  Future<List<Admin_Model>> apiLoadFunction() async {
    String postsURL2 = 'https://kecapy.com/webservice.php';
    FormData formData = FormData.fromMap({"CMD": "ListAdmin"});

    var response = await dio.post(postsURL2, data: formData);

    List<dynamic> map = json.decode(response.data);

    List<Admin_Model> listData = [];

    for (var item in map) {
      Admin_Model am = Admin_Model(
        kodePegawai: item["kode_pegawai"],
        password: item["password"],
      );

      listData.add(am);
    }

    return listData;
  }*/
  TextEditingController kodePegawai = TextEditingController();
  TextEditingController password = TextEditingController();

  late bool error, sending, success;
  late String msg;
  late List<dynamic> full_data_admin;
  late int can_access = 0;

  late String pesan = "";
  // do not use http://localhost/ for your local
  // machine, Android emulation do not recognize localhost
  // insted use your local ip address or your live URL
  // hit "ipconfig" on Windows or  "ip a" on Linux to get IP Address

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
        "CMD":"cari_admin2",
        "kode_pegawai": kodePegawai.text,
        "password": password.text,
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var decoded_Json_data = json.decode(res.body); //decoding json to array
      
      if(decoded_Json_data!=null){
        pesan = "Mohon Tunggu sebentar" ;

        List<dynamic> map_json_data = json.decode(res.body);

        String id_gudang = map_json_data[0]["id_lokasi_gudang"];
        String nama_lengkap = map_json_data[0]["nama_lengkap"];
        String id_admin = map_json_data[0]["id"];
        String role = map_json_data[0]["role"];
        String nama_gudang = map_json_data[0]["nama_gudang"];
        g_nama_lengkap_gudang = nama_gudang;
        g_role_admin = role;
        g_password_admin = map_json_data[0]["password"];
        g_id_lokasi_gudang = id_gudang;
        g_nomor_telepon_admin = map_json_data[0]["nomor_telfon"];
        g_email_admin = map_json_data[0]["email"];
        g_nama_admin = nama_lengkap;
        g_kode_pegawai_admin = map_json_data[0]["kode_pegawai"];
        g_id_admin = id_admin;
        

        print("id gudang : " + id_gudang);

        kodePegawai.text = "";
        password.text = "";

        if(g_role_admin == "user"){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(pesan)),
          );

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => home.myhome()),
          );
        }else if (g_role_admin == "administrasi"){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(pesan)),
          );

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => home_super.home_super()),
          );
        }
        

        setState(() {
            sending = false;
            success = true; //mark success and refresh UI with setState
        });
      }else if (decoded_Json_data==[""] || decoded_Json_data==null ){
        print("Username / password tidak ada");
        pesan = "Username / password tidak ada";
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(pesan)),
        );

      }else if(decoded_Json_data["error"]){
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
        can_access = 0;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Inventory System'),
        
      ),
      body: Form(
      key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Masukkan Nomor Admin',
                ),
                controller: kodePegawai,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tolong Masukkan Nomor Admin';
                  }
                  return null;
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              child: TextFormField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
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

            Padding(padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
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
                      // call a server or save the information in a database.
                      
                      setState(() {
                          sending = true;
                      });
                      sendData();
                      
                      
                      /*
                      apiLoadFunction().then((value) {
                        for (int i = 0; i < value.length; i++) {
                          if (value[i].kodePegawai != kodePegawai.text &&
                              value[i].password != password.text) {
                            print(value[i]);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Username atau Password Salah')),
                            );

                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => home.myhome()),
                            );
                            break;
                          }
                        }
                      });
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Input Username atau Password')),
                      );*/
                    }
                  },
                  child: const Text('Login',
                    style: TextStyle(
                      fontSize: 24.0,),
                  ),
                ),
              ),
            ),
          ],
        ),
      )  
    );
  }
}

