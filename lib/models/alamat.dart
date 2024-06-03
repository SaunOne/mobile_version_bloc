import 'dart:convert';

import 'package:mobile_version_bloc/models/user.dart';


class Alamat {
  int id;
  User? user; // Optional User reference
  String provinsi;
  String kabupaten;
  String kecamatan;
  String kelurahan;
  String detail_alamat;
  int kode_pos;

  Alamat({
    required this.id,
    this.user,
    required this.provinsi,
    required this.kabupaten,
    required this.kecamatan,
    required this.kelurahan,
    required this.detail_alamat,
    required this.kode_pos,
  });

  // Converts a JSON map into an instance of Alamat
  factory Alamat.fromJson(Map<String, dynamic> json) {
    return Alamat(
      id: json['id'] ?? 0,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      provinsi: json['provinsi'] ?? '',
      kabupaten: json['kabupaten'] ?? '',
      kecamatan: json['kecamatan'] ?? '',
      kelurahan: json['kelurahan'] ?? '',
      detail_alamat: json['detail_alamat'] ?? '',
      kode_pos: json['kode_pos'] ?? 0,
    );
  }

  // Converts an Alamat instance into a JSON map
  Map<String, dynamic> toJson() {
    var data = {
      'id': id,
      'provinsi': provinsi,
      'kabupaten': kabupaten,
      'kecamatan': kecamatan,
      'kelurahan': kelurahan,
      'detail_alamat': detail_alamat,
      'kode_pos': kode_pos,
    };

    if (user != null) {
      data['user'] = user!.toJson();
    }

    return data;
  }

  // Returns a raw JSON string from the Alamat instance
  String toRawJson() => json.encode(toJson());
}
