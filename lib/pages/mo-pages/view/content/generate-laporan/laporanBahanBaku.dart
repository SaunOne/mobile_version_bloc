import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version_bloc/models/laporan/laporanBahanBaku.dart';
import 'package:mobile_version_bloc/pages/auth-pages/bloc/login_bloc/login_bloc.dart';
import 'package:mobile_version_bloc/pages/mo-pages/bloc/laporan/laporan_bloc.dart';
import 'package:mobile_version_bloc/utility/appColor.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class LaporanBahanBaku extends StatefulWidget {
  const LaporanBahanBaku({super.key});

  @override
  State<LaporanBahanBaku> createState() => _LaporanBahanBakuState();
}

class _LaporanBahanBakuState extends State<LaporanBahanBaku> {
  void loadLaporan(LaporanBloc laporan) {
    laporan.add(GetLaporanStokBahanBaku());
  }

  Future<void> _generatePdf(DataStok data) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "Atma Kitchen",
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text("Jl. Centralpark No. 10 Yogyakarta"),
              pw.SizedBox(height: 10),
              pw.Text(
                "LAPORAN Stok Bahan Baku",
                style:
                    pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text("Tanggal cetak: ${data.tanggalCetak}"),
              pw.SizedBox(height: 10),
              pw.Table.fromTextArray(
                headers: ["Nama Bahan", "Satuan", "Stok"],
                data: data.data.map((item) {
                  return [
                    item.namaBahan,
                    item.satuan,
                    item.jumlahStok.toString()
                  ];
                }).toList(),
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
    final laporan = context.read<LaporanBloc>();
    loadLaporan(laporan);
    return BlocBuilder<LaporanBloc, LaporanState>(
      builder: (context, state) {
        if (state is LaporanLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LaporanBahanBakuData) {
          DataStok data = state.dataStok;
          return Container(
            height: 600,
            width: 380,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              child: Column(
                children: [
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/logo1.png"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Jln. Centralpark No 10 Yogyakarta",
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Laporan Bahan Baku",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text("Tanggal Cetak ${data.tanggalCetak}"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(5)),
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
                                  child: Text("Stok"),
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
                                    child: Text(e.jumlahStok.toString()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),  
                  ),
                  SizedBox(
                    height: 50,
                  ),
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
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
