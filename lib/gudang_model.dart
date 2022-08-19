import 'package:flutter/foundation.dart';

class Gudang_Model {
  String? id;
  String? alamatLengkap;
  String? namaGudang;

  Gudang_Model({this.id, this.alamatLengkap, this.namaGudang});

  Gudang_Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    alamatLengkap = json['alamat_lengkap'];
    namaGudang = json['nama_gudang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['alamat_lengkap'] = this.alamatLengkap;
    data['nama_gudang'] = this.namaGudang;
    return data;
  }
}