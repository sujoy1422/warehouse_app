import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:warehouse_app/cubit/searchable_roll_list/searchable_roll_list_cubit.dart';
import 'package:warehouse_app/models/roll_details.dart';
import 'package:warehouse_app/models/searchable_roll_list.dart';
import 'package:warehouse_app/repository/searchable_roll_list_repo/searchable_roll_list_repo_impl.dart';
import 'package:warehouse_app/views/logout_widget.dart';
import 'package:warehouse_app/views/roll_details.dart';

TextEditingController? searchedTextRollList;

class SearchRoll extends StatelessWidget {
  const SearchRoll({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Search Roll details"),
          actions: [LogoutWidget()],
        ),
        body: BlocProvider(
          create: (context) =>
              SearchableRollListCubit(SearchableRollListRepoImpl()),
          child: SearchRollScreen(),
        ));
  }
}

class SearchRollScreen extends StatefulWidget {
  const SearchRollScreen({super.key});

  @override
  State<SearchRollScreen> createState() => _SearchRollScreenState();
}

class _SearchRollScreenState extends State<SearchRollScreen> {
  int selectedSearchOption = 1;

  @override
  void initState() {
    context.read<SearchableRollListCubit>().searchableRollList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int index;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        child: BlocConsumer<SearchableRollListCubit, SearchableRollListState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is SearchableRollListLoaded) {
              return Column(
                children: [
                  Row(children: [
                    SizedBox(
                      width: 50,
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
                        Text("Search by Roll no"),
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
                  ]),
                  Container(
                    height: height * 0.76,
                    width: width * 0.9,
                    child: SearchableList(
                      onItemSelected: (p0) {
                        // index = p0 as int;
                        print("index: $p0");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RolLDetails(rfid: p0.rollNo),
                          ),
                        );
                      },
                      searchTextController: searchedTextRollList,
                      builder: (SearchableRollList searchableRollList) => Card(
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.all(5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text("Roll No. : ",
                                          style: TextStyle(
                                              fontWeight:
                                                  selectedSearchOption == 1
                                                      ? FontWeight.bold
                                                      : FontWeight.normal)),
                                      Text(
                                        searchableRollList.rollNo.toString(),
                                        style: TextStyle(
                                            fontWeight:
                                                selectedSearchOption == 1
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Factory Roll No. : ",
                                          style: TextStyle(
                                              fontWeight:
                                                  selectedSearchOption == 2
                                                      ? FontWeight.bold
                                                      : FontWeight.normal)),
                                      Text(
                                          searchableRollList.factoryRoll
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight:
                                                  selectedSearchOption == 2
                                                      ? FontWeight.bold
                                                      : FontWeight.normal)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Pallet No. : "),
                                      Text(
                                          searchableRollList.pallet.toString()),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Bin No. : "),
                                      Text(
                                          "${searchableRollList.binSlNo} ( ${searchableRollList.bin.toString()} )"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Rack No. : "),
                                      Text(
                                          searchableRollList.rackNo.toString()),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                              child: Row(
                                children: [
                                  Text("See Details"),
                                  Icon(Icons.arrow_forward_ios_outlined)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      asyncListCallback: () async {
                        await Future.delayed(
                          const Duration(
                            milliseconds: 1,
                          ),
                        );
                        return state.searchableRollList;
                      },
                      asyncListFilter: (q, list) {
                        if (selectedSearchOption == 1) {
                          return list
                              .where((element) => element.rollNo.contains(
                                  searchedTextRollList?.value.toString() ?? q))
                              .toList();
                        } else {
                          return list
                              .where((element) => element.factoryRoll.contains(
                                  searchedTextRollList?.value.toString() ?? q))
                              .toList();
                        }
                      },
                      // onItemSelected: (RollData item) {
                      //   print(item);
                      // },
                      inputDecoration: InputDecoration(
                        labelText: selectedSearchOption == 1
                            ? "Enter RFID No."
                            : "Enter Factory Roll No.",
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
                  )
                ],
              );
            } else {
              return Center(child: Text("No rolls avaible"));
            }
          },
        ),
      ),
    );
  }
}
