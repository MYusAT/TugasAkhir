class list_barang_berdasarkan_supplier_model {
  String? namaPaket;
  String? kodePaket;

  list_barang_berdasarkan_supplier_model({this.namaPaket, this.kodePaket});

  list_barang_berdasarkan_supplier_model.fromJson(Map<String, dynamic> json) {
    namaPaket = json['nama_paket'];
    kodePaket = json['kode_paket'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama_paket'] = this.namaPaket;
    data['kode_paket'] = this.kodePaket;
    return data;
  }
}