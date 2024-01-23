// ignore_for_file: must_be_immutable

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:torch_light/torch_light.dart';
import 'package:warehouse_app/cubit/inventory_cubit/inventory_cubit.dart';
import 'package:warehouse_app/cubit/roll_data_cubit/roll_data_cubit.dart';
import 'package:warehouse_app/models/inventory.dart';
import 'package:warehouse_app/models/login_object.dart';
import 'package:warehouse_app/models/roll_data.dart';
import 'package:warehouse_app/repository/inventory_repository/inventory_repo_impl.dart';
import 'package:warehouse_app/repository/roll_data_repository/roll_data_repo_impl.dart';
import 'package:warehouse_app/repository/update_rfid/update_rfid_repo_impl.dart';
import 'package:warehouse_app/views/alert_dialog.dart';
import 'package:warehouse_app/views/invoice_status_data.dart';
import 'package:warehouse_app/views/widget/three_dot_menu_widget.dart';

import '../cubit/update_rfid/update_rfid_cubit.dart';
import 'logout_dialog.dart';

TextEditingController? searchedText;

class HomePage extends StatelessWidget {
  String? qrData;
  String? headerId;
  LoginObject? loginObject;
  String? rfid;
  String? invoiceNo;
  String showall;
  bool visible;

  HomePage(
      {super.key,
      this.qrData,
      this.headerId,
      this.loginObject,
      this.rfid,
      this.invoiceNo,
      required this.showall,
      required this.visible});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              "ID: ${loginObject!.employeeNumber} || Name: ${loginObject!.employeeName}"),
          actions: <Widget>[
            PopUpMenu(
              text1: 'RFID card details',
              text2: 'Invoice status',
              text3: 'Search roll location',
              value1: 1,
              value2: 2,
              loginObject: loginObject,
            ),
            // LogoutWidget(),
          ],
          automaticallyImplyLeading: false,
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => (InventoryCubit(
                InventoryDataRepoImpl(),
              )),
            ),
            BlocProvider(
              create: (context) => (RollDataCubit(
                RollDataRepoImpl(),
              )),
            ),
          ],
          child: HomePageView(
            qrData: this.qrData,
            headerId: this.headerId,
            loginObject: this.loginObject,
            rfid: this.rfid,
            invoiceNo: this.invoiceNo,
            showAll: showall,
            visible: visible,
          ),
        ));
  }
}

class HomePageView extends StatefulWidget {
  LoginObject? loginObject;
  // List<JobData> jobData = <JobData>[];
  String? rfid;
  String? qrData;
  String? headerId;
  String? invoiceNo;

  String showAll;
  bool visible;

  HomePageView(
      {super.key,
      this.qrData,
      this.headerId,
      this.loginObject,
      this.rfid,
      this.invoiceNo,
      required this.showAll,
      required this.visible});

  @override
  State<HomePageView> createState() => _HomePageViewState(
      this.qrData,
      this.headerId,
      this.loginObject,
      this.rfid,
      this.invoiceNo,
      this.showAll,
      this.visible);
}

class _HomePageViewState extends State<HomePageView> {
  String? qrData;
  String? headerId;
  String? invoiceNo;
  String? detailsId;
  LoginObject? loginObject;
  String? rfid;
  String showAll;
  bool visible;

  List<Inventory> inventory = <Inventory>[];
  List<String> inventoryList = [];
  List<RollData> rollData = <RollData>[];
  List<String> rollList = <String>[];
  final controller = TextEditingController();
  ValueNotifier<String> noOfPackages = ValueNotifier("");
  int selectedSearchOption = 1;

  bool buttonPressed = false;

