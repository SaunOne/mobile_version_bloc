import 'dart:convert';

import 'package:mobile_version_bloc/models/produk.dart';


class DetailTransaksi {
  Produk produk;
  int jumlah;

  DetailTransaksi({
    required this.produk,
    required this.jumlah,
  });

  // Converts a JSON map into an instance of DetailTransaksi
  factory DetailTransaksi.fromJson(Map<String, dynamic> json) {
    return DetailTransaksi(
      produk: Produk.fromJson(json['produk']),
      jumlah: json['jumlah_produk'] ?? 0,
    );
  }

  // Converts a DetailTransaksi instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'produk': produk.toJson(),
      'jumlah_produk': jumlah,
    };
  }

  // Returns a raw JSON string from the DetailTransaksi instance
  String toRawJson() => json.encode(toJson());
}
