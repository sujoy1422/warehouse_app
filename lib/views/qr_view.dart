// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:warehouse_app/cubit/update_rfid/update_rfid_cubit.dart';
import 'package:warehouse_app/repository/update_rfid/update_rfid_repo_impl.dart';
import 'package:warehouse_app/views/alert_dialog.dart';
import 'package:warehouse_app/views/home_page_view.dart';

import '../models/login_object.dart';

// void main() => runApp(const MaterialApp(home: MyHome()));

class QrView extends StatelessWidget {
  LoginObject? loginObject;
  String headerId;
  String detailId;
  String entryType;
  String? rfid;
  String? rfidFlag;
  String? invoiceNo;

  QrView({
    super.key,
    required this.headerId,
    required this.detailId,
    required this.entryType,
    this.loginObject,
    this.rfid,
    this.rfidFlag,
    this.invoiceNo,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    loginObject: loginObject,
                    headerId: headerId,
                    invoiceNo: invoiceNo,
                    showall: "Show All",
                    visible: true,
                  )),
          // (Route<dynamic> route) => false
        );
        return Future.value(true);
      },
      child: BlocProvider(
        create: (context) => UpdateRfidCubit(UpdateDataRepoImpl()),
        // child: QRViewExample(loginObject: this.loginObject),
        child: QRViewExample(
            headerId: this.headerId,
            detailId: this.detailId,
            entryType: this.entryType,
            loginObject: this.loginObject,
            rfid: this.rfid,
            rfidFlag: this.rfidFlag,
            invoiceNo: this.invoiceNo),
      ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  LoginObject? loginObject;
  String headerId;
  String detailId;
  String entryType;
  String? rfid;
  String? rfidFlag;
  String? invoiceNo;
  bool? cameraControll;

  QRViewExample({
    super.key,
    required this.headerId,
    required this.detailId,
    required this.entryType,
    this.loginObject,
    this.rfid,
    this.rfidFlag,
    this.invoiceNo,
    this.cameraControll,
  });

  @override
  State<StatefulWidget> createState() => _QRViewExampleState(
      this.headerId,
      this.detailId,
      this.entryType,
      this.loginObject,
      this.rfid,
      this.rfidFlag,
      this.invoiceNo,
      this.cameraControll);
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  LoginObject? loginObject;
  String? invoiceNo;

  String headerId;
  String detailId;
  String entryType;
  String? rfid;
  String? rfidFlag;
  bool? cameraControll;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  _QRViewExampleState(
      this.headerId,
      this.detailId,
      this.entryType,
      this.loginObject,
      this.rfid,
      this.rfidFlag,
      this.invoiceNo,
      this.cameraControll);

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    print(loginObject);

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            // flex: 1,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                BlocConsumer<UpdateRfidCubit, UpdateRfidState>(
                  builder: (context, state) {
                    if (state is UpdateRfidLoaded) {
                      // print("profile: $profile");
                      print(state.response);

                      // (Route<dynamic> route) => false);
                      return Container();
                    } else {
                      return Container();
                    }
                  },
                  listener: (context, state) {
                    if (state is UpdateRfidLoaded) {
                      if (state.response != "Data update successful!") {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(
                              qrData: result?.code?.toString(),
                              headerId: headerId,
                              loginObject: loginObject,
                              invoiceNo: invoiceNo,
                              showall: "Show All",
                              visible: true,
                            ),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      } else {
                        alertDialog(context, "Warning!",
                            "Something Went Wrong, Please try again or Contact IT");
                      }
                    }
                  },
                ),

                Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text(
                      'Scan QR Code',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                      onPressed: () async {
                        await controller?.toggleFlash();
                        setState(() {});
                      },
                      child: FutureBuilder(
                        future: controller?.getFlashStatus(),
                        builder: (context, snapshot) {
                          if (snapshot.data == true) {
                            return Icon(Icons.flash_on);
                          } else {
                            return Icon(Icons.flash_off);
                          }
                        },
                      )),
                ),
                // Container(
                //   margin: const EdgeInsets.all(8),
                //   child: ElevatedButton(
                //       onPressed: () async {
                //         await controller?.flipCamera();
                //         setState(() {});
                //       },
                //       child: FutureBuilder(
                //         future: controller?.getCameraInfo(),
                //         builder: (context, snapshot) {
                //           if (snapshot.data != null) {
                //             return Text(
                //                 'Camera facing ${describeEnum(snapshot.data!)}');
                //           } else {
                //             return const Text('loading');
                //           }
                //         },
                //       )),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return SimpleBarcodeScannerPage();
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        // cameraControll = true;
        print(scanData);
        result = scanData;
        if (result != null) {
          // qrKey
          // context.read<LoginCubit>().getLoginData(empNo, pass, orgId, empCat)
          // context.read<ProfileCubit>().getProfileData(result?.code);
          print(
              "DetailId:${detailId}result:${result!.code} loginObject ${loginObject?.employeeNumber}entryType$entryType");
          if (entryType == "2" && rfidFlag != result?.code.toString()) {
            // controller.pauseCamera();

            alertDialog(context, "Warning!", "Scanned ID Must be Same");
          } else {
            controller.pauseCamera();

            context.read<UpdateRfidCubit>().updateRfid(
                detailId,
                result?.code.toString() ?? "",
                loginObject?.employeeNumber ?? "",
                entryType);
          }
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
