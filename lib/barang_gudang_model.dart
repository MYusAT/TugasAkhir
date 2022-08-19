import 'package:flutter/foundation.dart';

class barang_gudang_model {
  String? id;
  String? namaPaket;
  String? idLokasiGudang;
  String? stok;
  String? tipePaket;
  String? beratPaket;
  String? hargaPerPcs;
  String? isiPaketPerPcs;
  String? namaSupplier;

  barang_gudang_model(
      {this.id,
      this.namaPaket,
      this.idLokasiGudang,
      this.stok,
      this.tipePaket,
      this.beratPaket,
      this.hargaPerPcs,
      this.isiPaketPerPcs,
      this.namaSupplier});

  barang_gudang_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaPaket = json['nama_paket'];
    idLokasiGudang = json['id_lokasi_gudang'];
    stok = json['stok'];
    tipePaket = json['tipe_paket'];
    beratPaket = json['berat_paket'];
    hargaPerPcs = json['harga_per_pcs'];
    isiPaketPerPcs = json['isi_paket_per_pcs'];
    namaSupplier = json['nama_supplier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_paket'] = this.namaPaket;
    data['id_lokasi_gudang'] = this.idLokasiGudang;
    data['stok'] = this.stok;
    data['tipe_paket'] = this.tipePaket;
    data['berat_paket'] = this.beratPaket;
    data['harga_per_pcs'] = this.hargaPerPcs;
    data['isi_paket_per_pcs'] = this.isiPaketPerPcs;
    data['nama_supplier'] = this.namaSupplier;
    return data;
  }
}