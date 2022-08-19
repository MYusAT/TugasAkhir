import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'global_var.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home_super.dart'as home;

class tambah_user_super extends StatefulWidget {
  const tambah_user_super({ Key? key }) : super(key: key);
  @override
  State<tambah_user_super> createState() => _tambah_user_superState();
}

class _tambah_user_superState extends State<tambah_user_super> {
  
  final _formKey = GlobalKey<FormState>();
  String? dropdownValue;
  
  TextEditingController kode_pegawai = TextEditingController();
  TextEditingController nama_lengkap = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController nomor_telfon = TextEditingController();
  TextEditingController password = TextEditingController();
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
      requestData_list_id_lokasi_gudang();
      get_kode_pegawai();
  }

  Future<void> sendData() async {
    String postsURL = 'https://kecapy.com/webservice.php';
    var res = await http.post(Uri.parse(postsURL), body: {
        "CMD":"tambah_admin_baru",
        "kode_pegawai": kode_pegawai.text,
        "nama_lengkap": nama_lengkap.text,
        "email": email.text,
        "nomor_telfon": nomor_telfon.text,
        "password":password.text,
        "nama_gudang": dropdownValue
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var decoded_Json_data = json.decode(res.body); //decoding json to array

      if(decoded_Json_data["berhasil"]==true){
        pesan = decoded_Json_data["message"];
        kode_pegawai.text = "";
        nama_lengkap.text = "";
        email.text = "";
        nomor_telfon.text = "";
        password.text = "";
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tambah Admin berhasil, Mohon Tunggu Sebentar')),
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

  Future<void> requestData_list_id_lokasi_gudang() async {
    String URL = 'https://kecapy.com/webservice.php';
    var res2 = await http.post(Uri.parse(URL), body: {
        "CMD":"list_id_lokasi_gudang"
    }); //sending post request with header data

    if (res2.statusCode == 200) {
      print(res2.body); //print raw response on console
      var decoded_Json_data = json.decode(res2.body); //decoding json to array
      
      if(decoded_Json_data!=null){

        List<dynamic> map_json_data = json.decode(res2.body);

        g_list_id_lokasi_gudang.clear();
        for (var item in map_json_data) {
          g_list_id_lokasi_gudang.add(item["nama_gudang"]!);
        }
        
        setState(() {
            sending = false;
            success = true; //mark success and refresh UI with setState
        });
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
    }
  }

  Future<void> get_kode_pegawai() async {
    String postsURL = 'https://kecapy.com/webservice.php';
    var res = await http.post(Uri.parse(postsURL), body: {
        "CMD":"get_kode_pegawai",
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var decoded_Json_data = json.decode(res.body); //decoding json to array

      if(decoded_Json_data["berhasil"]==true){
        kode_pegawai.text = decoded_Json_data["kode_pegawai"];

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
        title: const Text('Tambah User Admin Baru'),
      ),
      body: SingleChildScrollView(
        child : Form(
        key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                child: Text("Note : Pastikan User Admin yang akan di tambah benar - benar baru dan tidak ada di list",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                child: TextFormField(
                  enabled: false,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Masukkan kode pegawai',
                  ),
                  controller: kode_pegawai,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong Masukkan kode pegawai';
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
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                child: DropdownButton<String>(
                  isExpanded:true,
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  underline: Container(
                    height: 2,
                    color: Colors.black26,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  hint: const Text(
                    "Pilih id lokasi gudang",
                  ),
                  items: g_list_id_lokasi_gudang
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
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
                    child: const Text('Tambah User Admin',
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