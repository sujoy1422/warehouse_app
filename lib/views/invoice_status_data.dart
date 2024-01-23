import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/cubit/invoice_status/invoice_status_cubit.dart';
import 'package:warehouse_app/models/login_object.dart';
import 'package:warehouse_app/repository/invoice_status_repo/invoice_status_repo_impl.dart';
import 'package:warehouse_app/views/login_screen.dart';
import 'package:warehouse_app/views/logout_widget.dart';

class InvoiceStatusData extends StatelessWidget {
  final LoginObject? loginObject;
  final String? headerId;
  InvoiceStatusData({super.key, this.loginObject, this.headerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text("Invoice Status"), actions: [LogoutWidget()]),
        body: BlocProvider(
          create: (context) => InvoiceStatusCubit(InvoiceStatusRepoImpl()),
          child: InvoiceStatusView(
            loginObject: loginObject,
            headerId: headerId,
          ),
        ));
  }
}

class InvoiceStatusView extends StatefulWidget {
  final LoginObject? loginObject;
  final String? headerId;

  InvoiceStatusView({super.key, this.loginObject, this.headerId});

  @override
  State<InvoiceStatusView> createState() => _InvoiceStatusViewState();
}

class _InvoiceStatusViewState extends State<InvoiceStatusView> {
  @override
  void initState() {
    context.read<InvoiceStatusCubit>().getInvoiceStatus(widget.headerId ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvoiceStatusCubit, InvoiceStatusState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is InvoiceStatusLoaded) {
            return Container(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total roll: ${state.invoiceStatus.totRoll}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    "Attached roll: ${state.invoiceStatus.inserted}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    "Remained: ${state.invoiceStatus.remained}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(
                      "Wrong entry",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  DataTable(columnSpacing: 20, columns: [
                    DataColumn(
                      label: Text(
                        'Invoice\nNo',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Supplier\nRoll',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Factory\nRoll',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'RFID',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ], rows: [
                    for (var i in state.invoiceStatus.unmacthedList!)
                      DataRow(cells: [
                        DataCell(Text("${i.invoiceNo}")),
                        DataCell(Text("${i.supplierRoll}")),
                        DataCell(Text("${i.factoryRoll}")),
                        DataCell(Text(
                          "${i.rfid}",
                          style: TextStyle(color: Colors.red),
                        )),
                      ]),
                  ])
                ],
              ),
            );
          } else if (state is InvoiceStatusLoading) {
            return loadingScreen();
          } else {
            return Container();
          }
        });
  }
}