  _HomePageViewState(this.qrData, this.headerId, this.loginObject, this.rfid,
      this.invoiceNo, this.showAll, this.visible);
  @override
  void initState() {
    context.read<InventoryCubit>().getInventoryData("342");

    // if (headerId != null) {
    //   context.read<RollDataCubit>().getRollData(headerId!, "0");
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(loginObject);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String _selectedItem = "";

    // return BlocConsumer<InventoryCubit, InventoryState>(
    //   listener: (context, state) {},
    //   builder: (context, state) {
    //     if (state is InventoryLoaded) {
    //       print(state.inventory);
    //     }
    //     return Container();
    //   },
    // );
    Future<bool> onWillPop() async {
      return (await logoutDialog(context)) ?? false;
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlocConsumer<InventoryCubit, InventoryState>(
                        builder: (context, state) {
                          if (state is InventoryInitial) {
                            return Container(
                              width: width * 0.55,
                              margin: EdgeInsets.only(top: 20, bottom: 20),
                              child: DropdownSearch<String>(
                                  popupProps: const PopupProps.menu(
                                    showSelectedItems: true,
                                    // disabledItemFn: (String s) => s.startsWith('I'),

                                    showSearchBox: true,
                                  ),
                                  selectedItem: invoiceNo ?? "",
                                  // clearButtonProps: ClearButtonProps(isVisible: true),

                                  items: inventoryList,
                                  dropdownDecoratorProps:
                                      const DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                        labelText: "Select Inventory Data",
                                        labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)
                                        // hintText: "country in menu mode",
                                        ),
                                  ),
                                  // onSaved: (newValue) => print("newvALUE:$newValue"),

                                  // onSaved: jobList.value[0],

                                  onChanged: (String? newValue) {}),
                            );
                          } else if (state is InventoryLoading) {
                            return Container();
                          } else if (state is InventoryLoaded) {
                            print("here");

                            // if(state.inventory)
                            inventoryList.clear();
                            // jobList.value.add("Select a Job");
                            inventoryList
                                .addAll(mapInventoryData(state.inventory));
                            inventory = state.inventory;
                            _selectedItem = "";
                            // print("JobList:" + jobList.toString());
                            // dropDown(width);
                            return Container(
                              width: width * 0.55,
                              margin: EdgeInsets.only(top: 20, bottom: 20),
                              child: DropdownSearch<String>(
                                  popupProps: const PopupProps.menu(
                                    showSelectedItems: true,

                                    // disabledItemFn: (String s) => s.startsWith('I'),

                                    showSearchBox: true,
                                  ),
                                  selectedItem: invoiceNo ?? _selectedItem,

                                  // clearButtonProps: ClearButtonProps(isVisible: true),
                                  items: inventoryList,
                                  dropdownDecoratorProps:
                                      const DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                        labelText: "Select Inventory Data",
                                        labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)
                                        // hintText: "country in menu mode",
                                        ),
                                  ),
                                  // onSaved: (newValue) => print("newvALUE:$newValue"),

                                  // onSaved: jobList.value[0],

                                  onChanged: (String? newValue) {
                                    // context.read<JobCubit>().getJobData();
                                    // selectedItem.value = newValue ?? "0";
                                    // selectedItem.value;
                                    setState(() {
                                      print(
                                          "InventoryID:${state.inventory[inventoryList.indexOf(newValue!)].headerId!}");

                                      selectedSearchOption = 1;
                                      headerId = state
                                          .inventory[
                                              inventoryList.indexOf(newValue)]
                                          .headerId!;
                                      invoiceNo = newValue;
                                      context.read<RollDataCubit>().getRollData(
                                          state
                                              .inventory[inventoryList
                                                  .indexOf(newValue)]
                                              .headerId!,
                                          "0");

                                      visible = true;
                                    });
                                    //newValue = "";
                                  }),
                            );
                          } else {
                            return Container();
                          }
                        },
                        listener: (context, state) {}),
                    Visibility(
                      visible: headerId != null ? true : false,
                      child: ElevatedButton(
                          onPressed: () {
                            if (headerId != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InvoiceStatusData(
                                    headerId: headerId,
                                    loginObject: loginObject,
                                  ),
                                ),
                              );
                            } else {
                              alertDialog(context, "Warning",
                                  "Please Select the invoice number first!");
                            }
                          },
                          child: Text("Check Status")),
                    )
                  ],
                ),
                Visibility(
                  visible: visible,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 1,
                                groupValue: selectedSearchOption,
                                onChanged: (value) {
                                  setState(() {
                                    selectedSearchOption = value!;
                                  });
                                },
                              ),
                              Text("Search by supplier roll"),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 2,
                                groupValue: selectedSearchOption,
                                onChanged: (value) {
                                  setState(() {
                                    selectedSearchOption = value!;
                                  });
                                },
                              ),
                              Text("Search by factory roll"),
                            ],
                          ),
                        ],
                      ),
                      Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 20, bottom: 10),
                          child: ElevatedButton(
                              onPressed: () {
                                if (showAll == "Show All") {
                                  context
                                      .read<RollDataCubit>()
                                      .getRollData(headerId ?? "123", "1");
                                } else {
                                  context
                                      .read<RollDataCubit>()
                                      .getRollData(headerId ?? "123", "0");
                                }
                                setState(() {
                                  if (showAll == "Show All") {
                                    showAll = "Hide";
                                  } else {
                                    showAll = "Show All";
                                  }
                                });
                              },
                              child: Text(showAll))),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Visibility(
                      visible: selectedSearchOption == 1,
                      child: searchacbleRollList(
                        value: selectedSearchOption,
                        height: height,
                        width: width,
                        loginObject: loginObject,
                        qrData: qrData,
                        headerId: headerId,
                        rfid: rfid,
                        invoiceNo: invoiceNo,
                        rollData: rollData,
                        text: "Search Supplier Roll",
                      ),
                    ),
                    Visibility(
                      visible: selectedSearchOption == 2,
                      child: searchacbleRollList(
                        value: selectedSearchOption,
                        height: height,
                        width: width,
                        loginObject: loginObject,
                        qrData: qrData,
                        headerId: headerId,
                        rfid: rfid,
                        invoiceNo: invoiceNo,
                        rollData: rollData,
                        text: "Search Factory Roll",
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class searchacbleRollList extends StatelessWidget {
  searchacbleRollList({
    super.key,
    required this.height,
    required this.width,
    required this.loginObject,
    required this.qrData,
    required this.headerId,
    required this.rfid,
    required this.invoiceNo,
    required this.rollData,
    required this.text,
    required this.value,
  });

  final double height;
  final double width;
  final LoginObject? loginObject;
  final String? qrData;
  final String? headerId;
  final String? rfid;
  final String? invoiceNo;
  final String text;
  final int value;
  List<RollData> rollData;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RollDataCubit, RollDataState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is RollDataLoaded) {
          rollData.clear();
          rollData = state.rolldata;
          print(rollData);

          return Container(
            height: height * 0.7,
            width: width * 0.9,
            child: SearchableList(
              searchTextController: searchedText,
              builder: (RollData rollData) => BlocProvider(
                create: (context) => UpdateRfidCubit(UpdateDataRepoImpl()),
                child: RollItem(
                  value: value,
                  loginObject: loginObject,
                  rollData: rollData,
                  qrData: qrData,
                  headerId: headerId,
                  rfid: rfid,
                  invoiceNo: invoiceNo,
                ),
              ),
              asyncListCallback: () async {
                await Future.delayed(
                  const Duration(
                    milliseconds: 1,
                  ),
                );
                return rollData;
              },
              asyncListFilter: (q, list) {
                if (value == 1) {
                  return list
                      .where((element) => element.supplierRoll
                          .contains(searchedText?.value.toString() ?? q))
                      .toList();
                } else {
                  return list
                      .where((element) => element.factoryRoll
                          .contains(searchedText?.value.toString() ?? q))
                      .toList();
                }
              },
              // onItemSelected: (RollData item) {
              //   print(item);
              // },
              inputDecoration: InputDecoration(
                labelText: text,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
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

class RollItem extends StatefulWidget {
  LoginObject? loginObject;
  final RollData rollData;
  String? qrData;
  String? headerId;
  String? rfid;
  String? invoiceNo;
  int value;

  // final index;

  RollItem({
    Key? key,
    required this.rollData,
    required this.value,
    this.qrData,
    this.headerId,
    this.loginObject,
    this.rfid,
    this.invoiceNo,
    // required this.index,
  }) : super(key: key);

  @override
  State<RollItem> createState() => _RollItemState();
}

class _RollItemState extends State<RollItem> {
  String? result;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Supplier Roll: ${widget.rollData.supplierRoll}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight:
                              widget.value == 1 ? FontWeight.bold : null,
                          fontSize: widget.value == 1 ? 17 : 16),
                    ),
                    Text(
                      'Factory Roll: ${widget.rollData.factoryRoll}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: widget.value == 2 ? 17 : 16,
                        fontWeight: widget.value == 2 ? FontWeight.bold : null,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Length: ${widget.rollData.rollLength}',
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      'Shade: ${widget.rollData.shade}',
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      'Shrink Length: ${widget.rollData.shrinkLength}',
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Row(
                      children: [
                        const Text('RFID Tag: ',
                            style:
                                TextStyle(color: Colors.black, fontSize: 16)),
                        Text(
                          widget.rollData.rfid ?? "",
                          style: TextStyle(
                              color: widget.rollData.rfidFlag == "2"
                                  ? Colors.red
                                  : Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            BlocConsumer<UpdateRfidCubit, UpdateRfidState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is UpdateRfidLoaded) {
                  if (state.response != "Data update unsuccessful!") {
                    context
                        .read<RollDataCubit>()
                        .getRollData(widget.headerId ?? "", "0");
                  }
                }
                return Container();
              },
            ),
            const Spacer(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(10, 55),
                  padding: EdgeInsets.only(left: 4, right: 4),
                ),
                onPressed: () async {
                  // QrBarCodeScannerDialog().getScannedQrBarCode(
                  //     context: context,
                  //     onCode: (code) {
                  //       setState(() {
                  //         result = code;
                  //         debugPrint("$result");
                  //         context.read<UpdateRfidCubit>().updateRfid(
                  //             widget.rollData.detailId,
                  //             result ?? "12345",
                  //             widget.loginObject?.employeeNumber ?? "",
                  //             "1");

                  //         // context.read<UpdateRfidCubit>().updateRfid(detailsId, rfid, entryBy, entryType)
                  //       });
                  //     });
                  // _turnOnFlash(context);
                  var res = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SimpleBarcodeScannerPage(
                          isShowFlashIcon: true,
                          scanType: ScanType.barcode,
                          appBarTitle:
                              "Scan for roll no: ${widget.rollData.factoryRoll}",
                        ),
                      ));
                  setState(() {
                    if (res is String && res != '-1') {
                      result = res;
                      debugPrint("res_ba_c: $result");
                      context.read<UpdateRfidCubit>().updateRfid(
                          widget.rollData.detailId,
                          result ?? "12345",
                          widget.loginObject?.employeeNumber ?? "",
                          "1");
                    }
                  });
                },
                child: const Icon(
                  Icons.qr_code_2,
                  size: 40,
                ))
          ],
        ),
      ),
    );
  }
}

