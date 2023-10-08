import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:warehouse_app/cubit/insert_issuance_list/insert_issuance_list_cubit.dart';
import 'package:warehouse_app/cubit/inspection_list/inspection_list_cubit.dart';
import 'package:warehouse_app/models/inspection_list/inspection_list.dart';
import 'package:warehouse_app/models/login_object.dart';
import 'package:warehouse_app/repository/insert_inspection_repo/insert_inspection_repo_impl.dart';
import 'package:warehouse_app/repository/inspection_list_repo/inspection_list_repo_impl.dart';
import 'package:warehouse_app/repository/inspection_list_repo/inspection_list_repository.dart';
import 'package:warehouse_app/repository/rfid_for_inspection_repo/rfid_for_inspection_repo_impl.dart';
import 'package:warehouse_app/views/alert_dialog.dart';
import 'package:warehouse_app/views/login_screen.dart';

import '../cubit/rfid_for_inspection/rfid_for_inspection_cubit.dart';
import 'logout_widget.dart';

class CreateIssuance extends StatelessWidget {
  LoginObject? loginObject;
  CreateIssuance({super.key, this.loginObject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Issuance"),
        actions: [
          // PopUpMenu(
          //   text1: 'RFID card details',
          //   text2: 'Create issuance',
          //   value1: 1,
          //   value2: 3,
          // )
          LogoutWidget()
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                RfidForInspectionCubit(RfidForInspectionRepoImpl()),
          ),
          BlocProvider(
            create: (context) => InspectionListCubit(InspectionListRepoImpl()),
          ),
          BlocProvider(
            create: (context) =>
                InsertIssuanceListCubit(InsertInspectionRepoImpl()),
            child: Container(),
          )
        ],
        child: CreateIssuanceScreen(loginObject: loginObject),
      ),
    );
  }
}

class CreateIssuanceScreen extends StatefulWidget {
  LoginObject? loginObject;
  CreateIssuanceScreen({super.key, this.loginObject});

  @override
  State<CreateIssuanceScreen> createState() =>
      _CreateIssuanceScreenState(this.loginObject);
}

class _CreateIssuanceScreenState extends State<CreateIssuanceScreen> {
  LoginObject? loginObject;
  var result;
  List<String> selectedValues = [];
  // bool isChecked = false;
  bool isChecked = true;
  List<bool> isCheckedList = [];
  List<String> inspectionEntryList = [];
  int issuanceListLength = 0;

