import 'package:flutter/material.dart';
import 'global_var.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'tambah_stok_barang_pilihbarang.dart' as pilih_barang;

class tambah_stok_barang extends StatefulWidget {
  const tambah_stok_barang({ Key? key }) : super(key: key);
  @override
  State<tambah_stok_barang> createState() => _tambah_stok_barangState();
}

class _tambah_stok_barangState extends State<tambah_stok_barang> {
  
  final _formKey = GlobalKey<FormState>();
  
  TextEditingController nomor_delivery = TextEditingController();
  TextEditingController tgl_delivery = TextEditingController();
  //text controller for TextField
  late String pesan = "";

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Stok Barang'),
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
                    icon: Icon(Icons.bookmark_outlined),
                    labelText: 'Nomor Delivery Order',
                  ),
                  controller: nomor_delivery,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong isi Nomor Delivery Order';
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                
                child: Center( 
                  child:TextFormField(
                      controller: tgl_delivery, //isi di controller ke dalam TextField
                       validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tolong isi Tanggal Delivery Order';
                        }
                        return null;
                      },
                      decoration: InputDecoration( 
                        icon: Icon(Icons.calendar_today), //icon dari text field
                        labelText: "Masukkan tanggal Delivery Order" //label text dari field
                      ),
                      readOnly: true,  //isi readonly true, sehingga user tidak bisa mengisi edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context, initialDate: DateTime.now(),
                            firstDate: DateTime(2000), //DateTime.now() - tidak bisa memilih selain hari ini.
                            lastDate: DateTime(2101)
                        );
                        
                        if(pickedDate != null ){
                            print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                            print(formattedDate); //formatted date output menggunakan intl package =>  2021-03-16
                              //bisa di implementasi bentuk date format yang diinginkan

                            setState(() {
                              tgl_delivery.text = formattedDate; //mengisi value output date ke value TextField. 
                            });
                        }else{
                            print("Date is not selected");
                        }
                      },
                    )
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
                        
                        g_nomor_DO = nomor_delivery.text;
                        g_tgl_DO = tgl_delivery.text;
                        
                        print(g_nomor_DO);
                        print(g_tgl_DO);

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => pilih_barang.tambah_stok_pilih_barang()),
                        );

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