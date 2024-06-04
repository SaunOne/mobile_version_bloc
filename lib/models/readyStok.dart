import 'dart:convert';


class ReadyStok {
  int id;
  double jumlah_stok;
  String satuan;

  ReadyStok(
      {required this.id, required this.jumlah_stok, required this.satuan});

  // Factory constructor to create a Produk object from a JSON map
  factory ReadyStok.fromJson(Map<String, dynamic> json) {
    return ReadyStok(
      id: json['id_produk'] ?? 0,
      jumlah_stok: (json['jumlah_stok'] ?? 0).toDouble(),
      satuan: json['satuan'] ?? '',
    );
  }

  // Method to convert a Produk object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jumlah_stok': jumlah_stok,
      'satuan': satuan,
    };
  }

  // Method to get a raw JSON string from a Produk object
  String toRawJson() => json.encode(toJson());
}
