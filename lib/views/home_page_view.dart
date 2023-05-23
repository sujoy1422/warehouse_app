import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:warehouse_app/cubit/inventory_cubit/inventory_cubit.dart';
import 'package:warehouse_app/cubit/roll_data_cubit/roll_data_cubit.dart';
import 'package:warehouse_app/models/inventory.dart';
import 'package:warehouse_app/models/login_object.dart';
import 'package:warehouse_app/models/roll_data.dart';
import 'package:warehouse_app/repository/inventory_repository/inventory_repo_impl.dart';
import 'package:warehouse_app/repository/roll_data_repository/roll_data_repo_impl.dart';
import 'package:warehouse_app/repository/update_rfid/update_rfid_repo_impl.dart';
import 'package:warehouse_app/views/alert_dialog.dart';
import 'package:warehouse_app/views/login_screen.dart';
import 'package:warehouse_app/views/qr_view.dart';

import '../cubit/update_rfid/update_rfid_cubit.dart';
import 'logout_dialog.dart';
import 'logout_widget.dart';

TextEditingController? searchedText;

class HomePage extends StatelessWidget {
  String? qrData;
  String? headerId;
  LoginObject? loginObject;
  String? rfid;
  String? invoiceNo;

  HomePage(
      {super.key,
      this.qrData,
      this.headerId,
      this.loginObject,
      this.rfid,
      this.invoiceNo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Warehouse App"),
          actions: const <Widget>[
            LogoutWidget(),
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

  HomePageView(
      {super.key,
      this.qrData,
      this.headerId,
      this.loginObject,
      this.rfid,
      this.invoiceNo});

  @override
  State<HomePageView> createState() => _HomePageViewState(
      this.qrData, this.headerId, this.loginObject, this.rfid, this.invoiceNo);
}

class _HomePageViewState extends State<HomePageView> {
  String? qrData;
  String? headerId;
  String? invoiceNo;
  String? detailsId;
  LoginObject? loginObject;
  String? rfid;

  List<Inventory> inventory = <Inventory>[];
  List<String> inventoryList = [];
  List<RollData> rollData = <RollData>[];
  List<String> rollList = <String>[];
  final controller = TextEditingController();
  ValueNotifier<String> noOfPackages = ValueNotifier("");

  bool buttonPressed = false;

  _HomePageViewState(
      this.qrData, this.headerId, this.loginObject, this.rfid, this.invoiceNo);
  @override
  void initState() {
    context.read<InventoryCubit>().getInventoryData("341");

    if (headerId != null) {
      context.read<RollDataCubit>().getRollData(headerId!);
    }
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
                BlocConsumer<InventoryCubit, InventoryState>(
                    builder: (context, state) {
                      if (state is InventoryInitial) {
                        return Container(
                          width: width * 0.8,
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
                        inventoryList.clear();
                        // jobList.value.add("Select a Job");
                        inventoryList.addAll(mapInventoryData(state.inventory));
                        inventory = state.inventory;
                        _selectedItem = "";
                        // print("JobList:" + jobList.toString());
                        // dropDown(width);
                        return Container(
                          width: width * 0.8,
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

                                  headerId = state
                                      .inventory[
                                          inventoryList.indexOf(newValue)]
                                      .headerId!;
                                  invoiceNo = newValue;
                                  context.read<RollDataCubit>().getRollData(
                                      state
                                          .inventory[
                                              inventoryList.indexOf(newValue)]
                                          .headerId!);
                                });
                                //newValue = "";
                              }),
                        );
                      } else {
                        return Container();
                      }
                    },
                    listener: (context, state) {}),
                BlocConsumer<RollDataCubit, RollDataState>(
                    builder: (context, state) {
                      if (state is RollDataLoaded) {
                        rollData = state.rolldata;
                        rollList.clear();
                        rollList.addAll(mapRollList(state.rolldata));

                        return Container(
                          height: height * 0.7,
                          width: width * 0.9,
                          child: SearchableList(
                            searchTextController: searchedText,
                            builder: (RollData rollData) => RollItem(
                              loginObject: loginObject,
                              rollData: rollData,
                              qrData: qrData,
                              headerId: headerId,
                              rfid: rfid,
                              invoiceNo: invoiceNo,
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
                              return list
                                  .where((element) => element.supplierRoll
                                      .contains(
                                          searchedText?.value.toString() ?? q))
                                  .toList();
                            },
                            // onItemSelected: (RollData item) {
                            //   print(item);
                            // },
                            inputDecoration: InputDecoration(
                              labelText: "Search Roll Id",
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
                    listener: (context, state) {})
              ],
            ),
          ),
        ),
      ),
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

  // final index;

  RollItem({
    Key? key,
    required this.rollData,
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
        padding: EdgeInsets.only(bottom: 5, top: 5, left: 10),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Supplier Roll: ${widget.rollData.supplierRoll}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    Text(
                      'Factory Roll: ${widget.rollData.factoryRoll}',
                      style: const TextStyle(color: Colors.black, fontSize: 16
                          // fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'Length: ${widget.rollData.rollLength}',
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
            const Spacer(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(10, 55),
                  padding: EdgeInsets.only(left: 4, right: 4),
                ),
                onPressed: () async {
                  if (widget.rollData.rfid == null) {
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => QrView(
                    //         headerId: widget.headerId.toString(),
                    //         detailId: widget.rollData.detailId,
                    //         entryType: "1",
                    //         loginObject: widget.loginObject,
                    //         invoiceNo: widget.invoiceNo
                    //         // qrData: result?.code?.toString(),
                    //         // profileObject: state.profile,
                    //         // loginObject: widget.loginObject,
                    //         ),
                    //   ),
                    //   (Route<dynamic> route) => false,
                    // );
                    var res = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SimpleBarcodeScannerPage(),
                        ));
                    setState(() {
                      if (res is String) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdatedRFID(
                                headerId: widget.headerId ?? "",
                                detailId: widget.rollData.detailId,
                                result: res,
                                entryType: "1",
                                loginObject: widget.loginObject,
                              ),
                            ));
                      }
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Scan for Code!!"),
                          content: Text("What do you want to do? "),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text("Detach"),
                              onPressed: () async {
                                var res = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SimpleBarcodeScannerPage(),
                                    ));
                                setState(() {
                                  if (res is String) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UpdatedRFID(
                                            headerId: widget.headerId ?? "",
                                            detailId: widget.rollData.detailId,
                                            result: res,
                                            entryType: "2",
                                            rfid: widget.rollData.rfid,
                                            loginObject: widget.loginObject,
                                          ),
                                        ));
                                  }
                                });
                                // FocusScope.of(conte xt).unfocus();
                              },
                            ),
                            ElevatedButton(
                              child: const Text("Attach"),
                              onPressed: () async {
                                var res = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SimpleBarcodeScannerPage(),
                                    ));
                                setState(() {
                                  if (res is String) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UpdatedRFID(
                                            headerId: widget.headerId ?? "",
                                            detailId: widget.rollData.detailId,
                                            result: res,
                                            entryType: "1",
                                            loginObject: widget.loginObject,
                                          ),
                                        ));
                                  }
                                });
                                // FocusScope.of(conte xt).unfocus();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                  // print(rollData);
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

