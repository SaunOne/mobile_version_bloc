part of 'produk_bloc.dart';

@immutable
sealed class ProdukState {}

final class ProdukInitial extends ProdukState {

}

// ignore: must_be_immutable
final class ProdukData extends ProdukState {
  List<Produk> listProduks = [];
  ProdukData(listProduk) : super();
}

final class ProdukLoading extends ProdukState {

}
