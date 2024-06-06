import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_version_bloc/api/apiLaporan.dart';
import 'package:mobile_version_bloc/models/laporan/laporanBahanBaku.dart';
import 'package:mobile_version_bloc/models/laporan/laporanPemasukanPengeluaran.dart';

part 'laporan_event.dart';
part 'laporan_state.dart';

class LaporanBloc extends Bloc<LaporanEvent, LaporanState> {
  LaporanBloc() : super(LaporanInitial()) {
    on<GetLaporanStokBahanBaku>(_onGenerateLaporanBahanBaku); 
  }

  Future<void> _onGenerateLaporanBahanBaku(GetLaporanStokBahanBaku event, Emitter<LaporanState> emit) async {
    emit(LaporanLoading());

    try {
      DataStok dataStok = await ApiLaporan().getDataStok();
      emit(LaporanBahanBakuData(dataStok));
    } catch (err) {
      print("error ${err}");
      emit(LaporanError(err.toString()));
    }
  }

  
}
