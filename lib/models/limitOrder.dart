import 'dart:convert';

class LimitOrder {
  int idLimit;
  int idProduk;
  String tanggal;
  int jumlahSisa;

  LimitOrder({
    required this.idLimit,
    required this.idProduk,
    required this.tanggal,
    required this.jumlahSisa,
  });

  // Converts a JSON map into an instance of LimitOrder
  factory LimitOrder.fromJson(Map<String, dynamic> json) {
    return LimitOrder(
      idLimit: json['id_limit'] ?? 0,
      idProduk: json['id_produk'] ?? 0,
      tanggal: json['tanggal'] ?? '',
      jumlahSisa: json['jumlah_sisa'] ?? 0,
    );
  }

  // Converts a LimitOrder instance into a JSON map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id_limit': this.idLimit,
      'id_produk': this.idProduk,
      'tanggal': this.tanggal,
      'jumlah_sisa': this.jumlahSisa,
    };
    return data;
  }

  // Returns a raw JSON string from the LimitOrder instance
  String toRawJson() => json.encode(toJson());
}
