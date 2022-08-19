class detail_kirim_barang_model {
  String? jmlPaket;
  String? statusTerima;
  String? gudangTujuan;
  String? gudangAsal;
  String? kodePaket;
  String? namaPaket;
  String? beratPaket;
  String? statusPesanan;
  String? tipePaket;

  detail_kirim_barang_model(
      {this.jmlPaket,
      this.statusTerima,
      this.gudangTujuan,
      this.gudangAsal,
      this.kodePaket,
      this.namaPaket,
      this.beratPaket,
      this.statusPesanan,
      this.tipePaket});

  detail_kirim_barang_model.fromJson(Map<String, dynamic> json) {
    jmlPaket = json['jml_paket'];
    statusTerima = json['status_terima'];
    gudangTujuan = json['gudang_tujuan'];
    gudangAsal = json['gudang_asal'];
    kodePaket = json['kode_paket'];
    namaPaket = json['nama_paket'];
    beratPaket = json['berat_paket'];
    statusPesanan = json['status_pesanan'];
    tipePaket = json['tipe_paket'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jml_paket'] = this.jmlPaket;
    data['status_terima'] = this.statusTerima;
    data['gudang_tujuan'] = this.gudangTujuan;
    data['gudang_asal'] = this.gudangAsal;
    data['kode_paket'] = this.kodePaket;
    data['nama_paket'] = this.namaPaket;
    data['berat_paket'] = this.beratPaket;
    data['status_pesanan'] = this.statusPesanan;
    data['tipe_paket'] = this.tipePaket;
    return data;
  }
}