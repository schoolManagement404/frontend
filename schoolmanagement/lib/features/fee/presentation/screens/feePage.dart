import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolmanagement/features/fee/bloc/fee_bloc.dart';
import 'package:schoolmanagement/features/home/presentation/widget/Appbar.dart';

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
            appBar: CustomAppBar(
              parentContext: context,
            ),
            body: SafeArea(
              child: Column(
                children: [
                  CustomHeader(
                    headerText: 'Fee Details',
                    parentContext: context,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.feeList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 12, 54, 88),
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'School fee for ${state.feeList[index].fee_month}',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            'Remaining Rs: ${state.feeList[index].monthly_fee + (state.feeList[index].exam_fee ?? 0) + (state.feeList[index].extracurricular_fee ?? 0) + (state.feeList[index].late_charge ?? 0) - (state.feeList[index].discount_scholarship ?? 0) - (state.feeList[index].paid_fee ?? 0)}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: (state.feeList[index]
                                                            .monthly_fee +
                                                        (state.feeList[index]
                                                                .exam_fee ??
                                                            0) +
                                                        (state.feeList[index]
                                                                .extracurricular_fee ??
                                                            0) +
                                                        (state.feeList[index]
                                                                .late_charge ??
                                                            0) -
                                                        (state.feeList[index]
                                                                .discount_scholarship ??
                                                            0) -
                                                        (state.feeList[index]
                                                                .paid_fee ??
                                                            0)) ==
                                                    0
                                                ? Colors.green
                                                : const Color.fromARGB(
                                                    255, 211, 127, 121),
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Text((state.feeList[index]
                                                        .monthly_fee +
                                                    (state.feeList[index]
                                                            .exam_fee ??
                                                        0) +
                                                    (state.feeList[index]
                                                            .extracurricular_fee ??
                                                        0) +
                                                    (state.feeList[index]
                                                            .late_charge ??
                                                        0) -
                                                    (state.feeList[index]
                                                            .discount_scholarship ??
                                                        0) -
                                                    (state.feeList[index]
                                                            .paid_fee ??
                                                        0)) ==
                                                0
                                            ? 'Paid'
                                            : 'Unpaid'),
                                      ),
                                      IconButton(
                                        color: Colors.white,
                                        icon: Icon(state.expandedStates![index]
                                            ? Icons.arrow_drop_up
                                            : Icons.arrow_drop_down),
                                        onPressed: () {
                                          context.read<FeeBloc>().add(
                                                toggleExpansionEvent(
                                                    index: index),
                                              );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (state.expandedStates![index])
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Monthly fee: ${state.feeList[index].monthly_fee}",
                                    ),
                                    Text(
                                      "Exam Fee: ${state.feeList[index].exam_fee ?? 0}",
                                    ),
                                    Text(
                                      "Extra Curricular fee: ${state.feeList[index].extracurricular_fee ?? 0}",
                                    ),
                                    Text(
                                      "Late Charge: ${state.feeList[index].late_charge ?? 0}",
                                    ),
                                    Text(
                                      "Discount: ${state.feeList[index].discount_scholarship ?? 0}",
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total: ${state.feeList[index].monthly_fee + (state.feeList[index].exam_fee ?? 0) + (state.feeList[index].extracurricular_fee ?? 0) + (state.feeList[index].late_charge ?? 0) - (state.feeList[index].discount_scholarship ?? 0)}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "Paid fee: ${state.feeList[index].paid_fee ?? 0}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                          'Remaining: ${state.feeList[index].monthly_fee + (state.feeList[index].exam_fee ?? 0) + (state.feeList[index].extracurricular_fee ?? 0) + (state.feeList[index].late_charge ?? 0) - (state.feeList[index].discount_scholarship ?? 0) - (state.feeList[index].paid_fee ?? 0)}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
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
