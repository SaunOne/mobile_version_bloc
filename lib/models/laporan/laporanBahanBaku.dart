import 'dart:convert';

import 'package:mobile_version_bloc/pages/mo-pages/view/content/laporan.dart';

class ReadyStok {
  int id;
  double jumlahStok;
  double digunakan;
  String satuan;
  String namaBahan;

  ReadyStok({
    required this.id,
    required this.jumlahStok,
    required this.satuan,
    required this.namaBahan,
    required this.digunakan
  });

  factory ReadyStok.fromJson(Map<String, dynamic> json) {
    return ReadyStok(
      id: json['id_bahan'] ?? 0,
      jumlahStok: (json['stok_bahan'] ?? 0).toDouble(),
      satuan: json['satuan'] ?? '',
      namaBahan: json['nama_bahan'] ?? '',
      digunakan: (json['digunakan'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jumlah_stok': jumlahStok,
      'satuan': satuan,
      'nama_bahan': namaBahan,
      'digunakan' : digunakan
    };
  }

  String toRawJson() => json.encode(toJson());
}

class DataStok{
  String alamat;
  String tanggalCetak;
  List<ReadyStok> data;

  DataStok({
    required this.alamat,
    required this.tanggalCetak,
    required this.data,
  });

  factory DataStok.fromJson(Map<String, dynamic> json) {
    print("sebelum eror");
    // print(json);
    return DataStok(
      alamat: json['alamat'] ?? '',
      tanggalCetak: json['tanggal_cetak'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ReadyStok.fromJson(e))
          ?.toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'alamat': alamat,
      'tanggal_cetak': tanggalCetak,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }

  String toRawJson() => json.encode(toJson());
}
