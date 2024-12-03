// ignore_for_file: must_be_immutable

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:torch_light/torch_light.dart';
import 'package:warehouse_app/cubit/fabric_code_Style/fabric_code_style_cubit.dart';
import 'package:warehouse_app/cubit/inventory_cubit/inventory_cubit.dart';
import 'package:warehouse_app/cubit/invoice_details/invoice_details_cubit.dart';
import 'package:warehouse_app/cubit/invoice_status/invoice_status_cubit.dart';
import 'package:warehouse_app/cubit/invoice_style/invoice_styles_cubit.dart';
import 'package:warehouse_app/cubit/roll_data_cubit/roll_data_cubit.dart';
import 'package:warehouse_app/models/fabric_code_style/fabric_code_style.dart';
import 'package:warehouse_app/models/inventory.dart';
import 'package:warehouse_app/models/invoice_details.dart';
import 'package:warehouse_app/models/invoice_styles/invoice_styles.dart';
import 'package:warehouse_app/models/login_object.dart';
import 'package:warehouse_app/models/roll_data.dart';
import 'package:warehouse_app/repository/fabric_code_style_repository/fabric_code_style_repo_impl.dart';
import 'package:warehouse_app/repository/inventory_repository/inventory_repo_impl.dart';
import 'package:warehouse_app/repository/invoice_details_repository/invoice_details_repo_impl.dart';
import 'package:warehouse_app/repository/invoice_status_repo/invoice_status_repo_impl.dart';
import 'package:warehouse_app/repository/roll_data_repository/roll_data_repo_impl.dart';
import 'package:warehouse_app/repository/update_rfid/update_rfid_repo_impl.dart';
import 'package:warehouse_app/views/alert_dialog.dart';
import 'package:warehouse_app/views/invoice_status_data.dart';
import 'package:warehouse_app/views/widget/three_dot_menu_widget.dart';

import '../cubit/update_rfid/update_rfid_cubit.dart';
import '../repository/invoice_style_repo/invoice_style_repo_impl.dart';
import 'logout_dialog.dart';

TextEditingController? searchedText;

class HomePage extends StatelessWidget {
  String? qrData;
  String? headerId;
  String? lineId;
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
              text2: 'Maintenance',
              text4: 'Refresh',
              value1: 1,
              value2: 2,
              value3: 3,
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
              create: (context) => (InvoiceDetailsCubit(
                InvoiceDetailsRepoImpl(),
              )),
            ),
            BlocProvider(
              create: (context) => (RollDataCubit(
                RollDataRepoImpl(),
              )),
            ),
            BlocProvider(
              create: (context) => (InvoiceStatusCubit(
                InvoiceStatusRepoImpl(),
              )),
            ),
            BlocProvider(
              create: (context) => (FabricCodeStyleCubit(
                FabricCodeStyleRepoImpl(),
              )),
            ),
            BlocProvider(
              create: (context) => (InvoiceStylesCubit(
                InvoiceStyleRepoImpl(),
              )),
            ),
          ],
          child: HomePageView(
            qrData: qrData,
            headerId: headerId,
            lineId: lineId,
            loginObject: loginObject,
            rfid: rfid,
            invoiceNo: invoiceNo,
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
  String? lineId;
  String? invoiceNo;

  String showAll;
  bool visible;

  HomePageView(
      {super.key,
      this.qrData,
      this.headerId,
      this.lineId,
      this.loginObject,
      this.rfid,
      this.invoiceNo,
      required this.showAll,
      required this.visible});

  @override
  State<HomePageView> createState() => _HomePageViewState(
      qrData, headerId, lineId, loginObject, rfid, invoiceNo, showAll, visible);
}

class _HomePageViewState extends State<HomePageView> {
  String? qrData;
  String? headerId;
  String? headerId2;
  String? lineId;
  String? pocId;
  String? invoiceNo;
  String? articleNo;
  String? styleNo;
  String? productionStyleNo;
  String? detailsId;
  LoginObject? loginObject;
  String? rfid;
  String showAll;
  bool visible;

