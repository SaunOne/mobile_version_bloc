part of 'laporan_pengeluaran_pemasukan_bloc.dart';

@immutable
sealed class LaporanPengeluaranPemasukanEvent {}

class GetLaporanPengeluaranPemasukan extends LaporanPengeluaranPemasukanEvent{
    String tanggal;
    GetLaporanPengeluaranPemasukan(this.tanggal);
}