List<String> mapInventoryData(List<Inventory> elementList) {
  // return Map.fromIterable(elementList, key: (element) => ,)
  return elementList.map((e) => e.invoiceNo.toString()).toList();
}

List<String> mapRollList(List<RollData> elementList) {
  // return Map.fromIterable(elementList, key: (element) => ,)
  return elementList.map((e) => e.detailId.toString()).toList();
}

class UpdatedRFID extends StatelessWidget {
  LoginObject? loginObject;
  String headerId;
  String detailId;
  String entryType;
  String? rfid;
  String? rfidFlag;
  String? invoiceNo;
  String? result;
  UpdatedRFID(
      {super.key,
      required this.headerId,
      required this.detailId,
      required this.entryType,
      this.loginObject,
      this.rfid,
      this.rfidFlag,
      this.invoiceNo,
      this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Warehouse App"),
        actions: const <Widget>[
          LogoutWidget(),
        ],
        automaticallyImplyLeading: false,
      ),
      body: BlocProvider(
        create: (context) => UpdateRfidCubit(UpdateDataRepoImpl()),
        child:  UpdatedRFIDView(
            headerId: this.headerId,
            detailId: this.detailId,
            entryType: this.entryType,
            loginObject: this.loginObject,
            rfid: this.rfid,
            rfidFlag: this.rfidFlag,
            invoiceNo: this.invoiceNo,
            result: this.result),
      ),
    );
  }
}

class UpdatedRFIDView extends StatefulWidget {
  LoginObject? loginObject;
  String headerId;
  String detailId;
  String entryType;
  String? rfid;
  String? rfidFlag;
  String? invoiceNo;
  bool? cameraControll;
  String? result;
  UpdatedRFIDView({
    super.key,
    required this.headerId,
    required this.detailId,
    required this.entryType,
    this.loginObject,
    this.rfid,
    this.rfidFlag,
    this.invoiceNo,
    this.cameraControll,
    this.result,
  });

  @override
  State<UpdatedRFIDView> createState() => _UpdatedRFIDViewState();
}

class _UpdatedRFIDViewState extends State<UpdatedRFIDView> {
  @override
  void initState() {
    // print("${widget.detailId},${widget.result},${widget.loginObject?.profile?.empNo},${}")
    // if (widget.entryType == "2" && widget.rfid != widget.result) {
    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //             title: Text("Warning!!"),
    //             content: Text("detached RFID no. is not the same"),
    //             actions: <Widget>[
    //               ElevatedButton(onPressed: () {}, child: Text("Detach Again"))
    //             ]);
    //       });
    // } else {
      context.read<UpdateRfidCubit>().updateRfid(
          widget.detailId,
          widget.result ?? "12345",
          widget.loginObject?.profile?.empNo ?? "",
          widget.entryType);
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateRfidCubit, UpdateRfidState>(
      listener: (context, state) {
        if (state is UpdateRfidLoaded) {
          if (state.response != "Data update unsuccessful!") {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  qrData: widget.result?.toString(),
                  headerId: widget.headerId,
                  loginObject: widget.loginObject,
                  invoiceNo: widget.invoiceNo,
                ),
              ),
              (Route<dynamic> route) => false,
            );
          } else {
            print(state.response);
          }
        }
      },
      builder: (context, state) {
        if (state is UpdateRfidLoaded) {
          return Container();
        } else {
          return loadingScreen();
        }
      },
    );
  }
}
