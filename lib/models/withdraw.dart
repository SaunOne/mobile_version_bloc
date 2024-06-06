import 'dart:convert';

class Withdraw {
  int idWithdraw;
  int idUser;
  int jumlah;
  String status;
  String tanggal;
  String namaBank;
  String noRek;

  Withdraw({
    required this.idWithdraw,
    required this.idUser,
    required this.jumlah,
    required this.status,
    required this.tanggal,
    required this.namaBank,
    required this.noRek,
  });

  // Converts a JSON map into an instance of Withdraw
  factory Withdraw.fromJson(Map<String, dynamic> json) {
    return Withdraw(
      idWithdraw: json['id_withdraw'] ?? 0,
      idUser: json['id_user'] ?? 0,
      jumlah: json['jumlah'] ?? 0,
      status: json['status'] ?? '',
      tanggal: json['tanggal'] ?? '',
      namaBank: json['nama_bank'] ?? '',
      noRek: json['no_rek'] ?? '',
    );
  }

  // Converts a Withdraw instance into a JSON map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_withdraw'] = this.idWithdraw;
    data['id_user'] = this.idUser;
    data['jumlah'] = this.jumlah;
    data['status'] = this.status;
    data['tanggal'] = this.tanggal;
    data['nama_bank'] = this.namaBank;
    data['no_rek'] = this.noRek;
    return data;
  }

  // Returns a raw JSON string from the Withdraw instance
  String toRawJson() => json.encode(toJson());
}

void main() {
  // Example usage
  String jsonString = '{"id_withdraw": 6, "id_user": 102, "jumlah": 50000, "status": "success", "tanggal": "2024-06-01", "nama_bank": "BCA", "no_rek": "213123123123"}';
  Map<String, dynamic> userMap = jsonDecode(jsonString);

  Withdraw withdraw = Withdraw.fromJson(userMap);

  print(withdraw.toRawJson());
}
