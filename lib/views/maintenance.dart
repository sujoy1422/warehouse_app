import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/cubit/maintainance/maintainance_cubit.dart';
import 'package:warehouse_app/repository/maintainance_repo/maintainance_repo_impl.dart';
import 'package:warehouse_app/views/logout_widget.dart';

class Maintainance extends StatelessWidget {
  const Maintainance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Maintenance Screen"),
          actions: const [LogoutWidget()],
        ),
        body: BlocProvider(
          create: (context) => MaintainanceCubit(MaintainanceRepoImpl()),
          child: const MaintainanceScreen(),
        ));
  }
}

class MaintainanceScreen extends StatefulWidget {
  const MaintainanceScreen({super.key});

  @override
  State<MaintainanceScreen> createState() => _MaintainanceScreenState();
}

class _MaintainanceScreenState extends State<MaintainanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
            color: Colors.black.withOpacity(0.5), // Semi-transparent background
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
);
  }
}