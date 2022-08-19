class kode_pengiriman_barang_model {
  String? id;
  String? nomorPesanan;
  String? tanggalWaktu;
  String? idLokasiGudangAsal;
  String? idLokasiGudangTujuan;
  String? statusTerima;
  String? statusPesanan;

  kode_pengiriman_barang_model(
      {this.id,
      this.nomorPesanan,
      this.tanggalWaktu,
      this.idLokasiGudangAsal,
      this.idLokasiGudangTujuan,
      this.statusTerima,
      this.statusPesanan});

  kode_pengiriman_barang_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nomorPesanan = json['nomor_pesanan'];
    tanggalWaktu = json['tanggal_waktu'];
    idLokasiGudangAsal = json['id_lokasi_gudang_asal'];
    idLokasiGudangTujuan = json['id_lokasi_gudang_tujuan'];
    statusTerima = json['status_terima'];
    statusPesanan = json['status_pesanan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nomor_pesanan'] = this.nomorPesanan;
    data['tanggal_waktu'] = this.tanggalWaktu;
    data['id_lokasi_gudang_asal'] = this.idLokasiGudangAsal;
    data['id_lokasi_gudang_tujuan'] = this.idLokasiGudangTujuan;
    data['status_terima'] = this.statusTerima;
    data['status_pesanan'] = this.statusPesanan;
    return data;
  }
}