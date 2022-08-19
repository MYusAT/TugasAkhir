import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'global_var.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home.dart'as home;

class add_new_package extends StatefulWidget {
  const add_new_package({ Key? key }) : super(key: key);
  @override
  State<add_new_package> createState() => _add_new_packageState();
}

class _add_new_packageState extends State<add_new_package> {
  
  final _formKey = GlobalKey<FormState>();
  String? dropdownValue;
  String? dropdownValue2;
  
  TextEditingController nama_paket = TextEditingController();
  TextEditingController kode_paket = TextEditingController();
  TextEditingController berat_paket = TextEditingController();
  TextEditingController harga_per_pcs = TextEditingController();
  TextEditingController isi_paket_per_pcs = TextEditingController();
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
      requestData_supplier();
      get_kode_brg();
  }

  Future<void> sendData() async {
    String postsURL = 'https://kecapy.com/webservice.php';
    var res = await http.post(Uri.parse(postsURL), body: {
        "CMD":"tambah_paket",
        "nama_paket": nama_paket.text,
        "kode_paket": kode_paket.text,
        "berat_paket": berat_paket.text,
        "harga_per_pcs": harga_per_pcs.text,
        "isi_paket_per_pcs":isi_paket_per_pcs.text,
        "nama_supplier": dropdownValue2,
        "tipe_paket": dropdownValue
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var decoded_Json_data = json.decode(res.body); //decoding json to array

      if(decoded_Json_data["berhasil"]==true){
        pesan = decoded_Json_data["message"];
        nama_paket.text = "";
        kode_paket.text = "";
        berat_paket.text = "";
        harga_per_pcs.text = "";
        isi_paket_per_pcs.text = "";
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tambah barang berhasil, Mohon Tunggu Sebentar')),
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

  Future<void> requestData_supplier() async {
    String URL = 'https://kecapy.com/webservice.php';
    var res2 = await http.post(Uri.parse(URL), body: {
        "CMD":"list_supplier"
    }); //sending post request with header data

    if (res2.statusCode == 200) {
      print(res2.body); //print raw response on console
      var decoded_Json_data = json.decode(res2.body); //decoding json to array
      
      if(decoded_Json_data!=null){

        List<dynamic> map_json_data = json.decode(res2.body);

        g_supplier.clear();
        for (var item in map_json_data) {
          g_supplier.add(item["nama_supplier"]!);
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

  Future<void> get_kode_brg() async {
    String postsURL = 'https://kecapy.com/webservice.php';
    var res = await http.post(Uri.parse(postsURL), body: {
        "CMD":"get_kode_barang",
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var decoded_Json_data = json.decode(res.body); //decoding json to array

      if(decoded_Json_data["berhasil"]==true){
        kode_paket.text = decoded_Json_data["kode_barang"];

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
        title: const Text('Tambah Barang Baru'),
      ),
      body: SingleChildScrollView(
        child : Form(
        key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                child: Text("Note : Pastikan Barang yang akan di tambah benar - benar baru dan tidak ada di list",
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
                    labelText: 'Masukkan Nama Barang',
                  ),
                  controller: nama_paket,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong Masukkan Nama Barang';
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                child: TextFormField(
                  enabled: false,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Masukkan Kode Barang',
                  ),
                  controller: kode_paket,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong Masukkan Kode Barang';
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
                    labelText: 'Masukkan Berat Barang dalam (kg)',
                  ),
                  controller: berat_paket,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong Masukkan Berat Barang';
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
                    labelText: 'Masukkan Harga Per Pcs',
                  ),
                  controller: harga_per_pcs,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong Masukkan Harga Per Pcs';
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
                    "Pilih Tipe Barang",
                  ),
                  items: <String>['karton', 'karung']
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
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Masukkan Banyak item (pcs)',
                  ),
                  controller: isi_paket_per_pcs,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong Masukkan Banyak item (pcs)';
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                child: DropdownButton<String>(
                  isExpanded:true,
                  value: dropdownValue2,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  underline: Container(
                    height: 2,
                    color: Colors.black26,
                  ),
                  onChanged: (String? newValue2) {
                    setState(() {
                      dropdownValue2 = newValue2;
                    });
                  },
                  hint: const Text(
                    "Pilih Supplier",
                  ),
                  items: g_supplier
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
                    child: const Text('Tambah Barang',
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