Future<void> _turnOnFlash(BuildContext context) async {
  try {
    await TorchLight.enableTorch();
  } on Exception catch (_) {
    _showErrorMes('Could not enable Flashlight', context);
  }
}

Future<void> _turnOffFlash(BuildContext context) async {
  try {
    await TorchLight.disableTorch();
  } on Exception catch (_) {
    _showErrorMes('Could not enable Flashlight', context);
  }
}

void _showErrorMes(String mes, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mes)));
}

List<String> mapInventoryData(List<Inventory> elementList) {
  // return Map.fromIterable(elementList, key: (element) => ,)
  return elementList.map((e) => e.invoiceNo.toString()).toList();
}

List<String> mapRollList(List<RollData> elementList) {
  // return Map.fromIterable(elementList, key: (element) => ,)
  return elementList.map((e) => e.detailId.toString()).toList();
}

// class UpdatedRFID extends StatelessWidget {
//   LoginObject? loginObject;
//   String headerId;
//   String detailId;
//   String entryType;
//   String? rfid;
//   String? rfidFlag;
//   String? invoiceNo;
//   String? result;
//   UpdatedRFID(
//       {super.key,
//       required this.headerId,
//       required this.detailId,
//       required this.entryType,
//       this.loginObject,
//       this.rfid,
//       this.rfidFlag,
//       this.invoiceNo,
//       this.result});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Warehouse App"),
//         actions: const <Widget>[
//           LogoutWidget(),
//         ],
//         automaticallyImplyLeading: false,
//       ),
//       body: BlocProvider(
//         create: (context) => UpdateRfidCubit(UpdateDataRepoImpl()),
//         child: UpdatedRFIDView(
//             headerId: this.headerId,
//             detailId: this.detailId,
//             entryType: this.entryType,
//             loginObject: this.loginObject,
//             rfid: this.rfid,
//             rfidFlag: this.rfidFlag,
//             invoiceNo: this.invoiceNo,
//             result: this.result),
//       ),
//     );
//   }
// }

