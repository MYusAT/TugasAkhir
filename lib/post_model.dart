import 'package:flutter/foundation.dart';

//https://javiercbk.github.io/json_to_dart/

class Post {
  String? id;
  String? kodePaket;
  String? namaPaket;
  String? tipePaket;
  String? beratPaket;
  String? hargaPerPcs;
  String? idSupplier;

  Post(
      {this.id,
      this.kodePaket,
      this.namaPaket,
      this.tipePaket,
      this.beratPaket,
      this.hargaPerPcs,
      this.idSupplier});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kodePaket = json['kode_paket'];
    namaPaket = json['nama_paket'];
    tipePaket = json['tipe_paket'];
    beratPaket = json['berat_paket'];
    hargaPerPcs = json['harga_per_pcs'];
    idSupplier = json['id_supplier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kode_paket'] = this.kodePaket;
    data['nama_paket'] = this.namaPaket;
    data['tipe_paket'] = this.tipePaket;
    data['berat_paket'] = this.beratPaket;
    data['harga_per_pcs'] = this.hargaPerPcs;
    data['id_supplier'] = this.idSupplier;
    return data;
  }
}