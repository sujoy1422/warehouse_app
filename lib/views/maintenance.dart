import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/cubit/maintainance/maintainance_cubit.dart';
import 'package:warehouse_app/models/login_object.dart';
import 'package:warehouse_app/repository/maintainance_repo/maintainance_repo_impl.dart';
import 'package:warehouse_app/views/alert_dialog.dart';
import 'package:warehouse_app/views/home_page_view.dart';
import 'package:warehouse_app/views/logout_widget.dart';

class Maintainance extends StatelessWidget {
  final LoginObject? loginObject;
  const Maintainance({super.key, this.loginObject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Maintenance Screen"),
          actions: const [LogoutWidget()],
        ),
        body: BlocProvider(
          create: (context) => MaintainanceCubit(MaintainanceRepoImpl()),
          child: MaintainanceScreen(loginObject: loginObject),
        ));
  }
}

class MaintainanceScreen extends StatefulWidget {
  final LoginObject? loginObject;
  const MaintainanceScreen({super.key, this.loginObject});

  @override
  State<MaintainanceScreen> createState() => _MaintainanceScreenState();
}

class _MaintainanceScreenState extends State<MaintainanceScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    loginObject: widget.loginObject, showall: "Show All",
                    visible: false,
                    // title: state.loginObject.auth!,
                  )),
          (Route<dynamic> route) => false,
        );
      },
      child: Stack(
        children: [
          // Main Content
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<MaintainanceCubit>().getMaintainance();
                  },
                  child: const Text("Update data"),
                ),
                BlocConsumer<MaintainanceCubit, MaintainanceState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is MaintainanceLoaded) {
                      if (state.maintainanceResponse?.response ==
                          "Procedure updated") {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          alertDialog(context, "Success!", "Data Updated");
                        });
                      } else {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          alertDialog(context, "Warning!",
                              "Something went wrong, updat again!");
                        });
                      }
                      debugPrint(state.toString());
                      return Container(); // Content when data is loaded
                    } else if (state is MaintainanceLoading) {
                      return Container(); // Placeholder for Loading State
                    } else {
                      return Container(); // Default placeholder
                    }
                  },
                )
              ],
            ),
          ),

          // Full Page Loader
          BlocBuilder<MaintainanceCubit, MaintainanceState>(
            builder: (context, state) {
              if (state is MaintainanceLoading) {
                return Container(
                  color: Colors.black
                      .withOpacity(0.5), // Semi-transparent background
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                );
              }
              return const SizedBox.shrink(); // Empty widget when not loading
            },
          ),
        ],
      ),
    );
  }
}
