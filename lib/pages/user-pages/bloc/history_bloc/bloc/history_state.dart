part of 'history_bloc.dart';

@immutable
sealed class HistoryState {}

final class HistoryInitial extends HistoryState {}

final class HistoryData extends HistoryState {
  List<Transaksi> listTransaksi = [];
  HistoryData(this.listTransaksi) : super();
}

final class ShowHistoryData extends HistoryState {
  List<Transaksi> listTransaksi = [];
  ShowHistoryData(this.listTransaksi) : super();
}

final class konfrimasiPesanan extends HistoryState {
  bool status = true;
  konfrimasiPesanan(this.status) : super();
}

final class HistoryLoading extends HistoryState {

}
 