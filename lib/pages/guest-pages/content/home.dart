import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mobile_version_bloc/models/produk.dart';
import 'package:mobile_version_bloc/models/user.dart';
import 'package:mobile_version_bloc/repository/apiProduk.dart';
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
    // TODO: implement initState
  }

  handleLoadData() {
    handleLoading(true);
    setState(() {
      ApiProduk().fetchAllTerlaris().then((value) {
        listProduk = value;
        print("hahs");
        print("isi : ${listProduk.length}");
        handleLoading(false);
      }).catchError((err) {
        print("error" + err);
      });
    });
  }

  void handleLoading(isLoading) {
    setState(() {
      this.isLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.25,
          ),
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
          height: 900,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(50),
            ),
            color: Color.fromARGB(255, 253, 247, 237),
          ),
        ),

        //infromasi umum

        Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
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
        ),
        Positioned(
          child: Container(
            margin: EdgeInsets.only(top: 100, left: 10, right: 10),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              // color: ColorPallate.seconddaryColor,
              // boxShadow: [
              //   BoxShadow(
              //     color: Color.fromARGB(95, 0, 0, 0).withOpacity(0.5),
              //     spreadRadius: 1,
              //     blurRadius: 2,
              //     offset: Offset(0, 1),
              //   ),
              // ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Jajanan Enak Menunggumu",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        BoxShadow(
                          color: Color.fromARGB(95, 0, 0, 0).withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Atma Kitchen adalah bakery online yang menghadirkan kue, pastry, minuman dan camilan lainnya langsung ke pintu rumah Anda. Dibuat dengan cinta dan bahan-bahan berkualitas tinggi," +
                      "setiap produk kami diolah dengan tangan ahli untuk memastikan setiap gigitan penuh dengan kelezatan yang tak tertandingi.",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      shadows: [
                        BoxShadow(
                          color: Color.fromARGB(95, 0, 0, 0).withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Color.fromARGB(95, 0, 0, 0).withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text("Gabung",style: TextStyle(
                            color: AppColors.backgroundColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.pushNamed(context, '/login');
                      },
                      child: Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Color.fromARGB(95, 0, 0, 0).withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text("Lihat Produk",style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          margin: EdgeInsets.only(top: 320),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            child: CarouselSlider(
                              options: CarouselOptions(
                                height: 200, 
                                viewportFraction: 1,
                                autoPlay: true,
                              ),
                              items: [1, 2, 3, 4].map((i) {
                                return Builder(builder: (BuildContext context) {
                                  return Container(
                                    padding: EdgeInsets.all(5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.backgroundColor,
                                        borderRadius: BorderRadius.circular(10),
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
                                                bottomLeft: Radius.circular(10),
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
                                                  fit: BoxFit.cover),
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 160,
                                                      child: Text(
                                                        listProduk[i]
                                                            .nama_produk,
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
                                                        listProduk[i].deskripsi,
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
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 20),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: AppColors.primaryColor),
                                                  child: Text(
                                                    "Rp. ${listProduk[i].harga}",
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
                                });
                              }).toList(), // Tambahkan .toList() di sini
                            ),
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
