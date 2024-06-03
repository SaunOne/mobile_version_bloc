import 'dart:convert';

class Role {
  int id_role;
  String namaRole;
  Role({
    required this.id_role,
    required this.namaRole,
  });

   factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id_role : json['id_role'] ?? 0,
      namaRole: json['nama_role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_role' : id_role,
      'nama_role' : namaRole
    };
  }

  String toRawJson() => json.encode(toJson());
}