// class UpdatedRFIDView extends StatefulWidget {
//   LoginObject? loginObject;
//   String headerId;
//   String detailId;
//   String entryType;
//   String? rfid;
//   String? rfidFlag;
//   String? invoiceNo;
//   bool? cameraControll;
//   String? result;
//   UpdatedRFIDView({
//     super.key,
//     required this.headerId,
//     required this.detailId,
//     required this.entryType,
//     this.loginObject,
//     this.rfid,
//     this.rfidFlag,
//     this.invoiceNo,
//     this.cameraControll,
//     this.result,
//   });

//   @override
//   State<UpdatedRFIDView> createState() => _UpdatedRFIDViewState();
// }

// class _UpdatedRFIDViewState extends State<UpdatedRFIDView> {
//   @override
//   void initState() {
//     // print("${widget.detailId},${widget.result},${widget.loginObject?.profile?.empNo},${}")
//     // if (widget.entryType == "2" && widget.rfid != widget.result) {
//     //   showDialog(
//     //       context: context,
//     //       builder: (BuildContext context) {
//     //         return AlertDialog(
//     //             title: Text("Warning!!"),
//     //             content: Text("detached RFID no. is not the same"),
//     //             actions: <Widget>[
//     //               ElevatedButton(onPressed: () {}, child: Text("Detach Again"))
//     //             ]);
//     //       });
//     // } else {
//     print('object_4');
//     context.read<UpdateRfidCubit>().updateRfid(
//         widget.detailId,
//         widget.result ?? "12345",
//         widget.loginObject?.employeeNumber ?? "",
//         widget.entryType);
//     // }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<UpdateRfidCubit, UpdateRfidState>(
//       listener: (context, state) {
//         if (state is UpdateRfidLoaded) {
//           if (state.response != "Data update unsuccessful!") {
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => HomePage(
//                   qrData: widget.result?.toString(),
//                   headerId: widget.headerId,
//                   loginObject: widget.loginObject,
//                   invoiceNo: widget.invoiceNo,
//                   showall: "Show All",
//                   visible: true,
//                 ),
//               ),
//               (Route<dynamic> route) => false,
//             );
//           } else {
//             print("response+${state.response}");
//           }
//         }
//       },
//       builder: (context, state) {
//         if (state is UpdateRfidLoaded) {
//           print("response+${state.response}");
//           return Container();
//         } else {
//           return loadingScreen();
//         }
//       },
//     );
//   }
// }
