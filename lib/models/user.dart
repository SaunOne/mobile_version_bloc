import 'dart:convert';
import 'package:mobile_version_bloc/models/role.dart';
import 'package:mobile_version_bloc/models/transaksi.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

class User {
  int id;
  String username, password, nama_lengkap, gender, tanggal_lahir,email,no_telp;
  Role? role;
  List<Transaksi>? transaksi = [];
  
  User({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.nama_lengkap,
    required this.gender,
    required this.tanggal_lahir,
    required this.no_telp,
    this.transaksi,
    Role? this.role,
  });

  User.empty()
      : id = 0,
        username = "",
        no_telp = "",
        password = "",
        nama_lengkap = "",
        gender = "",
        tanggal_lahir = "",
        email = "",
        transaksi = [],
        role = Role(id_role: 0, namaRole: '');

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str ));

  factory User.fromJson(Map<String,dynamic> json){
    json = json["user"] ?? json;
   
    return User(
      id : json["id"] ?? 0,
      username : json["username"] ?? '',
      password : json["password"] ?? '',
      nama_lengkap: json["nama_lengkap"] ?? '' ,
      no_telp : json["no_telp"] ?? '',
      gender : json["gender"] ?? '',
      email : json["email"] ?? '',
      tanggal_lahir : json["tanggal_lahir"] ?? '',
      transaksi : (json['transaksis'] as List<dynamic>? ?? [])
          .map((e) => Transaksi.fromJson(e))
          .toList(),
      role: Role.fromJson(json) ?? Role(id_role: 0, namaRole: "-")
     );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
    "id" : id,
    "username" : username,
    "password" : password,
    "nama_lengkap" : nama_lengkap,
    "gender" : gender,
    "tanggal_lahir" : tanggal_lahir,
    "email" : email,
  };

  void addTransaksi(Transaksi data){
    transaksi!.add(data);
  }

}
 