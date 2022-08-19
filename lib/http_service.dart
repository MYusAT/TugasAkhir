import 'dart:convert';
import 'package:coba2/admin_model.dart';
import 'package:coba2/get_list_supplier_model.dart';
import 'package:coba2/list_admin_super_model.dart';
import 'package:coba2/status_pesanan_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'post_model.dart';
import 'gudang_model.dart';
import 'admin_model.dart';
import 'barang_model.dart';
import 'barang_gudang_model.dart';
import 'global_var.dart';
import 'kode_pengiriman_barang_model.dart';
import 'detail_status_pesanan_model.dart';
import 'detail_kirim_barang_model.dart';
import 'kartu_stok_model.dart';
import 'get_list_supplier_model.dart';
import 'list_barang_berdasarkan_supplier_model.dart';
import 'list_admin_super_model.dart';



class HttpService {
  String postsURL2 = 'https://kecapy.com/webservice.php';

  Future<List<barang_model>> getBarang() async {
      var requestBody = {
        'CMD':'ListProduct'
      };

      http.Response res = await http.post(
          Uri.parse(postsURL2),
          body: requestBody,
      );

      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);
        List<barang_model> barang_models = body
        .map(
          (dynamic item) => barang_model.fromJson(item),
        )
        .toList();
        return barang_models;
      } else {
        throw "Unable to retrieve barang_models.";
      }
  }
}

class HttpService_gudang {
  String postsURL2 = 'https://kecapy.com/webservice.php';

  Future<List<Gudang_Model>> getGudang() async {
      var requestBody = {
        'CMD':'ListGudang',
        'id_lokasi_gudang':g_id_lokasi_gudang
      };

      http.Response res = await http.post(
          Uri.parse(postsURL2),
          body: requestBody,
      );

      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);
        List<Gudang_Model> Gudang_Models = body
        .map(
          (dynamic item) => Gudang_Model.fromJson(item),
        )
        .toList();
        return Gudang_Models;
      } else {
        throw "Unable to retrieve Gudang_Models.";
      }
  }
}

class HttpService_barang_di_gudang {
  String postsURL2 = 'https://kecapy.com/webservice.php';

  Future<List<barang_gudang_model>> getBarangGudang() async {
      var requestBody = {
        'CMD':'List_barang_berdasarkan_gudang',
        'id_lokasi_gudang':g_id_lokasi_gudang
      };

      http.Response res = await http.post(
          Uri.parse(postsURL2),
          body: requestBody,
      );

      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);
        List<barang_gudang_model> barang_gudang_models = body
        .map(
          (dynamic item) => barang_gudang_model.fromJson(item),
        )
        .toList();
        return barang_gudang_models;
      } else {
        throw "Unable to retrieve barang_gudang_models.";
      }
  }
}

class HttpService_barang_di_gudang_lain {
  String postsURL2 = 'https://kecapy.com/webservice.php';

  Future<List<barang_gudang_model>> getBarangGudang(String id_gudang) async {
      var requestBody = {
        'CMD':'List_barang_berdasarkan_gudang',
        'id_lokasi_gudang':id_gudang
      };

      http.Response res = await http.post(
          Uri.parse(postsURL2),
          body: requestBody,
      );

      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);
        List<barang_gudang_model> barang_gudang_models = body
        .map(
          (dynamic item) => barang_gudang_model.fromJson(item),
        )
        .toList();
        return barang_gudang_models;
      } else {
        throw "Unable to retrieve barang_gudang_models.";
      }
  }
}

class HttpService_status_pemesanan {
  String postsURL2 = 'https://kecapy.com/webservice.php';

  Future<List<status_pesanan_model>> getStatusPemesanan() async {
      var requestBody = {
        'CMD':'list_status_pemesanan',
        'id_gudang_asal':g_id_gudang_lain_terpilih,
        'id_gudang_tujuan':g_id_lokasi_gudang
      };

      http.Response res = await http.post(
          Uri.parse(postsURL2),
          body: requestBody,
      );

      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);
        List<status_pesanan_model> status_pesanan_models = body
        .map(
          (dynamic item) => status_pesanan_model.fromJson(item),
        )
        .toList();
        return status_pesanan_models;
      } else {
        throw "Unable to retrieve status_pesanan_models.";
      }
  }
}

class HttpService_request_barang_berdasar_gudang {
  String postsURL2 = 'https://kecapy.com/webservice.php';

  Future<List<kode_pengiriman_barang_model>> getKodePesanan() async {
      var requestBody = {
        'CMD':'list_nomor_pesanan',
        'id_gudang_asal':g_id_lokasi_gudang,
        'id_gudang_tujuan': g_id_gudang_lain_terpilih
      };

      http.Response res = await http.post(
          Uri.parse(postsURL2),
          body: requestBody,
      );

      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);
        List<kode_pengiriman_barang_model> kode_pengiriman_barang_models = body
        .map(
          (dynamic item) => kode_pengiriman_barang_model.fromJson(item),
        )
        .toList();
        return kode_pengiriman_barang_models;
      } else {
        throw "Unable to retrieve kode_pengiriman_barang_models.";
      }
  }
}

