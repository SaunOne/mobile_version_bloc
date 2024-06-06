import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_version_bloc/api/apiTransaksi.dart';
import 'package:mobile_version_bloc/models/transaksi.dart';
import 'package:mobile_version_bloc/pages/user-pages/bloc/produk_bloc/produk_bloc.dart';
import 'package:mobile_version_bloc/pages/user-pages/view/content/history.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial()) {
    on<LoadHistoryEvent>(_onLoadHistory);
    on<TampilTransaksiEvent>(_onTampilData);
    on<KonfirmasiPesananEvent>(_onKonfirmasiPesanan);
  }

  Future<void> _onLoadHistory(
      LoadHistoryEvent event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading());
    try {
      print("masuk history");
      List<Transaksi> listTransaksi = await ApiTransaksi().findByUser();
      emit(HistoryData(listTransaksi));
    } catch (error) {
      print(error);
    }
  }

  Future<void> _onTampilData(
      TampilTransaksiEvent event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading());
    try {
      print("masuk history");

      List<Transaksi> temp = event.listTransaksi;
      List<Transaksi> listTransaksi = [];
      print("temp : ${temp.length}");
      if (event.search == "") {
        listTransaksi = temp;
      } else {
        for (Transaksi item in temp) {
          if (item.status_transaksi
              .toLowerCase()
              .contains(event.search.toLowerCase())) {
            listTransaksi.add(item);
            break;
          }
        }
      }

      emit(ShowHistoryData(listTransaksi));
    } catch (error) {
      print(error);
    }

    Future<void> _onTampilData(
        TampilTransaksiEvent event, Emitter<HistoryState> emit) async {
      emit(HistoryLoading());
      try {
        print("masuk history");

        List<Transaksi> temp = event.listTransaksi;
        List<Transaksi> listTransaksi = [];
        print("temp : ${temp.length}");
        if (event.search == "") {
          listTransaksi = temp;
        } else {
          for (Transaksi item in temp) {
            if (item.status_transaksi
                .toLowerCase()
                .contains(event.search.toLowerCase())) {
              listTransaksi.add(item);
              break;
            }
          }
        }

        emit(ShowHistoryData(listTransaksi));
      } catch (error) {
        print(error);
      }
    }
  }

  Future<void> _onKonfirmasiPesanan(
      KonfirmasiPesananEvent event, Emitter<HistoryState> emit) async {
    try {
      emit(HistoryLoading());
      print("masuk konfirmasi");

      try {
        print("masuk history");
       var response = await ApiTransaksi().konfirmasi(event.id);
       List<Transaksi> listTransaksi = event.listTransaksi;
        for(Transaksi transaksi in listTransaksi){
            if(transaksi.id == event.id){
              transaksi.status_transaksi = "selesai";
            }
        }
        emit(HistoryData(listTransaksi));
      } catch (error) {
        print(error);
      }

    } catch (error) {
      print(error);
    }
  }
}
