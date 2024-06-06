import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_version_bloc/api/apiLaporan.dart';
import 'package:mobile_version_bloc/models/laporan/laporanBahanBaku.dart';
import 'package:mobile_version_bloc/models/laporan/laporanPemasukanPengeluaran.dart';

part 'laporan_pemakaian_event.dart';
part 'laporan_pemakaian_state.dart';

class LaporanPemakaianBloc extends Bloc<LaporanPemakaianEvent, LaporanPemakaianState> {
  LaporanPemakaianBloc() : super(LaporanPemakaianInitial()) {
    on<GetLaporanPemakaianBahanBakuEvent>(_onGetPemakaianBahanBaku);
  }

  Future<void> _onGetPemakaianBahanBaku(GetLaporanPemakaianBahanBakuEvent event, Emitter<LaporanPemakaianState> emit) async {
    emit(LaporanLoading());

    try {
      DataStok dataStok = await ApiLaporan().getDataPemakaianBahanBaku(event.start,event.end);
      emit(LaporanPemakaianBahanBakuData(dataStok));
    } catch (err) {
      print("error ${err}");
      emit(LaporanError(err.toString()));
    }
  }
}
