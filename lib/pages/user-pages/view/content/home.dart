import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version_bloc/models/produk.dart';
import 'package:mobile_version_bloc/models/user.dart';
import 'package:mobile_version_bloc/pages/auth-pages/bloc/login_bloc/login_bloc.dart';
import 'package:mobile_version_bloc/pages/user-pages/bloc/produk_bloc/produk_bloc.dart';
import 'package:mobile_version_bloc/utility/appColor.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Produk> listProduk = [];
  User? user;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    handleLoadData();
  }

  void handleLoadData() {
    final produkBloc = context.read<ProdukBloc>();
    produkBloc.add(LoadDataEvent());
  }

  void handleLoading(bool isLoading) {
    setState(() {
      this.isLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final produkBloc = context.read<ProdukBloc>();
    final loginBloc = context.read<LoginBloc>();
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.25,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
          height: 900,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(50),
            ),
            color: Color.fromARGB(255, 253, 247, 237),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(200)),
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(
                      0.4), // Ubah nilai opacity sesuai dengan kebutuhan
                  BlendMode.darken),
              image: AssetImage("assets/images/br-cake1.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 120,
                    ),
                    const Text(
                      "Hello,",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                          shadows: [
                            Shadow(
                              offset: Offset(3.0, 3.0),
                              blurRadius: 8.0,
                              color: Color.fromARGB(255, 27, 23, 23),
                            ),
                          ]),
                    ),
                    if (user != null)
                      Text(
                        user!.nama_lengkap,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                            shadows: [
                              Shadow(
                                offset: Offset(4.0, 4.0),
                                blurRadius: 8.0,
                                color: Color.fromARGB(255, 27, 23, 23),
                              ),
                            ]),
                      ),
                  ],
                ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          margin: EdgeInsets.only(top: 220),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 220,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(95, 0, 0, 0).withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          if (state is LoginLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else if (state is LoginSuccess) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Atma Wallet",
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.wallet,
                                        color: AppColors.primaryColor,
                                        size: 40,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${100000} Atma Wallet",
                                        style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: AppColors.primaryColor,
                                        size: 40,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${100} Points",
                                        style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  MaterialButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {},
                                    child: Container(
                                      height: 35,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "History Withdraw",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                          return Container(); // Tambahkan return container kosong untuk menghindari error
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      " Produk Terlaris",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<ProdukBloc, ProdukState>(
                      builder: (context, state) {
                        if (state is ProdukLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is ProdukData) {
                          listProduk = state.listProduks;
                          return CarouselSlider(
                            options: CarouselOptions(
                              height: 200,
                              viewportFraction: 1,
                              autoPlay: true,
                            ),
                            items: listProduk.map(
                              (produk) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      padding: EdgeInsets.all(5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.backgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromARGB(95, 0, 0, 0)
                                                  .withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 150,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color.fromARGB(
                                                            95, 0, 0, 0)
                                                        .withOpacity(0.5),
                                                    spreadRadius: 1,
                                                    blurRadius: 2,
                                                    offset: Offset(0, 1),
                                                  ),
                                                ],
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    "assets/images/br-cake2.png",
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 20, horizontal: 15),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 160,
                                                        child: Text(
                                                          produk.nama_produk,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Container(
                                                        width: 160,
                                                        child: Text(
                                                          produk.deskripsi,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          softWrap: true,
                                                          maxLines: 4,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2,
                                                            horizontal: 20),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: AppColors
                                                            .primaryColor),
                                                    child: Text(
                                                      "Rp. ${produk.harga}",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ).toList(),
                          );
                        }
                        return Container(); // Tambahkan return container kosong untuk menghindari error
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
