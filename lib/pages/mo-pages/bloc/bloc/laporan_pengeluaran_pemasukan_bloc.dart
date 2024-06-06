import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_version_bloc/api/apiLaporan.dart';
import 'package:mobile_version_bloc/models/laporan/laporanPemasukanPengeluaran.dart';

part 'laporan_pengeluaran_pemasukan_event.dart';
part 'laporan_pengeluaran_pemasukan_state.dart';

class LaporanPengeluaranPemasukanBloc extends Bloc<LaporanPengeluaranPemasukanEvent, LaporanPengeluaranPemasukanState> {
  LaporanPengeluaranPemasukanBloc() : super(LaporanPengeluaranPemasukanInitial()) {
    on<GetLaporanPengeluaranPemasukan>(_onGetLaporanPengluaranPemasukan);
  }

  Future<void> _onGetLaporanPengluaranPemasukan(GetLaporanPengeluaranPemasukan event,Emitter<LaporanPengeluaranPemasukanState> emit) async {
    emit(LaporanPengeluaranLoading());
    try {
      ModelLaporanPemasukanPengeluaran dataLaporan = await ApiLaporan().getDataPengeluaranPemasukan(event.tanggal);
      emit(LaporanPemasukanPengeluaranData(dataLaporan));
    } catch (err) {
      print("error ${err}");
      emit(LaporanError(err.toString()));
    }
  }
}
