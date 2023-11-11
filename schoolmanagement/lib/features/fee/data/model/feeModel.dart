// ignore_for_file: non_constant_identifier_names

class StudentFee {
  final String student_id;
  final String fee_month;
  final int monthly_fee;
  final int? exam_fee;
  final int? extracurricular_fee;
  final int? discount_scholarship;
  final int? late_charge;
  final int? paid_fee;
  final int? bus_fee;

  StudentFee({
    required this.student_id,
    required this.fee_month,
    required this.monthly_fee,
    required this.exam_fee,
    required this.extracurricular_fee,
    required this.discount_scholarship,
    required this.late_charge,
    required this.paid_fee,
    required this.bus_fee,
  });

  factory StudentFee.fromJson(Map<String, dynamic> json) {
    return StudentFee(
      student_id: json['student_id'],
      fee_month: json['fee_month'],
      monthly_fee: json['monthly_fee'],
      exam_fee: json['exam_fee'],
      extracurricular_fee: json['extracurricular_fee'],
      discount_scholarship: json['discount_scholarship'],
      late_charge: json['late_charge'],
      paid_fee: json['paid_fee'],
      bus_fee: json['bus_fee'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student_id': student_id,
      'fee_month': fee_month,
      'monthly_fee': monthly_fee,
      'exam_fee': exam_fee,
      'extracurricular_fee': extracurricular_fee,
      'discount_scholarship': discount_scholarship,
      'late_charge': late_charge,
      'paid_fee': paid_fee,
      'bus_fee': bus_fee,
    };
  }
}
