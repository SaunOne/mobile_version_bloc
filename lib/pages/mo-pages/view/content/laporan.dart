import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_version_bloc/pages/mo-pages/view/content/generate-laporan/laporanBahanBaku.dart';
import 'package:mobile_version_bloc/pages/mo-pages/view/content/generate-laporan/laporanPemasukanPengeluaran.dart';
import 'package:mobile_version_bloc/pages/mo-pages/view/content/generate-laporan/laporanPengunaanBahanBaku.dart';
import 'package:mobile_version_bloc/utility/appColor.dart';

class Laporan extends StatefulWidget {
  const Laporan({super.key});

  @override
  State<Laporan> createState() => _LaporanState();
}

class _LaporanState extends State<Laporan> {
  bool isActiveOvl = false;
  int indexActive = 0;

  List<Widget> listLaporan = [
    LaporanBahanBaku(),
    LaporanPengunaanBahanBaku(),
    LaporanPemasukanPengeluaran(),

  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.25,
          ),
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
          height: MediaQuery.of(context).size.height * 0.685,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(50),
            ),
            color: Color.fromARGB(255, 253, 247, 237),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(200),
            ),
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(
                      0.4), // Ubah nilai opacity sesuai dengan kebutuhan
                  BlendMode.darken),
              image: AssetImage("assets/images/br-cake3.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120,
              ),
              Text(
                "Hai Pandu,",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        offset: Offset(3.0, 3.0),
                        blurRadius: 8.0,
                        color: const Color.fromARGB(255, 27, 23, 23),
                      ),
                    ]),
              ),
              Text(
                "Generate Laporan Disini",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  shadows: [
                    Shadow(
                      offset: Offset(4.0, 4.0),
                      blurRadius: 8.0,
                      color: const Color.fromARGB(255, 27, 23, 23),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 200,
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    cardLaporan(context,
                        text: "Laporan Stok Bahan Baku",
                        icon: Icons.receipt_long,
                        nextTo: modalLaporan(context: context),
                        index: 0,
                        ),
                    cardLaporan(
                      context,
                      text: "Laporan Pengunaan Bahan Baku",
                      icon: Icons.receipt_long,
                      nextTo: modalLaporan(context: context),
                      index: 1,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    cardLaporan(context,
                        text: "Laporan Pemasukan Pengeluaran",
                        icon: Icons.receipt_long,
                        nextTo: modalLaporan(context: context),
                        index: 2,
                        )
                  ],
                ),
              ],
            ),
          ),
        ),
        isActiveOvl
            ? BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.935,
                  width: MediaQuery.of(context).size.width * 1,
                  color: Colors.black.withOpacity(0.4),
                  child: Center(
                    child: listLaporan[indexActive],
                  ),
                ),
              )
            : Container()
        //overlay
      ],
    );
  }

  Widget cardLaporan(context,
      {String text = "",
      IconData? icon,
      required Widget nextTo,
      int index = 0}) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 50),
          height: 200,
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(95, 0, 0, 0).withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 60, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    shadows: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 255, 255, 255)
                            .withOpacity(0.5), // Warna bayangan
                        spreadRadius: 5, // Penyebaran bayangan
                        blurRadius: 7, // Jumlah blur
                        offset: Offset(0, 3), // Posisi bayangan
                      ),
                    ],
                    color: AppColors.primaryColor,
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(120, 20),
                        backgroundColor: AppColors.primaryColor),
                    onPressed: () {
                      setState(() {
                        isActiveOvl = true;
                        indexActive = index;
                      });
                    },
                    child: Text("Genarate"))
              ],
            ),
          ),
        ),
        Positioned(
          left: 30,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              border: Border.all(width: 5, color: AppColors.backgroundColor),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              icon,
              size: 60,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget modalLaporan({required BuildContext context, data}) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black.withOpacity(0.3),
        ),
      ],
    );
  }
}
