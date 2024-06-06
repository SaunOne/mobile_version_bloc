part of 'laporan_pemakaian_bloc.dart';

@immutable
sealed class LaporanPemakaianState {}

final class LaporanPemakaianInitial extends LaporanPemakaianState {}

class LaporanLoading extends LaporanPemakaianState {}

class LaporanPemakaianBahanBakuData extends LaporanPemakaianState {
  final DataStok dataStok;

  LaporanPemakaianBahanBakuData(this.dataStok);
}

class LaporanError extends LaporanPemakaianState {
  final String message;

  LaporanError(this.message);
}
