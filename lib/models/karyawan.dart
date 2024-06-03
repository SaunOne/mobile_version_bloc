import 'dart:convert';

import 'package:mobile_version_bloc/models/absensi.dart';
import 'package:mobile_version_bloc/models/user.dart';


class Karyawan extends User {
  String jabatan;
  double gaji;
  double bonus_gaji;
  User? user;
  List<Absensi>? listAbsen;

  Karyawan({
    required super.id,
    required super.username,
    required super.password,
    required super.email,
    required super.nama_lengkap,
    required super.gender,
    required super.tanggal_lahir,
    required super.no_telp,
    required this.jabatan,
    required this.gaji,
    required this.bonus_gaji,
    this.user,
    this.listAbsen,
  });

  // Converts a JSON map into an instance of Karyawan
  factory Karyawan.fromJson(Map<String, dynamic> json) {
    return Karyawan(
      id: json['id_user'] ?? 0,
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      no_telp: json['no_telp'] ?? '',
      email : json['email'] ?? '',
      nama_lengkap: json['nama_lengkap'] ?? '',
      gender: json['gender'] ?? '',
      tanggal_lahir: json['tanggal_lahir'] ?? '',
      jabatan: json['jabatan'] ?? '',
      gaji: (json['gaji'] ?? 0).toDouble(),
      bonus_gaji: (json['bonus_gaji'] ?? 0).toDouble(),
      user:  User.fromJson(json) ?? null, 
    );
  }

  // Converts a Karyawan instance into a JSON map
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();  // Call toJson of User to include base attributes
    data['jabatan'] = this.jabatan;
    data['gaji'] = this.gaji;
    data['bonus_gaji'] = this.bonus_gaji;
    return data;
  }

  // Returns a raw JSON string from the Karyawan instance
  @override
  String toRawJson() => json.encode(toJson());
}
