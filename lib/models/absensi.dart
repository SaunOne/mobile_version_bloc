import 'dart:convert';

import 'package:mobile_version_bloc/models/karyawan.dart';


class Absensi {
  int id;
  Karyawan? karyawan;
  String tanggal;

  Absensi({
    required this.id,
    this.karyawan,
    required this.tanggal,
  });

  // Factory constructor to create an Absensi object from a JSON map
  factory Absensi.fromJson(Map<String, dynamic> json) {

    return Absensi(
      id : json['id_absensi'],
      karyawan: Karyawan.fromJson(json),
      tanggal: json['tanggal'] ?? '',
    );
  }

  // Method to convert an Absensi object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id_absensi' : id ?? 1,
      'karyawan': karyawan!.toJson(),
      'tanggal': tanggal ?? '',
    };
  }

  // Method to get a raw JSON string from an Absensi object
  String toRawJson() => json.encode(toJson());
}
