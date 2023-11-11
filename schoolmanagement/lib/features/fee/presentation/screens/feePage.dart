import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolmanagement/features/fee/bloc/fee_bloc.dart';

import '../../../../core/Error/loadingScreen/loadingScreen.dart';

class feePage extends StatelessWidget {
  const feePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FeeBloc>().add(fetchFeeEvent(student_id: '12'));
    return BlocConsumer<FeeBloc, FeeState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
              context: context, text: state.message ?? "Please wait a moment");
        } else {
          LoadingScreen().hide();
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
                                      'School fee for ${state.feeList[index].fee_month}'),
                                  Text(
                                    'Remaining Rs: ${state.feeList[index].monthly_fee + (state.feeList[index].exam_fee ?? 0) + (state.feeList[index].extracurricular_fee ?? 0) + (state.feeList[index].late_charge ?? 0) - (state.feeList[index].discount_scholarship ?? 0) - (state.feeList[index].paid_fee ?? 0)}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              IconButton(
                                icon: Icon(state.expandedStates![index]
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down),
                                onPressed: () {
                                  context.read<FeeBloc>().add(
                                        toggleExpansionEvent(index: index),
                                      );
                                },
                              ),
                            ],
                          ),
                          if (state.expandedStates![index])
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                children: [
                                  Text(
                                      "Monthly fee: ${state.feeList[index].monthly_fee}"),
                                  Text(
                                      "Exam Fee: ${state.feeList[index].exam_fee ?? 0}"),
                                  Text(
                                      "Extra Curricular fee: ${state.feeList[index].extracurricular_fee ?? 0}"),
                                  Text(
                                      "Late Charge: ${state.feeList[index].late_charge ?? 0}"),
                                  Text(
                                      "Discount: ${state.feeList[index].discount_scholarship ?? 0}"),
                                  Text(
                                      "Paid fee: ${state.feeList[index].paid_fee ?? 0}"),
                                  Text(
                                    'Remaining: ${state.feeList[index].monthly_fee + (state.feeList[index].exam_fee ?? 0) + (state.feeList[index].extracurricular_fee ?? 0) + (state.feeList[index].late_charge ?? 0) - (state.feeList[index].discount_scholarship ?? 0) - (state.feeList[index].paid_fee ?? 0)}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
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
            child: Text("no data"),
          ));
        }
      },
    );
  }
}