class HttpService_detail_status_pemesanan {
  String postsURL2 = 'https://kecapy.com/webservice.php';

  Future<List<detail_status_pesanan_barang_model>> getDetailStatusPemesanan() async {
      var requestBody = {
        'CMD':'detail_pemesanan',
        'id_status_pesanan_brg':g_id_status_pesanan_brg
      };

      http.Response res = await http.post(
          Uri.parse(postsURL2),
          body: requestBody,
      );

      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);
        List<detail_status_pesanan_barang_model> detail_status_pesanan_barang_models = body
        .map(
          (dynamic item) => detail_status_pesanan_barang_model.fromJson(item),
        )
        .toList();
        return detail_status_pesanan_barang_models;
      } else {
        throw "Unable to retrieve detail_status_pesanan_barang_models.";
      }
  }
}

class HttpService_kirim_barang {
  String postsURL2 = 'https://kecapy.com/webservice.php';

  Future<List<detail_kirim_barang_model>> getKirimBarang() async {
      var requestBody = {
        'CMD':'detail_pemesanan',
        'id_status_pesanan_brg':g_id_kirim_brg
      };

      http.Response res = await http.post(
          Uri.parse(postsURL2),
          body: requestBody,
      );

      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);
        List<detail_kirim_barang_model> detail_kirim_barang_models = body
        .map(
          (dynamic item) => detail_kirim_barang_model.fromJson(item),
        )
        .toList();
        return detail_kirim_barang_models;
      } else {
        throw "Unable to retrieve detail_kirim_barang_models.";
      }
  }
}

class HttpService_kartu_stok {
  String postsURL2 = 'https://kecapy.com/webservice.php';

  Future<List<kartu_stok_model>> getKartuStok() async {
      var requestBody = {
        'CMD':'get_kartu_stok',
        'id_barang':g_id_brg_kartu_stok,
        'id_gudang':g_id_lokasi_gudang
      };

      http.Response res = await http.post(
          Uri.parse(postsURL2),
          body: requestBody,
      );

      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);
        List<kartu_stok_model> kartu_stok_models = body
        .map(
          (dynamic item) => kartu_stok_model.fromJson(item),
        )
        .toList();
        return kartu_stok_models;
      } else {
        throw "Unable to retrieve kartu_stok_models.";
      }
  }
}

class HttpService_get_list_supplier {
  String postsURL2 = 'https://kecapy.com/webservice.php';

  Future<List<get_list_supplier_model>> getListSupplier() async {
      var requestBody = {
        'CMD':'get_list_supplier',
      };

      http.Response res = await http.post(
          Uri.parse(postsURL2),
          body: requestBody,
      );

      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);
        List<get_list_supplier_model> get_list_supplier_models = body
        .map(
          (dynamic item) => get_list_supplier_model.fromJson(item),
        )
        .toList();
        return get_list_supplier_models;
      } else {
        throw "Unable to retrieve get_list_supplier_model.";
      }
  }
}

class HttpService_list_supplier_berdasarkan_supplier {
  String postsURL2 = 'https://kecapy.com/webservice.php';

  Future<List<list_barang_berdasarkan_supplier_model>> getListBarangBerdasarkanSupplier() async {
      var requestBody = {
        'CMD':'cari_barang_berdasarkan_supplier',
        'id_supplier':g_id_supplier_terpilih,
      };

      http.Response res = await http.post(
          Uri.parse(postsURL2),
          body: requestBody,
      );

      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);
        List<list_barang_berdasarkan_supplier_model> list_barang_berdasarkan_supplier_models = body
        .map(
          (dynamic item) => list_barang_berdasarkan_supplier_model.fromJson(item),
        )
        .toList();
        return list_barang_berdasarkan_supplier_models;
      } else {
        throw "Unable to retrieve list_barang_berdasarkan_supplier_model.";
      }
  }
}

class HttpService_list_admin_super {
  String postsURL2 = 'https://kecapy.com/webservice.php';

  Future<List<list_admin_super_model>> getListAdmin() async {
      var requestBody = {
        'CMD':'list_admin',
      };

      http.Response res = await http.post(
          Uri.parse(postsURL2),
          body: requestBody,
      );

      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);
        List<list_admin_super_model> list_admin_super_models = body
        .map(
          (dynamic item) => list_admin_super_model.fromJson(item),
        )
        .toList();
        return list_admin_super_models;
      } else {
        throw "Unable to retrieve list_admin_super_model.";
      }
  }
}