import 'package:flutter/material.dart';
import 'package:mobile_version_bloc/api/apiUser.dart';
import 'package:mobile_version_bloc/api/apiWithdraw.dart';
import 'package:mobile_version_bloc/models/user.dart';
import 'package:mobile_version_bloc/models/withdraw.dart';
import 'package:mobile_version_bloc/utility/appColor.dart';
import 'package:mobile_version_bloc/utility/font_constants.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  User? user;
  bool isLoading = false;
  List<Withdraw> listWithdraw = [];

  void handleWallet() {
    loading(true);
    ApiWithdraw().getWithdrawByUser().then((value) {
      print('Withdraws fetched successfully');
      setState(() {
        print("data withdrwa : ${value}");
        listWithdraw = value;
      });
      loading(false);
    }).catchError((err) {
      loading(false);
      print('Error fetching withdraws: $err');
    });
  }

  void handlestoreWithDraw(int jumlah, String namaBank, String noRek) {
  loading(true);
  ApiWithdraw().storeWithDraw(jumlah, namaBank, noRek).then((value) {
    print('Withdrawal initiation successful');
    setState(() {
      handleWallet();
    });
    loading(false);
  }).catchError((err) {
    loading(false);
    print('Error initiating withdrawal: $err');
  });
}

  void loading(action) {
    setState(() {
      isLoading = action;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handleWallet();
  }

  void showWithdrawModal(BuildContext context) {
    TextEditingController amountController = TextEditingController();
    TextEditingController accountNumberController = TextEditingController();
    TextEditingController bankNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Withdraw'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: accountNumberController,
                decoration: InputDecoration(labelText: 'Account Number'),
              ),
              TextField(
                controller: bankNameController,
                decoration: InputDecoration(labelText: 'Bank Name'),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () {
                handlestoreWithDraw(int.parse(amountController.text), accountNumberController.text, bankNameController.text);
                // handle the withdraw submission here
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.4), BlendMode.darken),
                        image: AssetImage('assets/images/br-cake3.png'),
                        fit: BoxFit.cover),
                  ),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 30),
                          child: Text(
                            "Atma Kitchen Wallet",
                            style: FontConstants.heading2(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  height: 150,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.account_balance_wallet,
                              size: 100, color: AppColors.primaryColor),
                          SizedBox(
                            width: 30,
                          ),
                          Column(
                            children: [
                              Text(
                                'Saldo: 0',
                                style: FontConstants.heading2(),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  showWithdrawModal(context);
                                },
                                child: Text('Withdraw'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  height: 450,
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
                  child: Column(
                    children: [
                      Text(
                        'Withdraw History',
                        style: FontConstants.heading2(),
                      ),
                      SizedBox(height: 10),
                      isLoading? Center(child: CircularProgressIndicator(),) :
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            child: DataTable(
                              columns: [
                                DataColumn(label: Text('Id')),
                                DataColumn(label: Text('Jumalh')),
                                DataColumn(label: Text('Status')),
                                DataColumn(label: Text('Tanggal')),
                              ],
                              rows: List<DataRow>.generate(
                                listWithdraw.length,
                                (index) => DataRow(
                                  cells: [
                                    DataCell(Text(listWithdraw[index].idWithdraw.toString())),
                                    DataCell(Text(listWithdraw[index].jumlah.toString())),
                                    DataCell(Text(listWithdraw[index].status)),
                                    DataCell(Text(listWithdraw[index].tanggal)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
