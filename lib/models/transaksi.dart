import 'dart:convert';

import 'package:mobile_version_bloc/models/alamat.dart';
import 'package:mobile_version_bloc/models/detailTransaksi.dart';
import 'package:mobile_version_bloc/models/user.dart';


class Transaksi {
  int id;
  User? user;
  Alamat? alamat;
  List<DetailTransaksi>? listDetailPesanan;
  double total_harga_transaksi;
  String tanggal_pesan;
  String tanggal_pengembalian;
  String jenis_pesanan;
  int point_terpakai;
  String status_transaksi;
  String tanggal_pelunasan;
  double jumlah_pembayaran;
  String jenis_pengiriman;
  double biaya_pengiriman;
  String bukti_pembayaran;
  int point_diperoleh;

  Transaksi({
    required this.id,
    this.user,
    this.alamat,
    this.listDetailPesanan,
    required this.total_harga_transaksi,
    required this.tanggal_pesan,
    required this.tanggal_pengembalian,
    required this.jenis_pesanan,
    required this.point_terpakai,
    required this.status_transaksi,
    required this.tanggal_pelunasan,
    required this.jumlah_pembayaran,
    required this.jenis_pengiriman,
    required this.biaya_pengiriman,
    required this.bukti_pembayaran,
    required this.point_diperoleh,
  });

  // Converts a JSON map into an instance of Transaksi
  factory Transaksi.fromRawJson(String str) => Transaksi.fromJson(json.decode(str));

  factory Transaksi.fromJson(Map<String, dynamic> json) {
    return Transaksi(
      id: json['id_transaksi'] ?? 0,
      // user: User.fromRawJson(json['user']) ?? User.empty(),
      // alamat: Alamat.fromJson(json['alamat']),
      listDetailPesanan: (json['detail_transaksi'] as Iterable<dynamic>).map((e) => DetailTransaksi.fromJson(e)).toList(),
      total_harga_transaksi: (json['total_harga_transaksi'] ?? '').toDouble(),
      tanggal_pesan: json['tanggal_pesan'] ?? '',
      tanggal_pengembalian: json['tanggal_pengembalian'] ?? '',
      jenis_pesanan: json['jenis_pesanan'] ?? '',
      point_terpakai: json['point_terpakai'] ?? 0.0,
      status_transaksi: json['status_transaksi'] ?? '',
      tanggal_pelunasan: json['tanggal_pelunasan'] ?? '',
      jumlah_pembayaran: (json['jumlah_pembayaran'] ?? '').toDouble(),
      jenis_pengiriman: json['jenis_pengiriman'] ?? '',
      biaya_pengiriman: (json['biaya_pengiriman'] ?? '').toDouble(),
      bukti_pembayaran: json['bukti_pembayaran'] ?? '',
      point_diperoleh: json['point_diperoleh'] ?? 0,
    );
  }

  // Converts a Transaksi instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id_user': id,
      // 'user': user.toJson(),
      // 'alamat': alamat.toJson(),
      // 'listDetailPesanan': listDetailPesanan.map((e) => e.toJson()).toList(),
      'total_harga_transaksi': total_harga_transaksi,
      'tanggal_pesan': tanggal_pesan,
      'tanggal_pengembalian': tanggal_pengembalian,
      'jenis_pesanan': jenis_pesanan,
      'point_terpakai': point_terpakai,
      'status_transaksi': status_transaksi,
      'tanggal_pelunasan': tanggal_pelunasan,
      'jumlah_pembayaran': jumlah_pembayaran,
      'jenis_pengiriman': jenis_pengiriman,
      'biaya_pengiriman': biaya_pengiriman,
      'bukti_pembayaran': bukti_pembayaran,
      'point_diperoleh': point_diperoleh,
    };
  }

  // Returns a raw JSON string from the Transaksi instance
  String toRawJson() => json.encode(toJson());
}
