import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version_bloc/models/detailTransaksi.dart';
import 'package:mobile_version_bloc/models/produk.dart';
import 'package:mobile_version_bloc/models/transaksi.dart';
import 'package:mobile_version_bloc/pages/auth-pages/bloc/login_bloc/login_bloc.dart';
import 'package:mobile_version_bloc/pages/user-pages/bloc/history_bloc/bloc/history_bloc.dart';
import 'package:mobile_version_bloc/pages/user-pages/bloc/produk_bloc/produk_bloc.dart';
import 'package:mobile_version_bloc/utility/appColor.dart';
import 'package:mobile_version_bloc/utility/font_constants.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  int noActive = 0;
  TextEditingController searchController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  List<Transaksi> listAllTransaksi = [];
  List<Transaksi> listTransaksi = [];
  String search = "";

  bool isLoading = false;
  bool isSearch = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handleLoadData();
  }

  void handleLoadData() {
    final produkBloc = context.read<ProdukBloc>();
    produkBloc.add(LoadDataEvent());
    final historyBloc = context.read<HistoryBloc>();
    historyBloc.add(LoadHistoryEvent());
  }

  void switchNav(int i) {
    setState(() {
      noActive = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    final historyBloc = context.read<HistoryBloc>();
    final produkBloc = context.read<ProdukBloc>();
    final loginBloc = context.read<LoginBloc>();
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              BlocBuilder<ProdukBloc, ProdukState>(
                builder: (context, state) {
                  if (state is ProdukLoading) {
                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is ProdukData) {
                    List<Produk> listProduk = state.listProduks;
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(95, 0, 0, 0).withOpacity(0.5),
                            spreadRadius: 0.05,
                            blurRadius: 1,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  color: AppColors.backgroundColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.brown)),
                              child: Stack(
                                children: [
                                  Positioned(
                                    right: 10,
                                    bottom: -6,
                                    child: DropdownButton<Produk>(
                                      // Nilai awal dropdown
                                      onChanged: (Produk? newValue) {
                                        if (newValue != null) {
                                          searchController.text =
                                              newValue.nama_produk;
                                        }
                                      },
                                      items: listProduk.map((Produk value) {
                                        return DropdownMenuItem<Produk>(
                                          value: value,
                                          child: Text(value.nama_produk),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 50),
                                    child: Form(
                                      child: TextFormField(
                                        controller: searchController,
                                        onChanged: (value) {},
                                        decoration: const InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          prefixIcon: Icon(Icons.search),
                                          labelText: "Search",
                                          disabledBorder:
                                              UnderlineInputBorder(),
                                          border: InputBorder.none,
                                          fillColor: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              child: navigation(),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else
                    return Container();
                },
              ),
              SizedBox(
                height: 10,
              ),
              //isi
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 20, left: 5, right: 5),
                  child: SingleChildScrollView(
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : contentHistory(context, historyBloc),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget contentHistory(context, HistoryBloc historyBloc) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        if (state is HistoryLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HistoryData) {
          listAllTransaksi = state.listTransaksi;

          listTransaksi = listAllTransaksi;
        } else if (state is ShowHistoryData) {
          listTransaksi = state.listTransaksi;
        }
        print("leng transaksi : ${listTransaksi.length}");
        return Column(
          children: [
            SizedBox(
              height: 10,
            ),
            ...listTransaksi.map(
              (data) {
                print(
                    "list detail pesanan : ${data.listDetailPesanan!.length}");
                return Container(
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(95, 0, 0, 0).withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "No Pesanan : ${data.id}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Tanggal : " + data.tanggal_pesan,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                              Container(
                                width: 110,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: data.status_transaksi == "ditolak"
                                      ? Colors.red
                                      : Colors.green,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                    child: Text(
                                  data.status_transaksi,
                                  style: FontConstants.bodyText2(
                                      color: Colors.white),
                                )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage("assets/images/cake1.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 220,
                                  height: 80,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            data.listDetailPesanan!.length != 0
                                                ? data.listDetailPesanan![0]
                                                    .produk.nama_produk
                                                : "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                          Text(
                                            data.listDetailPesanan!.length != 0
                                                ? data.listDetailPesanan![0]
                                                    .jumlah
                                                    .toString()
                                                : "",
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data.listDetailPesanan!.length != 0
                                                ? data.listDetailPesanan![0]
                                                    .produk.harga
                                                    .toString()
                                                : "",
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  _showConfirmationDialog(
                                      context, historyBloc, data.id);
                                },
                                child:
                                    (data.status_transaksi == "sudah di-pickup")
                                        ? Container(
                                            // margin: EdgeInsets.only(top: 5),
                                            width: 100,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Center(
                                                child: Text(
                                              "Konfirmasi",
                                              style: FontConstants.bodyText2(
                                                  color: Colors.white),
                                            )),
                                          )
                                        : Container(),
                              ),
                              Text(
                                "Rp${data.total_harga_transaksi}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget navigation() {
    final historyBloc = context.read<HistoryBloc>();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem("semua", 0, historyBloc),
          SizedBox(width: 10),
          _buildNavItem("diterima", 1, historyBloc),
          SizedBox(width: 10),
          _buildNavItem("diproses", 2, historyBloc),
          SizedBox(width: 10),
          _buildNavItem("sudah di-pickup", 3, historyBloc),
          SizedBox(width: 10),
          _buildNavItem("dikirim kurir", 4, historyBloc),
          SizedBox(width: 10),
          _buildNavItem("selesai", 5, historyBloc),
          SizedBox(width: 10),
          _buildNavItem("ditolak", 6, historyBloc),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, int index, HistoryBloc historyBloc) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        border: noActive == index
            ? Border(
                bottom: BorderSide(color: AppColors.primaryColor, width: 2),
              )
            : null,
      ),
      child: GestureDetector(
        onTap: () {
          search = title.toLowerCase() == "semua" ? "" : title.toLowerCase();
          historyBloc.add(TampilTransaksiEvent(
              search: search, listTransaksi: listAllTransaksi));
          switchNav(index);
        },
        child: Text(
          title,
          style: TextStyle(
              color: noActive == index ? AppColors.primaryColor : Colors.black,
              fontWeight:
                  noActive == index ? FontWeight.bold : FontWeight.normal),
        ),
      ),
    );
  }

  void _showConfirmationDialog(
      BuildContext context, HistoryBloc historyBloc, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          iconColor: AppColors.primaryColor,
          title: Text('Konfirmasi'),
          content: Text('Yakin mau konfirmasi pesanan ini?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text('Tidak'),
            ),
            ElevatedButton(
              onPressed: () {
                historyBloc.add(KonfirmasiPesananEvent(
                    id: id, listTransaksi: listAllTransaksi));
                Navigator.of(context).pop();
                switchNav(0);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Pesanan telah dikonfirmasi!'),
                  ),
                );
              },
              child: Text('Iya'),
            ),
          ],
        );
      },
    );
  }
}
