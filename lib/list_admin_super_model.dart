class list_admin_super_model {
  String? id;
  String? kodePegawai;
  String? namaLengkap;
  String? email;
  String? nomorTelfon;
  String? idLokasiGudang;
  String? password;
  String? role;
  String? namaGudang;

  list_admin_super_model(
      {this.id,
      this.kodePegawai,
      this.namaLengkap,
      this.email,
      this.nomorTelfon,
      this.idLokasiGudang,
      this.password,
      this.role,
      this.namaGudang});

  list_admin_super_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kodePegawai = json['kode_pegawai'];
    namaLengkap = json['nama_lengkap'];
    email = json['email'];
    nomorTelfon = json['nomor_telfon'];
    idLokasiGudang = json['id_lokasi_gudang'];
    password = json['password'];
    role = json['role'];
    namaGudang = json['nama_gudang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kode_pegawai'] = this.kodePegawai;
    data['nama_lengkap'] = this.namaLengkap;
    data['email'] = this.email;
    data['nomor_telfon'] = this.nomorTelfon;
    data['id_lokasi_gudang'] = this.idLokasiGudang;
    data['password'] = this.password;
    data['role'] = this.role;
    data['nama_gudang'] = this.role;
    return data;
  }
}