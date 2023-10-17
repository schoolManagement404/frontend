import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolmanagement/features/fee/bloc/fee_bloc.dart';

import '../../../../core/Error/loadingScreen/loadingScreen.dart';

class feePage extends StatefulWidget {
  const feePage({super.key});

  @override
  State<feePage> createState() => _feePageState();
}

class _feePageState extends State<feePage> {
  List<bool> _expandedStates = List.generate(10, (index) => false);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeeBloc, FeeState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
              context: context, text: state.message ?? "Please wait a moment");
        } else {
          LoadingScreen().hide();
        }
        if (state is toggleExpansionState) {
          _expandedStates[state.index] = !_expandedStates[state.index];
        }
      },
      builder: (context, state) {
        if (state is feeErrorState) {
          return Scaffold(
            body: Center(
              child: Text("Error ${state.message!}"),
            ),
          );
        } else if (state is FeeLoadedState) {
          return Scaffold(
            body: ListView.builder(
              itemCount: state.feeList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      color: Colors.blue,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                      'School fee for ${state.feeList[index].feeMonth}'),
                                  Text('Rs: ${state.feeList[index].toPayFee}')
                                ],
                              ),
                              Text(state.feeList[index].toPayFee ==
                                      state.feeList[index].paidFee
                                  ? 'Paid'
                                  : 'Due'),
                              IconButton(
                                icon: Icon(_expandedStates[index]
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down),
                                onPressed: () => context
                                    .read<FeeBloc>()
                                    .add(toggleExpansionEvent(index: index)),
                              ),
                            ],
                          ),
                          if (_expandedStates[index])
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                  'Additional content for Item ${index + 1}'),
                            ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        } else {
          return const Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        }
      },
    );
  }
}
