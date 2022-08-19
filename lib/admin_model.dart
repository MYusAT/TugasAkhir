import 'package:flutter/foundation.dart';

class Admin_Model {
  String? id;
  String? kodePegawai;
  String? namaLengkap;
  String? email;
  String? nomorTelfon;
  String? idLokasiGudang;
  String? password;

  Admin_Model(
      {this.id,
      this.kodePegawai,
      this.namaLengkap,
      this.email,
      this.nomorTelfon,
      this.idLokasiGudang,
      this.password});
}