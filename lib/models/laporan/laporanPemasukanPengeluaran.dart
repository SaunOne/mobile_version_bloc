class ModelLaporanPemasukanPengeluaran {
  String alamat;
  String bulan;
  String tahun;
  String tanggalCetak;
  List<DataItem> data;

  ModelLaporanPemasukanPengeluaran({
    required this.alamat,
    required this.bulan,
    required this.tahun,
    required this.tanggalCetak,
    required this.data,
  });

  factory ModelLaporanPemasukanPengeluaran.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<DataItem> dataList = list.map((i) => DataItem.fromJson(i)).toList();

    return ModelLaporanPemasukanPengeluaran(
      alamat: json['alamat'] ?? '',
      bulan: json['bulan'] ?? '',
      tahun: json['tahun'] ?? '',
      tanggalCetak: json['tanggal_cetak'],
      data: dataList ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'alamat': alamat,
      'bulan': bulan,
      'tahun': tahun,
      'tanggal_cetak': tanggalCetak,
      'data': data.map((v) => v.toJson()).toList(),
    };
  }
}

class DataItem {
  String nama;
  double pemasukan;
  double pengeluaran;

  DataItem({
    required this.nama,
    required this.pemasukan,
    required this.pengeluaran,
  });

  factory DataItem.fromJson(Map<String, dynamic> json) {
    return DataItem(
      nama: json['nama'] ?? '',
      pemasukan: (json['pemasukan'] ?? 0).toDouble(),
      pengeluaran: (json['pengeluaran'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'pemasukan': pemasukan,
      'pengeluaran': pengeluaran,
    };
  }
}
