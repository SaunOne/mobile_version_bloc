import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version_bloc/pages/auth-pages/bloc/login_bloc/login_bloc.dart';
import 'package:mobile_version_bloc/pages/mo-pages/bloc/bloc/laporan_pengeluaran_pemasukan_bloc.dart';
import 'package:mobile_version_bloc/pages/mo-pages/bloc/laporan/laporan_bloc.dart';
import 'package:mobile_version_bloc/pages/mo-pages/bloc/laporan_pengunaan_bahan/laporan_pemakaian_bloc.dart';
import 'package:mobile_version_bloc/pages/mo-pages/view/content/generate-laporan/laporanPemasukanPengeluaran.dart';
import 'package:mobile_version_bloc/pages/user-pages/bloc/history_bloc/bloc/history_bloc.dart';
import 'package:mobile_version_bloc/pages/user-pages/bloc/produk_bloc/produk_bloc.dart';
import 'package:mobile_version_bloc/pages/user-pages/view/content/history.dart';
import 'package:mobile_version_bloc/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<ProdukBloc>(
          create: (context) => ProdukBloc(),
        ),
        BlocProvider<HistoryBloc>(
          create: (context) => HistoryBloc(),
        ),
        BlocProvider<LaporanBloc>(
          create: (context) => LaporanBloc(),
        ),
        BlocProvider<LaporanPemakaianBloc>(
          create: (context) => LaporanPemakaianBloc(),
        ),
        BlocProvider<LaporanPengeluaranPemasukanBloc>(
          create: (context) => LaporanPengeluaranPemasukanBloc(),
        ),

      ],
      child: MaterialApp( 
        title: 'Atma Kitchen App',
        initialRoute: '/login',
        routes: routes,
      ),
    );  
  }
}
