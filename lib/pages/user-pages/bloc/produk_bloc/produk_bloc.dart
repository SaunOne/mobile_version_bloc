import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_version_bloc/api/apiProduk.dart';
import 'package:mobile_version_bloc/models/produk.dart';

part 'produk_event.dart';
part 'produk_state.dart';

class ProdukBloc extends Bloc<ProdukEvent, ProdukState> {
  ProdukBloc() : super(ProdukInitial()) {
    on<LoadDataEvent>(_onLoadData);
  }

  Future<void> _onLoadData(
      LoadDataEvent event, Emitter<ProdukState> emit) async {
    emit(ProdukLoading()); // Emit state loading
    try {
      print("Mengambil data produk");
      var value = await ApiProduk().fetchAll(); // Tunggu hasil pemanggilan API
      emit(ProdukData(value)); // Emit state berhasil dengan data
    } catch (error) {
      print('error : $error');
      emit(ProdukData(error.toString())); // Emit state error dengan pesan error
    }
  }
}
