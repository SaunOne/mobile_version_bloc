import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version_bloc/models/laporan/laporanPemasukanPengeluaran.dart';
import 'package:mobile_version_bloc/pages/mo-pages/bloc/bloc/laporan_pengeluaran_pemasukan_bloc.dart';
import 'package:mobile_version_bloc/utility/appColor.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

class LaporanPemasukanPengeluaran extends StatefulWidget {
  const LaporanPemasukanPengeluaran({super.key});

  @override
  State<LaporanPemasukanPengeluaran> createState() => _LaporanPemasukanPengeluaranState();
}

class _LaporanPemasukanPengeluaranState extends State<LaporanPemasukanPengeluaran> {
  DateTimeRange selectedDateRange = DateTimeRange(start: DateTime(2024, 6, 1), end: DateTime(2024, 6, 1));
  bool isLoading = false;
  bool isInit = false;
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;

  @override
  void initState() {
    super.initState();
  }

  void loadLaporan(LaporanPengeluaranPemasukanBloc laporan, int year, int month) {
    String formattedDate = DateFormat('yyyy-MM').format(DateTime(year, month));
    print("Loading report for: $formattedDate");
    laporan.add(GetLaporanPengeluaranPemasukan(formattedDate));
  }

  void handleLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final laporan = context.read<LaporanPengeluaranPemasukanBloc>();
    if (!isInit) {
      loadLaporan(laporan, selectedYear, selectedMonth);
      isInit = true;
    }

    return BlocBuilder<LaporanPengeluaranPemasukanBloc, LaporanPengeluaranPemasukanState>(
      builder: (context, state) {
        if (state is LaporanPengeluaranLoading) {
          print("Loading...");
          return Center(child: CircularProgressIndicator());
        } else if (state is LaporanPemasukanPengeluaranData) {
          ModelLaporanPemasukanPengeluaran data = state.dataLaporan;

          return Container(
            padding: EdgeInsets.all(16),
            height: 650,
            width: 380,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(top: 60),
            child: Column(
              children: [
                SizedBox(height: 10),
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/logo1.png"),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text("Jln. Centralpark No 10 Yogyakarta"),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Laporan Pemasukan Pengeluaran",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Text("Tahun ${data.tahun}"),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: double.infinity,
                  child: Text("Bulan ${data.bulan}"),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: double.infinity,
                  child: Text("Tanggal Cetak ${data.tanggalCetak}"),
                ),
                SizedBox(
                  height: 10,
                ),
                // Year and Month Picker
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownButton<int>(
                      value: selectedYear,
                      items: List.generate(6, (index) {
                        int year = DateTime.now().year - index;
                        return DropdownMenuItem<int>(
                          value: year,
                          child: Text(year.toString()),
                        );
                      }),
                      onChanged: (int? newYear) {
                        if (newYear != null) {
                          setState(() {
                            selectedYear = newYear;
                          });
                          loadLaporan(laporan, selectedYear, selectedMonth);
                        }
                      },
                    ),
                    DropdownButton<int>(
                      value: selectedMonth,
                      items: List.generate(12, (index) {
                        int month = index + 1;
                        return DropdownMenuItem<int>(
                          value: month,
                          child: Text(DateFormat.MMMM().format(DateTime(0, month))),
                        );
                      }),
                      onChanged: (int? newMonth) {
                        if (newMonth != null) {
                          setState(() {
                            selectedMonth = newMonth;
                          });
                          loadLaporan(laporan, selectedYear, selectedMonth);
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: Table(
                      columnWidths: {
                        0: FlexColumnWidth(1.5),
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
                                child: Text(""),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Text("Pemasukan"),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Text("Pengeluaran"),
                              ),
                            ),
                          ],
                        ),
                        ...data.data.map(
                          (e) => TableRow(
                            children: [
                              TableCell(
                                verticalAlignment: TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Text(e.nama),
                                ),
                              ),
                              TableCell(
                                verticalAlignment: TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Text("Rp${e.pemasukan.toString()}"),
                                ),
                              ),
                              TableCell(
                                verticalAlignment: TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Text("Rp${e.pengeluaran.toString()}"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(150, 20),
                        backgroundColor: AppColors.primaryColor,
                      ),
                      onPressed: () => _generatePdf(data),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.picture_as_pdf),
                          SizedBox(width: 5),
                          Text("Export PDF"),
                          SizedBox(width: 5),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (state is LaporanPemasukanPengeluaran) {
          return Center(
              child: Container(
                  color: Colors.red,
                  child: Text("Error: ${state.toString()}")));
        } else {
          return Container();
        }
      },
    );
  }

  Future<void> _generatePdf(ModelLaporanPemasukanPengeluaran data) async {
    final pdf = pw.Document();
    final font = pw.Font.ttf(await rootBundle.load('assets/fonts/Roboto-Regular.ttf'));
    final fontBold = pw.Font.ttf(await rootBundle.load('assets/fonts/Roboto-Bold.ttf'));

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "Atma Kitchen",
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, font: fontBold),
              ),
              pw.Text("Jl. Centralpark No. 10 Yogyakarta", style: pw.TextStyle(font: font)),
              pw.SizedBox(height: 10),
              pw.Text(
                "LAPORAN Pemasukkan Dan Pengeluaran",
                style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, font: fontBold),
              ),
              pw.SizedBox(height: 2),
              pw.Text("Tahun : ${data.tahun}", style: pw.TextStyle(font: font)),
              pw.SizedBox(height: 2),
              pw.Text("Bulan : ${data.bulan}", style: pw.TextStyle(font: font)),
              pw.SizedBox(height: 2),
              pw.Text(
                'Periode: ${DateFormat('dd MMMM yy').format(selectedDateRange.start)} - ${DateFormat('dd MMMM yy').format(selectedDateRange.end)}',
                style: pw.TextStyle(font: font),
              ),
              pw.SizedBox(height: 6),
              pw.Text("Tanggal cetak: ${data.tanggalCetak}", style: pw.TextStyle(font: font)),
              pw.SizedBox(height: 10),
              pw.Table.fromTextArray(
                headers: ["Nama", "Pemasukan", "Pengeluaran"],
                data: data.data.map((item) {
                  return [
                    item.nama,
                    "Rp${item.pemasukan.toString()}",
                    "Rp${item.pengeluaran.toString()}"
                  ];
                }).toList(),
                headerStyle: pw.TextStyle(font: fontBold),
                cellStyle: pw.TextStyle(font: font),
              ),
            ],
          );
        },
      ),
    );

    try {
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating PDF: $e')),
      );
    }
  }
}
