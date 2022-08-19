class status_pesanan_model {
  String? nomorPesanan;
  String? tanggalWaktu;
  String? idLokasiGudangAsal;
  String? idLokasiGudangTujuan;
  String? statusTerima;
  String? id;
  String? statusPesanan;

  status_pesanan_model(
      {this.nomorPesanan,
      this.tanggalWaktu,
      this.idLokasiGudangAsal,
      this.idLokasiGudangTujuan,
      this.statusTerima,
      this.id,
      this.statusPesanan});

  status_pesanan_model.fromJson(Map<String, dynamic> json) {
    nomorPesanan = json['nomor_pesanan'];
    tanggalWaktu = json['tanggal_waktu'];
    idLokasiGudangAsal = json['id_lokasi_gudang_asal'];
    idLokasiGudangTujuan = json['id_lokasi_gudang_tujuan'];
    statusTerima = json['status_terima'];
    id = json['id'];
    statusPesanan = json['status_pesanan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nomor_pesanan'] = this.nomorPesanan;
    data['tanggal_waktu'] = this.tanggalWaktu;
    data['id_lokasi_gudang_asal'] = this.idLokasiGudangAsal;
    data['id_lokasi_gudang_tujuan'] = this.idLokasiGudangTujuan;
    data['status_terima'] = this.statusTerima;
    data['id']=this.id;
    data['status_pesanan']=this.statusPesanan;
    return data;
  }
}