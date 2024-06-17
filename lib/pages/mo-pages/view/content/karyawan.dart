
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mobile_version_bloc/api/apiAbsensi.dart';
import 'package:mobile_version_bloc/api/apiPegawai.dart';
import 'package:mobile_version_bloc/models/absensi.dart';
import 'package:mobile_version_bloc/models/karyawan.dart';
import 'package:mobile_version_bloc/utility/appColor.dart';



class karyawan extends StatefulWidget {
  const karyawan({super.key});

  @override
  State<karyawan> createState() => _karyawanState();
}

class _karyawanState extends State<karyawan>
    with SingleTickerProviderStateMixin {
  TextEditingController karyawanController = TextEditingController();
  TextEditingController tanggalLahirController = TextEditingController();
  List<Karyawan> listKaryawan = [];
  List<Absensi> listAbsensi = [];
  Karyawan? karyawanSelected;
  bool isLoading = false;

  void handleData() {
    handleLoading();
    ApiKaryawan().fetchAll().then((value) {
      print("value : ${value.length}");
      listKaryawan = value;
      handleLoading();
    }).catchError((err) {
      handleLoading();
      print(err);
    });

    handleLoading();
    ApiAbsensi().fetchAll().then((value) {
      print("isi ${value.length}");
      listAbsensi = value;
      print("isi absen ${listAbsensi.length}");
      handleLoading();
    }).catchError((err) {
      print("isi ${err}");
      handleLoading();
    });
  }

  void handleDelete(id) {
    handleLoading();
    ApiAbsensi().destroy(id).then((value) {
      print("value : ${value}");
      handleLoading();
      listAbsensi.removeWhere((absensi) => absensi.id == id);
      AnimatedSnackBar.rectangle(
              'Nice', 'Anda Berhasil Delete Karyawan dengan id ${id}',
              type: AnimatedSnackBarType.success,
              brightness: Brightness.light,
              duration: Duration(seconds: 2))
          .show(
        context,
      );
    }).catchError((err) {
      AnimatedSnackBar.rectangle(
              'Gagal', 'Gagal Delete Karyawan dengan id ${id}',
              type: AnimatedSnackBarType.error,
              brightness: Brightness.light,
              duration: Duration(seconds: 2))
          .show(
        context,
      );
      print("err ${err}");
    });
  }

  void handleAbsen({id, tanggal}) {
    handleLoading();
    ApiAbsensi().store(id, tanggal).then((value) {
      print("value");

      handleLoading();
      AnimatedSnackBar.rectangle(
              'Selamat', 'Anda Berhasil Menambhakan absen dengan id ${id}',
              type: AnimatedSnackBarType.success,
              brightness: Brightness.light,
              duration: Duration(seconds: 2))
          .show(
        context,
      );
      listAbsensi.add(Absensi(
          id: id,
          tanggal: tanggal,
          karyawan: listKaryawan.firstWhere((element) => element.id == id)));
    }).catchError((err) {
      print("err : ${err}");
      AnimatedSnackBar.rectangle(
              'Gagal', 'Gagal Absen Karyawan dengan id ${id}',
              type: AnimatedSnackBarType.error,
              brightness: Brightness.light,
              duration: Duration(seconds: 2))
          .show(
        context,
      );
    });
  }

  void handleLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    tanggalLahirController.text =
        DateFormat('yyyy-MM-dd').format(DateTime.now());
    setState(() {
      handleData();
    });
    super.initState();
  }

  bool isAdd = false;
  bool isAddAbsen = false;
  TextEditingController searchController = TextEditingController();
  late final controller = SlidableController(this);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.25,
          ),
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
          height: MediaQuery.of(context).size.height * 0.68,
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
                bottomRight: Radius.circular(200)),
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(
                      0.4), // Ubah nilai opacity sesuai dengan kebutuhan
                  BlendMode.darken),
              image: AssetImage("assets/images/br-cake2.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          margin: EdgeInsets.only(top: 100),
          child: Text(
            "Daftar Karyawan Atma Kitchen",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
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
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_drop_down_outlined),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 120),
          padding: EdgeInsets.only(left: 20, right: 20, top: 100),
          child: Container(
            height: 590,
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        for (Karyawan k in listKaryawan) cardKaryawan(k),
                        SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        Positioned(
          bottom: 35,
          right: 25,
          child: MaterialButton(
            onPressed: () {
              setState(() {
                isAdd = true;
              });
            },
            child: Container(
              height: 60,
              width: 220,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(75),
                  border: Border.all(
                      color: AppColors.secondaryColor, width: 3)),
              child: Center(
                  child: Text(
                "Lihat Karyawan Bolos",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )),
            ),
          ),
        ),
        if (isAdd || isAddAbsen) overlay(context: context),
        if (isAdd)
          modalDaftarKaryawan(
            context: context,
          ),
        if (isAddAbsen) addAbsen(karyawanSelected!)
      ],
    );
  }

  Widget overlay({required BuildContext context, data}) {
    return MaterialButton(
      onPressed: () {
        setState(() {
          isAdd = false;
          isAddAbsen = false;
        });
      },
      padding: EdgeInsets.zero,
      child: Ink(
        height: MediaQuery.of(context).size.height * 0.95,
        width: MediaQuery.of(context).size.width,
        color: Colors.black.withOpacity(0.3),
        child: Container(),
      ),
    );
  }

  Widget modalAddAbsen() {
    return Container();
  }

  Widget modalDaftarKaryawan({required BuildContext context}) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 150),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: 380,
        height: 560,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Daftar Karyawan Yang Bolos",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    child: GestureDetector(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        tanggalLahirController.text =
                            '${date!.year}-${date.month}-${date.day}';
                      },
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: tanggalLahirController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Tanggal Lahir',
                            suffixIcon: IconButton(
                              onPressed: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                tanggalLahirController.text =
                                    '${date!.year}-${date.month}-${date.day}';
                              },
                              icon: Icon(Icons.date_range),
                            ),
                          ),
                          validator: (value) =>
                              value == '' ? 'Please select a birth date' : null,
                          onTap: () {
                            // Ini mencegah keyboard dari muncul saat menekan TextFormField
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              daftarAbsen(listAbsensi)
            ],
          ),
        ),
      ),
    );
  }

  Widget cardKaryawan(Karyawan karyawan) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(top: 15),
      child: Container(
        height: 100,
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
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/person1.png"),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${karyawan.nama_lengkap}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Gaji : Rp${karyawan.gaji}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [Text("Jabatan : "), Text(karyawan.jabatan)],
                    ),
                  ],
                ),
              ),
              Container(
                height: 100,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.primaryColor),
                child: MaterialButton(
                  color: AppColors.primaryColor,
                  onPressed: () {
                    setState(() {
                      isAddAbsen = true;
                      karyawanSelected = karyawan;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      Text(
                        "Absen",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget addAbsen(Karyawan karyawan) {
    return Stack(
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 200),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            width: 350,
            height: 400,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 80,
                      ),
                      Text(
                        "Input Absen Karyawan",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 150,
                              width: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/person1.png"),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              height: 150,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 60,
                                    child: Text(
                                      "Nama     : ",
                                      overflow: TextOverflow
                                          .visible, // Atau gunakan TextOverflow.clip jika ingin teks terpotong
                                      maxLines:
                                          null, // Untuk mengizinkan jumlah baris tak terbatas
                                    ),
                                  ),
                                  Text("Jabatan : "),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              height: 150,
                              width: 120,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 60,
                                    child: Text(
                                      karyawan.nama_lengkap,
                                      overflow: TextOverflow
                                          .visible, // Atau gunakan TextOverflow.clip jika ingin teks terpotong
                                      maxLines:
                                          null, // Untuk mengizinkan jumlah baris tak terbatas
                                    ),
                                  ),
                                  Text(
                                    karyawan.jabatan,
                                    overflow: TextOverflow
                                        .visible, // Atau gunakan TextOverflow.clip jika ingin teks terpotong
                                    maxLines:
                                        null, // Untuk mengizinkan jumlah baris tak terbatas
                                  ),
                                 
                                ],
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            tanggalLahirController.text =
                                '${date!.year}-${date.month}-${date.day}';
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: tanggalLahirController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 15.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'Tanggal Lahir',
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    final date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                    );
                                    tanggalLahirController.text =
                                        '${date!.year}-${date.month}-${date.day}';
                                  },
                                  icon: Icon(Icons.date_range),
                                ),
                              ),
                              validator: (value) => value == ''
                                  ? 'Please select a birth date'
                                  : null,
                              onTap: () {
                                // Ini mencegah keyboard dari muncul saat menekan TextFormField
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                setState(() {
                                  isAddAbsen = false;
                                });
                              },
                              child: Container(
                                width: 120,
                                padding: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                    color: AppColors.secondaryColor,
                                    border: Border.all(
                                      color: AppColors.primaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                            MaterialButton(
                              onPressed: () {
                                handleAbsen(
                                    tanggal: tanggalLahirController.text,
                                    id: karyawan.id);
                                isAddAbsen = false;
                              },
                              child: Container(
                                width: 120,
                                padding: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    border: Border.all(
                                      color: AppColors.secondaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    "Absen",
                                    style: TextStyle(
                                        color: AppColors.backgroundColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
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
        ),
        Container(
          height: 100,
          width: 100,
          margin: EdgeInsets.only(top: 170, left: 10),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.backgroundColor, width: 5),
              borderRadius: BorderRadius.circular(60),
              color: AppColors.primaryColor),
          child: Center(
            child: Icon(
              Icons.co_present,
              size: 50,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget daftarAbsen(listAbsensi) {
    print("length : ${listAbsensi.length}");
    return Container(
      height: 350,
      child: SingleChildScrollView(
        child: Table(
          columnWidths: {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
          },
          border: TableBorder.all(
            color: Colors.brown,
            borderRadius: BorderRadius.circular(5),
          ),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Color.fromARGB(178, 117, 89, 79),
                borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
              ),
              children: [
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text("Nama "),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text("Jabatan"),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text("Action"),
                  ),
                ),
              ],
            ),
            for (Absensi absensi in listAbsensi)
              TableRow(
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(
                        absensi.karyawan!.nama_lengkap,
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(absensi.karyawan!.jabatan),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: MaterialButton(
                        minWidth: 20, // Atur lebar minimum
                        height: 20,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {
                          handleDelete(absensi.id);
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5)),
                          child: FaIcon(
                            FontAwesomeIcons.trash,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }

  void doNothing(BuildContext context) {}
}