  List<Inventory> inventory = <Inventory>[];
  List<InvoiceDetails> fabricCode = <InvoiceDetails>[];
  List<String> inventoryList = [];
  List<String> fabricCodeList = [];
  List<String> fabricCodeStyleList = [];
  List<String> invoiceStyleList = [];
  List<InvoiceStyles> invoiceStyles = [];
  List<String> fabricCodeList2 = [];
  List<RollData> rollData = <RollData>[];
  List<String> rollList = <String>[];
  final controller = TextEditingController();
  ValueNotifier<String> noOfPackages = ValueNotifier("");
  int selectedSearchOption = 1;

  String totalPcs = "";
  String totalYards = "";
  String attachedYards = "";
  String attachedRolls = "";

  bool buttonPressed = false;

  _HomePageViewState(this.qrData, this.headerId, this.lineId, this.loginObject,
      this.rfid, this.invoiceNo, this.showAll, this.visible);
  @override
  void initState() {
    context.read<InventoryCubit>().getInventoryData("342");

    // if (headerId != null && lineId != null) {
    //   debugPrint("invoiceDetails");
    //   context.read<InvoiceDetailsCubit>().getInvoiceDetails(headerId ?? "123");

    //   context
    //       .read<RollDataCubit>()
    //       .getRollData(headerId ?? "123", lineId ?? "123", "0");
    // }
    // if (headerId != null) {
    //   context.read<RollDataCubit>().getRollData(headerId!, "0");
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(loginObject);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String _selectedItem = "";
    bool statusChanged = true;

    // return BlocConsumer<InventoryCubit, InventoryState>(
    //   listener: (context, state) {},
    //   builder: (context, state) {
    //     if (state is InventoryLoaded) {
    //       debugPrint(state.inventory);
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
                        width: width * 0.98,
                        margin: const EdgeInsets.only(top: 5, bottom: 5),
                        child: DropdownSearch<String>(
                          popupProps: const PopupProps.menu(
                            showSelectedItems: true,
                            showSearchBox: true,
                          ),
                          selectedItem: inventoryList.contains(invoiceNo)
                              ? invoiceNo
                              : null,
                          items: inventoryList,
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Select Inventory Data",
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              invoiceNo = newValue;
                            });
                          },
                        ),
                      );
                    } else if (state is InventoryLoading) {
                      return Container();
                    } else if (state is InventoryLoaded) {
                      inventoryList.clear();
                      inventoryList.addAll(mapInventoryData(state.inventory));
                      return Container(
                        width: width * 0.98,
                        margin: const EdgeInsets.only(top: 5, bottom: 5),
                        child: DropdownSearch<String>(
                          popupProps: const PopupProps.menu(
                            showSelectedItems: true,
                            showSearchBox: true,
                          ),
                          selectedItem: inventoryList.contains(invoiceNo)
                              ? invoiceNo
                              : null,
                          items: inventoryList,
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Select Invoice ~ Header No",
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              invoiceNo = newValue;
                              articleNo = null;
                              lineId = "null";
                              if (newValue != null) {
                                final index = inventoryList.indexOf(newValue);
                                if (index != -1) {
                                  headerId = state.inventory[index].headerId!;
                                  if (statusChanged) {
                                    context
                                        .read<InvoiceDetailsCubit>()
                                        .getInvoiceDetails(headerId!);
                                  }
                                }
                              }
                              statusChanged = false;
                            });
                          },
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                  listener: (context, state) {},
                ),
                BlocConsumer<InvoiceDetailsCubit, InvoiceDetailsState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if ((state is InvoiceDetailsLoaded) && statusChanged) {
                      fabricCodeList.clear();
                      fabricCodeList
                          .addAll(mapFabricCodeData(state.invoiceDetails));
                      return Container(
                        width: width * 0.98,
                        margin: const EdgeInsets.only(top: 5, bottom: 5),
                        child: DropdownSearch<String>(
                          popupProps: const PopupProps.menu(
                            showSelectedItems: true,
                            showSearchBox: true,
                          ),
                          selectedItem: fabricCodeList.contains(articleNo)
                              ? articleNo
                              : null,
                          items: fabricCodeList,
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Select Article",
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              articleNo = newValue;
                              if (newValue != null) {
                                final index = fabricCodeList.indexOf(newValue);
                                if (index != -1) {
                                  articleNo =
                                      state.invoiceDetails[index].articlesNo ??
                                          "";

                                  lineId = "null";

                                  debugPrint(
                                      "header_id: $headerId, article, $articleNo, line_id, $lineId");
                                  context.read<RollDataCubit>().getRollData(
                                      headerId ?? "",
                                      articleNo ?? "",
                                      "null",
                                      "0");
                                  context
                                      .read<InvoiceStatusCubit>()
                                      .getInvoiceStatus(headerId ?? "",
                                          articleNo ?? "", "null", "");
                                  context
                                      .read<FabricCodeStyleCubit>()
                                      .getfabricCodetStyle(
                                          headerId ?? "", articleNo ?? "");
                                  context
                                      .read<InvoiceStylesCubit>()
                                      .getInvoiceStyle(
                                          headerId ?? "", articleNo ?? "", "");
                                }
                              }
                              visible = true;
                            });
                          },
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                BlocConsumer<FabricCodeStyleCubit, FabricCodeStyleState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if ((state is FabricCodeStyleLoaded) && statusChanged) {
                      fabricCodeStyleList.clear();
                      fabricCodeStyleList.addAll(
                          mapFabricCodeStyleData(state.fabricCodeStyle));
                      return Container(
                        width: width * 0.98,
                        margin: const EdgeInsets.only(top: 5, bottom: 5),
                        child: DropdownSearch<String>(
                          popupProps: const PopupProps.menu(
                            showSelectedItems: true,
                            showSearchBox: true,
                          ),
                          selectedItem: fabricCodeStyleList.contains(styleNo)
                              ? styleNo
                              : null,
                          items: fabricCodeStyleList,
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Select Style ~ Season",
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              styleNo = newValue;
                              if (newValue != null) {
                                final index =
                                    fabricCodeStyleList.indexOf(newValue);
                                if (index != -1) {
                                  lineId =
                                      state.fabricCodeStyle[index].lineId ?? "";

                                  debugPrint(
                                      "header_id: $headerId, article, $articleNo, line_id, $lineId");
                                  context.read<RollDataCubit>().getRollData(
                                      headerId ?? "",
                                      articleNo ?? "",
                                      lineId ?? "",
                                      "0");
                                  context
                                      .read<InvoiceStatusCubit>()
                                      .getInvoiceStatus(headerId ?? "",
                                          articleNo ?? "", lineId ?? "", "");

                                  context
                                      .read<InvoiceStylesCubit>()
                                      .getInvoiceStyle(headerId ?? "",
                                          articleNo ?? "", lineId ?? "");
                                }
                              }
                              visible = true;
                            });
                          },
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                BlocConsumer<InvoiceStylesCubit, InvoiceStylesState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if ((state is InvoiceStylesLoaded) && statusChanged) {
                      invoiceStyleList.clear();
                      invoiceStyleList.add("Select production style");
                      invoiceStyleList.addAll(
                          mapInvoiceStyleData(state.invoiceStyles ?? []));
                      return Container(
                        width: width * 0.98,
                        margin: const EdgeInsets.only(top: 5, bottom: 5),
                        child: DropdownSearch<String>(
                          popupProps: const PopupProps.menu(
                            showSelectedItems: true,
                            showSearchBox: true,
                          ),
                          selectedItem:
                              invoiceStyleList.contains(productionStyleNo)
                                  ? productionStyleNo
                                  : null,
                          items: invoiceStyleList,
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Select Production Style",
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              productionStyleNo = newValue;
                              if (newValue != null) {
                                final index =
                                    invoiceStyleList.indexOf(newValue);
                                if (index != -1) {
                                  pocId = index == 0
                                      ? ""
                                      : state.invoiceStyles?[index].pocId ?? "";

                                  debugPrint(
                                      "header_id: $headerId, article, $articleNo, line_id, $lineId");
                                  // context.read<RollDataCubit>().getRollData(
                                  //     headerId ?? "",
                                  //     articleNo ?? "",
                                  //     lineId ?? "",
                                  //     "0");
                                  context
                                      .read<InvoiceStatusCubit>()
                                      .getInvoiceStatus(
                                          headerId ?? "",
                                          articleNo ?? "",
                                          lineId ?? "",
                                          pocId ?? "");
                                }
                              }
                              visible = true;
                            });
                          },
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
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
                              const Text("supplier roll"),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: Row(
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
                                const Text("factory roll"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            BlocConsumer<InvoiceStatusCubit,
                                InvoiceStatusState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                if (state is InvoiceStatusLoaded) {
                                  debugPrint(
                                      "invoiceStatus ${state.invoiceStatus}");
                                  return Card(
                                    elevation: 5,
                                    child: Container(
                                      height: height * 0.08,
                                      width: width,
                                      color: const Color.fromARGB(
                                          255, 224, 234, 255),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                "Summary: ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              const Spacer(),
                                              const Text(
                                                "Shaded: ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                child: Text(
                                                  "${state.invoiceStatus?.shadedRoll ?? "0"} P",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 15),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.15,
                                                ),
                                                child: const Text(
                                                  "Total: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                              ),
                                              Text(
                                                "${state.invoiceStatus?.totalRolls ?? "0"} P / ${state.invoiceStatus?.totalYards ?? "0"} Y",
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 15),
                                              ),
                                              Spacer(),
                                              const Text(
                                                "Attached: ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                child: Text(
                                                  "${state.invoiceStatus?.attachedRoll ?? "0"} P / ${state.invoiceStatus?.attachedLength ?? "0"} Y",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 15),
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
                            ),
                            Row(
                              children: [
                                Container(
                                    alignment: Alignment.topLeft,
                                    padding: const EdgeInsets.only(left: 20),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            fixedSize: Size(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                                20),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                        onPressed: () {
                                          if (showAll == "Show All") {
                                            debugPrint(
                                                'show_all $headerId $articleNo');
                                            context
                                                .read<RollDataCubit>()
                                                .getRollData(
                                                    headerId ?? "123",
                                                    articleNo ?? "",
                                                    lineId ?? "null",
                                                    "1");
                                          } else {
                                            context
                                                .read<RollDataCubit>()
                                                .getRollData(
                                                    headerId ?? "123",
                                                    articleNo ?? "",
                                                    lineId ?? "null",
                                                    "0");
                                          }
                                          setState(() {
                                            if (showAll == "Show All") {
                                              showAll = "Hide";
                                            } else {
                                              showAll = "Show All";
                                            }
                                          });
                                        },
                                        child: Text(
                                          showAll,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ))),
                                const Spacer(),
                                Visibility(
                                  visible:
                                      false, //headerId != null ? true : false,
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (headerId != null) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    InvoiceStatusData(
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
                                        child: const Text("Check Status")),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Visibility(
                      visible: selectedSearchOption == 1,
                      child: SearchacbleRollList(
                        value: selectedSearchOption,
                        height: height,
                        width: width,
                        loginObject: loginObject,
                        qrData: qrData,
                        headerId: headerId,
                        articleNo: articleNo,
                        lineId: lineId,
                        rfid: rfid,
                        pocId: pocId ?? "",
                        invoiceNo: invoiceNo,
                        rollData: rollData,
                        text: "Search Supplier Roll",
                      ),
                    ),
                    Visibility(
                      visible: selectedSearchOption == 2,
                      child: SearchacbleRollList(
                        value: selectedSearchOption,
                        height: height,
                        width: width,
                        loginObject: loginObject,
                        qrData: qrData,
                        headerId: headerId,
                        articleNo: articleNo,
                        lineId: lineId,
                        rfid: rfid,
                        pocId: pocId ?? "",
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

class SearchacbleRollList extends StatelessWidget {
  SearchacbleRollList({
    super.key,
    required this.height,
    required this.width,
    required this.loginObject,
    required this.qrData,
    required this.headerId,
    required this.articleNo,
    required this.lineId,
    required this.rfid,
    required this.invoiceNo,
    required this.rollData,
    required this.text,
    required this.pocId,
    required this.value,
  });

  final double height;
  final double width;
  final LoginObject? loginObject;
  final String? qrData;
  final String? headerId;
  final String? articleNo;
  final String? lineId;
  final String? rfid;
  final String? invoiceNo;
  final String text;
  final String pocId;
  final int value;
  List<RollData> rollData;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RollDataCubit, RollDataState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is RollDataLoaded) {
          debugPrint("rollData, $rollData");
          rollData.clear();
          rollData = state.rolldata;
          debugPrint(rollData.toString());

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
                  articleNo: articleNo,
                  pocId: pocId,
                  lineId: lineId,
                  rfid: rfid,
                  invoiceNo: invoiceNo,
                  shadeStatus: rollData.shadeStatus,
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
              //   debugPrint(item);
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
  String? articleNo;
  String? lineId;
  String? rfid;
  String? invoiceNo;
  String? pocId;
  int value;
  String? shadeStatus;

  // final index;

  RollItem(
      {Key? key,
      required this.rollData,
      required this.value,
      this.qrData,
      this.headerId,
      this.articleNo,
      this.lineId,
      this.loginObject,
      this.rfid,
      this.pocId,
      this.invoiceNo,
      this.shadeStatus
      // required this.index,
      })
      : super(key: key);

  @override
  State<RollItem> createState() => _RollItemState();
}

class _RollItemState extends State<RollItem> {
  String? result;
  late bool isChecked;
  @override
  void initState() {
    isChecked = widget.shadeStatus == "1" ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("shadeStatus ${widget.shadeStatus}");

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
                      'Pattern: ${widget.rollData.shrinkPattern}',
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
              listener: (context, state) {
                if (state is UpdateRfidLoaded) {
                  if (state.response.response ==
                      "Data update successful check!") {
                    setState(() {
                      debugPrint("Ghere, $isChecked");
                      isChecked = !isChecked;
                      debugPrint("Ghere, $isChecked");
                    });

                    // context.read<RollDataCubit>().getRollData(
                    //     widget.headerId ?? "",
                    //     widget.articleNo ?? "",
                    //     widget.lineId ?? "null",
                    //     "0");
                  }
                }
              },
              builder: (context, state) {
                if (state is UpdateRfidLoaded) {
                  debugPrint(
                      "state_res ${state.response.response}, ${widget.headerId}, ${widget.lineId}");
                  if (state.response.response == "Data update successful!") {
                    context.read<RollDataCubit>().getRollData(
                        widget.headerId ?? "",
                        widget.articleNo ?? "",
                        widget.lineId ?? "null",
                        "0");

                    debugPrint(
                        "update_status ${widget.headerId}, ${widget.articleNo}");

                    context.read<InvoiceStatusCubit>().getInvoiceStatus(
                        widget.headerId ?? "",
                        widget.articleNo ?? "",
                        widget.lineId ?? "null",
                        "");
                  } else if (state.response.response ==
                      "Data update successful check!") {
                    debugPrint(
                        "update_status ${widget.headerId}, ${widget.articleNo}");

                    context.read<InvoiceStatusCubit>().getInvoiceStatus(
                        widget.headerId ?? "",
                        widget.articleNo ?? "",
                        widget.lineId ?? "null",
                        "");
                  }
                }
                return Container();
              },
            ),
            const Spacer(),
            Column(
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(10, 55),
                        padding: const EdgeInsets.only(left: 4, right: 4),
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                    onPressed: () async {
                      // QrBarCodeScannerDialog().getScannedQrBarCode(
                      //     context: context,
                      //     onCode: (code) {
                      //       setState(() {
                      //         result = code;
                      //         debugdebugPrint("$result");
                      //         context.read<UpdateRfidCubit>().updateRfid(
                      //             widget.rollData.detailId,
                      //             result ?? "12345",
                      //             widget.loginObject?.employeeNumber ?? "",
                      //             "1");

                      //         // context.read<UpdateRfidCubit>().updateRfid(detailsId, rfid, entryBy, entryType)
                      //       });
                      //     });
                      // _turnOnFlash(context);
                      var res = await BarcodeScanner.scan(
                          options: const ScanOptions(
                              autoEnableFlash: true,
                              android: AndroidOptions(
                                  useAutoFocus: true, aspectTolerance: 20.2)));
                      //  .scanBarcode(
                      //     "#ff6666", "Cancel", false, ScanMode.DEFAULT);
                      // await Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => SimpleBarcodeScannerPage(
                      //         isShowFlashIcon: true,
                      //         scanType: ScanType.barcode,
                      //         appBarTitle:
                      //             "Scan for roll no: ${widget.rollData.factoryRoll}",
                      //       ),
                      //     ));
                      setState(() {
                        if (res.rawContent != '-1') {
                          result = res.rawContent;
                          debugPrint(
                              "res_ba_c: $result, poc_id:${widget.pocId}");
                          context.read<UpdateRfidCubit>().updateRfid(
                              widget.rollData.detailId,
                              result ?? "12345",
                              widget.loginObject?.employeeNumber ?? "",
                              "1",
                              widget.pocId ?? "",
                              "0");
                        }
                      });
                    },
                    child: const Icon(
                      Icons.qr_code_2,
                      color: Colors.white,
                      size: 40,
                    )),
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: isChecked ? Colors.red : Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                    onPressed: () {
                      debugPrint(
                          "Update data: ${widget.rollData.detailId}, $result, ${widget.loginObject?.employeeName}, 1, ${widget.pocId}, 1");
                      context.read<UpdateRfidCubit>().updateRfid(
                          widget.rollData.detailId,
                          result ?? "12345",
                          widget.loginObject?.employeeNumber ?? "",
                          "1",
                          widget.pocId ?? "",
                          isChecked ? "0" : "1");
                    },
                    child: Text(
                      isChecked ? "Uncheck" : "Check",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            )
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

List<String> mapFabricCodeData(List<InvoiceDetails> elementList) {
  // return Map.fromIterable(elementList, key: (element) => ,)
  return elementList.map((e) => e.articleNo.toString()).toList();
}

List<String> mapFabricCodeStyleData(List<FabricCodeStyle> elementList) {
  // return Map.fromIterable(elementList, key: (element) => ,)
  return elementList.map((e) => e.styleNo.toString()).toList();
}

List<String> mapInvoiceStyleData(List<InvoiceStyles> elementList) {
  // return Map.fromIterable(elementList, key: (element) => ,)
  return elementList.map((e) => e.style.toString()).toList();
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
//     // debugPrint("${widget.detailId},${widget.result},${widget.loginObject?.profile?.empNo},${}")
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
//     debugPrint('object_4');
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
//             debugPrint("response+${state.response}");
//           }
//         }
//       },
//       builder: (context, state) {
//         if (state is UpdateRfidLoaded) {
//           debugPrint("response+${state.response}");
//           return Container();
//         } else {
//           return loadingScreen();
//         }
//       },
//     );
//   }
// }
