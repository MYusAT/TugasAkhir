class barang_model {
  String? id;
  String? kodePaket;
  String? namaPaket;
  String? tipePaket;
  String? beratPaket;
  String? hargaPerPcs;
  String? isiPaketPerPcs;
  String? idSupplier;

  barang_model(
      {this.id,
      this.kodePaket,
      this.namaPaket,
      this.tipePaket,
      this.beratPaket,
      this.hargaPerPcs,
      this.isiPaketPerPcs,
      this.idSupplier});

  barang_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kodePaket = json['kode_paket'];
    namaPaket = json['nama_paket'];
    tipePaket = json['tipe_paket'];
    beratPaket = json['berat_paket'];
    hargaPerPcs = json['harga_per_pcs'];
    isiPaketPerPcs = json['isi_paket_per_pcs'];
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
    data['isi_paket_per_pcs'] = this.isiPaketPerPcs;
    data['id_supplier'] = this.idSupplier;
    return data;
  }
}