class kartu_stok_model {
  String? noTransaksi;
  String? tglTransaksi;
  String? keterangan;
  String? id;
  String? namaPaket;
  String? jmlPaket;
  String? idLokasiGudang;
  String? tipePaket;

  kartu_stok_model(
      {this.noTransaksi,
      this.tglTransaksi,
      this.keterangan,
      this.id,
      this.namaPaket,
      this.jmlPaket,
      this.idLokasiGudang,
      this.tipePaket});

  kartu_stok_model.fromJson(Map<String, dynamic> json) {
    noTransaksi = json['no_transaksi'];
    tglTransaksi = json['tgl_transaksi'];
    keterangan = json['keterangan'];
    id = json['id'];
    namaPaket = json['nama_paket'];
    jmlPaket = json['jml_paket'];
    idLokasiGudang = json['id_lokasi_gudang'];
    tipePaket = json['tipe_paket'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no_transaksi'] = this.noTransaksi;
    data['tgl_transaksi'] = this.tglTransaksi;
    data['keterangan'] = this.keterangan;
    data['id'] = this.id;
    data['nama_paket'] = this.namaPaket;
    data['jml_paket'] = this.jmlPaket;
    data['id_lokasi_gudang'] = this.idLokasiGudang;
    data['tipe_paket'] = this.tipePaket;
    return data;
  }
}