  _CreateIssuanceScreenState(this.loginObject);
  @override
  void initState() {
    print("emp ${loginObject?.employeeNumber}");
    // context.read<InspectionListCubit>().getInspectionData("1645");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<InspectionListLoaded> inspectionList;

    return Container(
      padding: EdgeInsets.only(right: 10, top: 10, bottom: 10),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () async {
              var res = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SimpleBarcodeScannerPage(),
                  ));
              setState(() {
                result = res;
                context.read<InspectionListCubit>().getInspectionData(res);
              });
            },
            child: Text("Scan RFID to add for issuance"),
          ),
          BlocConsumer<InspectionListCubit, InspectionListState>(
            listener: (context, state) {
              if (state is InspectionListLoaded) {
                // Initialize isCheckedList with the appropriate length when the data is loaded
                isCheckedList = List.filled(state.inspectionList.length, false);
              }
            },
            builder: (context, state) {
              if (state is InspectionListLoaded) {
                print("object");
                return Container(
                  padding: EdgeInsets.only(left: 15),
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ListView.builder(
                    itemCount: state.inspectionList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CheckboxListTile(
                          title: Card(
                            elevation: 0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                issuanceWidgetText(
                                  text: "Rfid",
                                  value: state.inspectionList[index].rfid!,
                                ),
                                issuanceWidgetText(
                                  text: "EPC Number",
                                  value: state.inspectionList[index].rfidEpc!,
                                ),
                                issuanceWidgetText(
                                  text: "Factory Roll",
                                  value:
                                      state.inspectionList[index].factoryRoll!,
                                ),
                              ],
                            ),
                          ),
                          value: isCheckedList[index],
                          onChanged: (bool? newValue) {
                            setState(() {
                              isCheckedList[index] = newValue ?? false;
                              if (isCheckedList[index]) {
                                print(
                                    "Rfid: ${state.inspectionList[index].rfidEpc}");
                                inspectionEntryList
                                    .add(state.inspectionList[index].rfidEpc!);
                              } else {
                                print(
                                    "Rfid removed : ${state.inspectionList[index].rfid}");
                                inspectionEntryList.removeAt(
                                    inspectionEntryList.indexOf(
                                        state.inspectionList[index].rfidEpc!));
                              }
                            });
                          });
                    },
                  ),
                );
              } else if (state is InspectionListLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                );
              } else {
                return Container();
              }
            },
          ),
          Spacer(),
          ElevatedButton(
              onPressed: () {
                print(
                    "${inspectionEntryList[0]}, ${loginObject?.employeeNumber}");
                issuanceListLength = inspectionEntryList.length;
                if (issuanceListLength <= 0) {
                  alertDialog(context, "Warning",
                      "Please select some roll before submit");
                } else {
                  context.read<InsertIssuanceListCubit>().getInspectionData(
                      inspectionEntryList[issuanceListLength - 1],
                      loginObject?.employeeNumber ?? "123456");
                }
              },
              child: Text("Submit")),
          BlocConsumer<InsertIssuanceListCubit, InsertIssuanceListState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is InsertIssuanceListLoaded) {
                issuanceListLength--;
                if (issuanceListLength > 0) {
                  print(issuanceListLength);
                  context.read<InsertIssuanceListCubit>().getInspectionData(
                      inspectionEntryList[issuanceListLength - 1],
                      loginObject?.employeeNumber ?? "123456");
                } else {
                  inspectionEntryList.clear();
                  context.read<InspectionListCubit>().getInspectionData(result);
                }
                return Container();
              } else {
                return Container();
              }
            },
          )
        ],
      ),
    );
  }

  Container inspectionListWidget(
      BuildContext context, InspectionListLoaded state, bool isChecked) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width * 0.9,
      child: ListView.builder(
          itemCount: state.inspectionList.length,
          itemBuilder: (BuildContext context, int index) {
            return CheckboxListTile(
                title: Text("${state.inspectionList[index].rfid}"),
                value: isChecked,
                onChanged: (bool? newValue) {
                  // setState(() {
                  isChecked = newValue!;
                  // });
                });
          }),
    );
  }

  Container InspectionListWidget(BuildContext context,
      RfidForInspectionLoaded? state, InspectionListLoaded? state1) {
    print("xx_inspection");
    return Container(
      height: MediaQuery.of(context).size.height * 0.72,
      child: ListView.builder(
          itemCount: state != null
              ? state.rfidForInspection.data?.length
              : state1 != null
                  ? state1.inspectionList.length
                  : 0,
          itemBuilder: (BuildContext context, int index) {
            bool isChecked = false; // Add a variable to track checkbox state

            return CheckboxListTile(
              title: Card(
                elevation: 5, // Adjust the shadow elevation as needed
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                            "RFID: ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            state != null
                                ? state.rfidForInspection.data![index].rfid
                                    .toString()
                                : state1 != null
                                    ? state1.inspectionList[index].rfid!
                                    : "0",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Factory Roll ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            state != null
                                ? state
                                    .rfidForInspection.data![index].factoryRoll
                                    .toString()
                                : state1 != null
                                    ? state1.inspectionList[index].rfidEpc!
                                    : "0",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Supplier Roll ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            state != null
                                ? state
                                    .rfidForInspection.data![index].supplierRoll
                                    .toString()
                                : state1 != null
                                    ? state1.inspectionList[index].factoryRoll!
                                    : "0",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              value: isChecked,
              onChanged: (bool? newValue) {
                setState(() {
                  isChecked = newValue!;
                });
              },
            );
          }),
    );
  }
}

class issuanceWidgetText extends StatelessWidget {
  String text;
  String value;
  issuanceWidgetText({
    required this.text,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$text:  ",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          "$value",
          style: TextStyle(fontSize: 17),
        )
      ],
    );
  }
}
