part of 'laporan_bloc.dart';

@immutable
abstract class LaporanState {}

class LaporanInitial extends LaporanState {}

class LaporanLoading extends LaporanState {}

class LaporanBahanBakuData extends LaporanState {
  final DataStok dataStok;

  LaporanBahanBakuData(this.dataStok);
}

class LaporanPemasukanPengeluaran extends LaporanState {
  final ModelLaporanPemasukanPengeluaran dataStok;

  LaporanPemasukanPengeluaran(this.dataStok);
  
}

class LaporanError extends LaporanState {
  final String message;

  LaporanError(this.message);
}
