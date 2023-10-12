import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:warehouse_app/cubit/style_wise_count_cubit/style_wise_count_cubit.dart';
import 'package:warehouse_app/cubit/style_wise_roll/style_wise_roll_cubit.dart';
import 'package:warehouse_app/models/style_wise_count.dart';
import 'package:warehouse_app/repository/style_wise_count_repo/style_wise_count_repo_impl.dart';
import 'package:warehouse_app/repository/style_wise_roll_repo/style_wise_roll_repo_impl.dart';
import 'package:warehouse_app/views/logout_widget.dart';

TextEditingController? searchedTextStyleList;

class SearchByStyle extends StatelessWidget {
  const SearchByStyle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [LogoutWidget()],
        title: Text("Search By Style"),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => StyleWiseCountCubit(StyleWiseCountRepoImpl()),
          ),
          BlocProvider(
            create: (context) => StyleWiseRollCubit(StyleWiseRollRepoImpl()),
          ),
        ],
        child: SearchByStyleView(),
      ),
    );
  }
}

class SearchByStyleView extends StatefulWidget {
  const SearchByStyleView({super.key});

  @override
  State<SearchByStyleView> createState() => _SearchByStyleViewState();
}

class _SearchByStyleViewState extends State<SearchByStyleView> {
  @override
  void initState() {
    context.read<StyleWiseCountCubit>().searchableCountList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StyleWiseCountCubit, StyleWiseCountState>(
        listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      if (state is StyleWiseCountLoaded) {
        return Container(
          padding: EdgeInsets.all(20),
          child: SearchableList(
            onItemSelected: (p0) {
              // index = p0 as int;
              print("index: $p0");
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => RolLDetails(rfid: p0.rollNo),
              //   ),
              // );
            },
            searchTextController: searchedTextStyleList,
            builder: (StyleWiseCount styleWiseCountList) => Card(
              child: ExpansionTile(
                title: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Style : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              Text(
                                styleWiseCountList.style.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Buyer : ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal)),
                              Text(styleWiseCountList.buyer.toString(),
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal)),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Season : "),
                              Text(styleWiseCountList.season.toString()),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Color : "),
                              Text("${styleWiseCountList.season}"),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Wash : "),
                              Text(styleWiseCountList.wash.toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      child: Text(
                        "Total Roll: ${styleWiseCountList.totalRoll} pcs",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 10,
                      width: 10,
                    )
                  ],
                ),
                children: [
                  BlocConsumer<StyleWiseRollCubit, StyleWiseRollState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      if (state is StyleWiseRollLoaded) {
                        return DataTable(columns: <DataColumn>[
                          DataColumn(label: Expanded(child: Text("Roll"))),
                          DataColumn(label: Expanded(child: Text("Pallet"))),
                          DataColumn(label: Expanded(child: Text("Bin"))),
                          DataColumn(label: Expanded(child: Text("Rack "))),
                        ], rows: <DataRow>[
                          for (int i = 0; i < state.styleWiseRoll.length; i++)
                            DataRow(
                              cells: <DataCell>[
                                DataCell(
                                    Text("${state.styleWiseRoll[i].rollNo}")),
                                DataCell(
                                    Text("${state.styleWiseRoll[i].palletId}")),
                                DataCell(Text("${state.styleWiseRoll[i].bin}")),
                                DataCell(
                                    Text("${state.styleWiseRoll[i].rackNo}")),
                              ],
                            ),
                        ]);
                      } else if (state is StyleWiseRollLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Container();
                      }
                    },
                  )
                ],
                onExpansionChanged: (value) {
                  // setState(() {
                  print(styleWiseCountList.systemId);
                  context
                      .read<StyleWiseRollCubit>()
                      .searchableRollList(styleWiseCountList.systemId);
                  // });
                },
              ),
            ),
            asyncListCallback: () async {
              await Future.delayed(
                const Duration(
                  milliseconds: 1,
                ),
              );
              return state.styleWiseCount;
            },
            asyncListFilter: (q, list) {
              return list
                  .where((element) => element.systemId
                      .contains(searchedTextStyleList?.value.toString() ?? q))
                  .toList();
            },
            // onItemSelected: (RollData item) {
            //   print(item);
            // },
            inputDecoration: InputDecoration(
              labelText: "Enter Style No.",
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
    });
  }
}
