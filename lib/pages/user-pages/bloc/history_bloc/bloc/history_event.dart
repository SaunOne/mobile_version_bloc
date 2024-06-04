part of 'history_bloc.dart';

@immutable
sealed class HistoryEvent {}

class LoadHistoryEvent extends HistoryEvent {

}

class TampilTransaksiEvent extends HistoryEvent {
  List<Transaksi> listTransaksi = [];
  String search;
  TampilTransaksiEvent({required this.search,required this.listTransaksi});
}

class KonfirmasiPesananEvent extends HistoryEvent {
  int id;
  List<Transaksi> listTransaksi = [];
  KonfirmasiPesananEvent({ required this.id,required this.listTransaksi});
}

