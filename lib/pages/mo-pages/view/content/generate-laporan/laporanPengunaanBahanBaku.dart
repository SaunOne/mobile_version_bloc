import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version_bloc/models/laporan/laporanBahanBaku.dart';
import 'package:mobile_version_bloc/pages/mo-pages/bloc/laporan_pengunaan_bahan/laporan_pemakaian_bloc.dart';
import 'package:mobile_version_bloc/pages/mo-pages/view/content/generate-laporan/laporanBahanBaku.dart';
import 'package:mobile_version_bloc/utility/appColor.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

class LaporanPengunaanBahanBaku extends StatefulWidget {
  const LaporanPengunaanBahanBaku({super.key});

  @override
  State<LaporanPengunaanBahanBaku> createState() =>
      _LaporanPengunaanBahanBakuState();
}

class _LaporanPengunaanBahanBakuState
    extends State<LaporanPengunaanBahanBaku> {
  DateTimeRange selectedDateRange =
      DateTimeRange(start: DateTime(2024, 5, 1), end: DateTime(2024, 6, 1));
  bool isLoading = false;
  bool isInit = false;

  @override
  void initState() {
    super.initState();
  }

  void loadLaporan(LaporanPemakaianBloc laporan, DateTimeRange range) {
    print("masuk");
    laporan.add(GetLaporanPemakaianBahanBakuEvent(
        range.start.toString(), range.end.toString()));
  }

  void handleLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      initialDateRange: selectedDateRange,
    );
    if (picked != null && picked != selectedDateRange) {
      setState(() {
        selectedDateRange = picked;
      });
      // Reload data based on the selected date range
      loadLaporan(context.read<LaporanPemakaianBloc>(), picked);
    }
  }

  Future<void> _generatePdf(DataStok data) async {
    final pdf = pw.Document();

    // Load the custom font
    final font =
        pw.Font.ttf(await rootBundle.load('assets/fonts/Roboto-Regular.ttf'));
    final fontBold =
        pw.Font.ttf(await rootBundle.load('assets/fonts/Roboto-Bold.ttf'));

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "Atma Kitchen",
                style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                    font: fontBold),
              ),
              pw.Text("Jl. Centralpark No. 10 Yogyakarta",
                  style: pw.TextStyle(font: font)),
              pw.SizedBox(height: 10),
              pw.Text(
                "LAPORAN Pemasukkan Dan Pengeluaran",
                style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                    font: fontBold),
              ),
              pw.SizedBox(height: 6),
              pw.Text(
                'Periode: ${DateFormat('dd MMMM yy').format(selectedDateRange.start)} - ${DateFormat('dd MMMM yy').format(selectedDateRange.end)}',
                style: pw.TextStyle(font: font),
              ),
              pw.Text("Tanggal cetak: ${data.tanggalCetak}",
                  style: pw.TextStyle(font: font)),
              pw.SizedBox(height: 10),
              pw.Table.fromTextArray(
                headers: ["Nama Bahan", "Satuan", "Stok"],
                data: data.data.map((item) {
                  return [
                    item.namaBahan,
                    item.satuan,
                    item.digunakan.toString()
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

  @override
  Widget build(BuildContext context) {
    final laporan = context.read<LaporanPemakaianBloc>();
    
    if (!isInit) {
      // print("masuk sini 2");
      loadLaporan(laporan, selectedDateRange);
      isInit = true;
    }
    return BlocBuilder<LaporanPemakaianBloc, LaporanPemakaianState>(
      builder: (context, state) {
        if (state is LaporanLoading) {
          print("masuk loading");
          return Center(child: CircularProgressIndicator());
        } else if (state is LaporanPemakaianBahanBakuData) {
          DataStok data = state.dataStok;

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
                    "Laporan Pengunaan Bahan Baku",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Text("Tanggal Cetak ${data.tanggalCetak}"),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => _selectDateRange(context),
                      child: Text(DateFormat('dd MMMM yy')
                          .format(selectedDateRange.start)),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.primaryColor)),
                    ),
                    Text('Sampai'),
                    ElevatedButton(
                      onPressed: () => _selectDateRange(context),
                      child: Text(DateFormat('dd MMMM yy')
                          .format(selectedDateRange.end)),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.primaryColor)),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
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
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(178, 117, 89, 79),
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(5)),
                          ),
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Text("Nama Bahan"),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Text("Satuan"),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Text("Digunakan"),
                              ),
                            ),
                          ],
                        ),
                        ...data.data.map(
                          (e) => TableRow(
                            children: [
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Text(e.namaBahan),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Text(e.satuan),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Text(e.digunakan.toString()),
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
        } else if (state is LaporanError) {
          return Center(
              child: Container(
                  color: Colors.red, child: Text("Error: ${state.message}")));
        } else {
          return Container();
        }
      },
    );
  }
}
