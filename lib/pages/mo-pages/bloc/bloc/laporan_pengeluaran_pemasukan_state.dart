part of 'laporan_pengeluaran_pemasukan_bloc.dart';

@immutable
sealed class LaporanPengeluaranPemasukanState {}

final class LaporanPengeluaranPemasukanInitial extends LaporanPengeluaranPemasukanState {}

class LaporanPengeluaranLoading extends LaporanPengeluaranPemasukanState {
  
}

class LaporanPemasukanPengeluaranData extends LaporanPengeluaranPemasukanState {
  final ModelLaporanPemasukanPengeluaran dataLaporan;

  LaporanPemasukanPengeluaranData(this.dataLaporan);
  
}

class LaporanError extends LaporanPengeluaranPemasukanState {
  final String message;

  LaporanError(this.message);
}