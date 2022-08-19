class get_list_supplier_model {
  String? id;
  String? namaSupplier;

  get_list_supplier_model({this.id, this.namaSupplier});

  get_list_supplier_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaSupplier = json['nama_supplier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_supplier'] = this.namaSupplier;
    return data;
  }
}