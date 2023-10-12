import 'package:flutter/material.dart';
import 'package:warehouse_app/views/logout_widget.dart';

class SearchByStyleDetails extends StatelessWidget {
  const SearchByStyleDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Style Details"),
        actions: [LogoutWidget()],
      ),
      body: SearchByStyleDetailsView(),
    );
  }
}

class SearchByStyleDetailsView extends StatefulWidget {
  const SearchByStyleDetailsView({super.key});

  @override
  State<SearchByStyleDetailsView> createState() => _SearchByStyleDetailsViewState();
}

class _SearchByStyleDetailsViewState extends State<SearchByStyleDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
