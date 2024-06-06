part of 'laporan_pemakaian_bloc.dart';

@immutable
sealed class LaporanPemakaianEvent {}

class GetLaporanPemakaianBahanBakuEvent extends LaporanPemakaianEvent{
    String start,end;
    GetLaporanPemakaianBahanBakuEvent(this.start,this.end);
}
