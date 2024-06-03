import 'dart:convert';

import 'package:mobile_version_bloc/models/readyStok.dart';


class Produk {
  int id;
  ReadyStok? readyStok;
  String nama_produk;
  double harga; // Changed from 'float' to 'double' because Dart uses 'double'
  double quantity; // Changed from 'float' to 'double'
  String deskripsi;
  String image_produk;
  String jenis_produk;

  Produk({
    required this.id,
    this.readyStok,
    required this.nama_produk,
    required this.harga,
    required this.quantity,
    required this.deskripsi,
    required this.image_produk,
    required this.jenis_produk,
  });

  // Factory constructor to create a Produk object from a JSON map
  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      id: json['id_produk'] ?? 0,
      readyStok: ReadyStok.fromJson(json) ?? null,
      nama_produk: json['nama_produk'] ?? '',
      harga: (json['harga'] ?? 0).toDouble(),
      quantity: (json['quantity'] ?? 0).toDouble(),
      deskripsi: json['deskripsi'] ?? '',
      image_produk: json['image_produk'] ?? '',
      jenis_produk: json['jenis_produk'] ?? '',
    );
  }

  // Method to convert a Produk object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      // 'readyStok': readyStok?.toJson(),
      'nama_produk': nama_produk,
      'harga': harga,
      'quantity': quantity,
      'deskripsi': deskripsi,
      'image_produk': image_produk,
      'jenis_produk': jenis_produk,
    };
  }

  // Method to get a raw JSON string from a Produk object
  String toRawJson() => json.encode(toJson());

  @override
  String toString() {
    // TODO: implement toString
    return this.nama_produk;
  }
}
