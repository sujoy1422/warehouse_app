import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/cubit/roll_details/roll_details_cubit.dart';
import 'package:warehouse_app/repository/roll_details_repository/roll_details_repo_impl.dart';
import 'package:warehouse_app/views/logout_widget.dart';

class RolLDetails extends StatelessWidget {
  String rfid;
  RolLDetails({super.key, required this.rfid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Roll Details"),
          actions: [LogoutWidget()],
        ),
        body: BlocProvider(
          create: (context) => RollDetailsCubit(RollDetailsRepoImpl()),
          child: RollDetailsScreen(rfid: rfid),
        ));
  }
}

class RollDetailsScreen extends StatefulWidget {
  String rfid;
  RollDetailsScreen({super.key, required this.rfid});

  @override
  State<RollDetailsScreen> createState() => _RollDetailsScreenState();
}

class _RollDetailsScreenState extends State<RollDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RollDetailsCubit>().getRollDetails(widget.rfid);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RollDetailsCubit, RollDetailsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is RollDetailsLoaded) {
          print(state);
          if (state.rollDetails.isNotEmpty) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    rollDetailsTextWidget(
                        "Roll No. : ", state.rollDetails[0].rfid.toString()),
                    rollDetailsTextWidget("Factory Roll : ",
                        state.rollDetails[0].factoryRoll.toString()),
                    rollDetailsTextWidget("Supplier Roll : ",
                        state.rollDetails[0].supplierRoll.toString()),
                    rollDetailsTextWidget(
                        "Buyer : ", state.rollDetails[0].buyer.toString()),
                    rollDetailsTextWidget(
                        "Style : ", state.rollDetails[0].style.toString()),
                    rollDetailsTextWidget(
                        "Season : ", state.rollDetails[0].season.toString()),
                    rollDetailsTextWidget(
                        "Color : ", state.rollDetails[0].color.toString()),
                    rollDetailsTextWidget(
                        "Wash : ", state.rollDetails[0].wash.toString()),
                    rollDetailsTextWidget(
                        "Shade : ", state.rollDetails[0].shade.toString()),
                    rollDetailsTextWidget(
                        "Srinkage : ", state.rollDetails[0].shrinks.toString()),
                    rollDetailsTextWidget("Shrink Pattern : ",
                        state.rollDetails[0].shrinkPattern.toString()),
                    rollDetailsTextWidget("Total Length : ",
                        state.rollDetails[0].totalLength.toString()),
                    rollDetailsTextWidget("Remaining Length : ",
                        state.rollDetails[0].remainningLength.toString()),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Text("No Data Found"),
            );
          }
        } else {
          return Container();
        }
      },
    );
  }

  Column rollDetailsTextWidget(String text, String data) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              data,
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ],
    );
  }
}
