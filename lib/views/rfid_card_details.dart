// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:warehouse_app/cubit/pallet_info/pallet_info_cubit.dart';
import 'package:warehouse_app/cubit/rfid_name/rfid_name_cubit.dart';
import 'package:warehouse_app/cubit/rfid_status_cubit/rfid_status_cubit.dart';
import 'package:warehouse_app/repository/pallet_info_repo/pallet_info_repo_impl.dart';
import 'package:warehouse_app/repository/rfid_name_repo/rfid_name_repo_impl.dart';
import 'package:warehouse_app/repository/rfid_status_repo/rfid_status_repo_impl.dart';
import 'package:warehouse_app/views/logout_widget.dart';
import 'package:warehouse_app/views/roll_details.dart';

class RfidCardDetails extends StatelessWidget {
  const RfidCardDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("RFID Card Details"),
          actions: [
            // PopUpMenu(
            //   text1: 'RFID card details',
            //   text2: 'Create issuance',
            //   value1: 3,
            //   value2: 2,
            // )
            LogoutWidget()
          ],
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => RfidStatusCubit(RfidStatusRepoImpl()),
            ),
            BlocProvider(
              create: (context) => RfidNameCubit(RfidNameRepoImpl()),
            ),
            BlocProvider(
              create: (context) => PalletInfoCubit(PalletInfoRepoImpl()),
            )
          ],
          child: RfidCardDetailsScreen(),
        ));
  }
}

class RfidCardDetailsScreen extends StatefulWidget {
  const RfidCardDetailsScreen({super.key});

  @override
  State<RfidCardDetailsScreen> createState() => _RfidCardDetailsScreenState();
}

class _RfidCardDetailsScreenState extends State<RfidCardDetailsScreen> {
  var result;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                ElevatedButton(
                    onPressed: () async {
                      var res = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const SimpleBarcodeScannerPage(),
                          ));
                      setState(() {
                        result = res;
                        print(result);
                        // context.read<RfidStatusCubit>().getStatusData(result);
                        context
                            .read<RfidNameCubit>()
                            .getNameData(result.toString());
                      });
                    },
                    child: Text("Scan RFID to see details")),
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      "RFID card No: $result ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ))
              ],
            ),
          ),

          BlocConsumer<RfidNameCubit, RfidNameState>(
            listener: (context, state) {
              if (state is RfidNameLoaded) {
                print("rfid_name $state");
                if (state.rfidName.rfidName == "PALLET") {
                  Center(child: Text("Pallet ID: ${state.rfidName.rfid}"));
                  context
                      .read<PalletInfoCubit>()
                      .getPalletInfo(state.rfidName.rfid);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RolLDetails(rfid: state.rfidName.rfid),
                    ),
                  );
                }
              }
            },
            builder: (context, state) {
              if (state is RfidNameLoaded) {
                print("rfid_name $state");

                return Container();
              } else if (state is RfidNameError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
          BlocConsumer<PalletInfoCubit, PalletInfoState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is PalletInfoLoaded) {
                print(state);
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      DataTable(
                          columnSpacing:
                              MediaQuery.of(context).size.width * 0.12,
                          columns: [
                            DataColumn(
                              label: Expanded(child: Text('Bin')),
                            ),
                            DataColumn(
                              label: Expanded(child: Text('Roll No.')),
                            ),
                            DataColumn(
                              label: Expanded(child: Text('Factory Roll')),
                            ),
                            DataColumn(
                              label: Expanded(child: Text('Roll Length')),
                            ),
                          ],
                          rows: [
                            for (var i in state.palletInfo.rollList)
                              DataRow(
                                  onLongPress: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RolLDetails(rfid: i.rollNo),
                                      ),
                                    );
                                  },
                                  cells: [
                                    DataCell(Text("${i.bin}")),
                                    DataCell(Text("${i.rollNo}")),
                                    DataCell(Text("${i.factoryRoll}")),
                                    DataCell(Text("${i.rollLength}")),
                                  ]),
                            // DataRow(cells: [
                            //   DataCell(Text("2")),
                            //   DataCell(Text("John")),
                            //   DataCell(Text("Anderson")),
                            //   DataCell(Text("24")),
                            // ]),
                          ]),
                      Container(
                        padding: EdgeInsets.only(
                            // left: MediaQuery.of(context).size.width * 0.27,
                            top: 20),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                "Number of Rolls:  ${state.palletInfo.rollList.length}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.2,
                                  top: 20),
                              child: Text(
                                "Total Length:  ${state.palletInfo.total?.totalLength}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
          // StatusRowTextWidget(
          //   text: "Status: ",
          // ),
          BlocConsumer<RfidStatusCubit, RfidStatusState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is RfidStatusLoaded) {
                return Column(
                  children: [
                    StatusRowTextWidget(
                      text1: "Status:          ",
                      text2: state.rfidStatus.status,
                    ),
                    StatusRowTextWidget(
                      text1: "Buyer:           ",
                      text2: state.rfidStatus.data?.buyer,
                    ),
                    StatusRowTextWidget(
                      text1: "Style:             ",
                      text2: state.rfidStatus.data?.style,
                    ),
                    StatusRowTextWidget(
                      text1: "Season:         ",
                      text2: state.rfidStatus.data?.season,
                    ),
                    StatusRowTextWidget(
                      text1: "Color:             ",
                      text2: state.rfidStatus.data?.color,
                    ),
                    StatusRowTextWidget(
                      text1: "Factory Roll: ",
                      text2: state.rfidStatus.data?.factoryRoll,
                    ),
                    StatusRowTextWidget(
                      text1: "Roll Length:  ",
                      text2:
                          "${state.rfidStatus.data?.rollLength}  ${state.rfidStatus.data?.uom}",
                    ),
                    StatusRowTextWidget(
                      text1: "Roll Width:     ",
                      text2:
                          "${state.rfidStatus.data?.rollWidth} ${state.rfidStatus.data?.uom}",
                    ),
                    StatusRowTextWidget(
                      text1: "Supplier Roll: ",
                      text2: state.rfidStatus.data?.supplierRoll,
                    ),
                    StatusRowTextWidget(
                      text1: "RFID:               ",
                      text2: state.rfidStatus.data?.rfid,
                    )
                  ],
                );
              } else {
                return Container();
              }
            },
          )
        ],
      ),
    );
  }
}

class StatusRowTextWidget extends StatelessWidget {
  String text1;
  String? text2;
  StatusRowTextWidget({
    required this.text1,
    required this.text2,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 25, top: 15),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                text1,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                text2.toString(),
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
