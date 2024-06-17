
import 'package:flutter/material.dart';
import 'package:mobile_version_bloc/models/produk.dart';
import 'package:mobile_version_bloc/repository/apiProduk.dart';
import 'package:mobile_version_bloc/utility/appColor.dart';

class ListProduk extends StatefulWidget {
  const ListProduk({super.key});

  @override
  State<ListProduk> createState() => _ListProdukState();
}

class _ListProdukState extends State<ListProduk> {
  TextEditingController searchController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  bool isLoading = false;
  List<Produk> listProduk = [];
  List<Produk> listProdukActive = [];

  @override
  void initState() {
    super.initState();
    handleLoading(true);
    print("is loadin $isLoading");
    ApiProduk().fetchAll().then((value) {
      listProduk = value;
      listProdukActive = value;
      print("isi : ${listProduk.length}");
      handleLoading(false);
    }).catchError((err) {
      print("error" + err);
    });

    print("is loadin $isLoading");
    // TODO: implement initState
  }

  void loadProdukByTanggal(String tanggal) {
    handleLoading(true);
    setState(() {
      ApiProduk().fetchAllByTanggal(tanggal).then((value) {
        listProdukActive = value;
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
          height: 800,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120,
              ),
              Text(
                "Produk Cake Atam Kitchen",
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
        //isi
        isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 250),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Wrap(
                    spacing: 10,
                    children: [
                      for (Produk produk in listProdukActive)
                        Container(
                          height: 250,
                          width: 180,
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/cake1.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    produk.nama_produk,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Rp ',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal,
                                            color: Color.fromARGB(
                                                255, 94, 34, 13)),
                                      ),
                                      Text(
                                        "${produk.harga}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "ready ${produk.readyStok!.jumlah_stok}",
                                    style: const TextStyle(
                                        color: const Color.fromARGB(
                                            255, 202, 54, 0)),
                                  ),
                                  Text(
                                    "limit ${produk.limitOrder!.jumlahSisa}",
                                    style: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 202, 54, 0),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
        Container(
          margin: EdgeInsets.only(top: 180),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 40,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Form(
                    child: TextFormField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon: Icon(Icons.search),
                        labelText: "Search",
                        disabledBorder: UnderlineInputBorder(),
                        border: InputBorder.none,
                        fillColor: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  margin: EdgeInsets.only(bottom: 5),
                  child: GestureDetector(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        print("tanggal : " + tanggalController.text);
                        loadProdukByTanggal(tanggalController.text);
                        tanggalController.text =
                            '${date.year}-${date.month}-${date.day}';
                      }
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: tanggalController,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          border: InputBorder.none, // Remove the outline border
                          labelText: '',
                          suffixIcon: IconButton(
                            onPressed: () async {
                              print("masuk");
                              final date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );

                              if (date != null) {
                                tanggalController.text =
                                    '${date.year}-${date.month}-${date.day}';
                                loadProdukByTanggal(tanggalController.text);
                              }
                            },
                            icon: Icon(Icons.date_range),
                          ),
                        ),
                        validator: (value) =>
                            value == '' ? 'Please select a birth date' : null,
                        onTap: () {
                          print('ketriger');
                          // Prevents keyboard from appearing when tapping on TextFormField
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
