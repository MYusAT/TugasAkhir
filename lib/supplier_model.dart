class Supplier_Model {
  String? id;
  String? namaSupplier;

  Supplier_Model({this.id, this.namaSupplier});
  /*
  Supplier_Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaSupplier = json['nama_supplier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_supplier'] = this.namaSupplier;
    return data;
  }*/
}