class StudentFee {
  final int studentId;
  final String feeMonth;
  final double monthlyFee;
  final double examFee;
  final double extraCircularFee;
  final DateTime lastPaymentDate;
  final double totalFee;
  final double discountOrScholarship;
  final double lateCharge;
  final double toPayFee;
  final double dueFee;
  final double paidFee;

  StudentFee({
    required this.studentId,
    required this.feeMonth,
    required this.monthlyFee,
    required this.examFee,
    required this.extraCircularFee,
    required this.lastPaymentDate,
    required this.totalFee,
    required this.discountOrScholarship,
    required this.lateCharge,
    required this.toPayFee,
    required this.dueFee,
    required this.paidFee,
  });

  factory StudentFee.fromJson(Map<String, dynamic> json) {
    return StudentFee(
      studentId: json['studentId'],
      feeMonth: json['feeMonth'],
      monthlyFee: json['monthlyFee'],
      examFee: json['examFee'],
      extraCircularFee: json['extraCircularFee'],
      lastPaymentDate: DateTime.parse(json['lastPaymentDate']),
      totalFee: json['totalFee'],
      discountOrScholarship: json['discountOrScholarship'],
      lateCharge: json['lateCharge'],
      toPayFee: json['toPayFee'],
      dueFee: json['dueFee'],
      paidFee: json['paidFee'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'feeMonth': feeMonth,
      'monthlyFee': monthlyFee,
      'examFee': examFee,
      'extraCircularFee': extraCircularFee,
      'lastPaymentDate': lastPaymentDate.toIso8601String(),
      'totalFee': totalFee,
      'discountOrScholarship': discountOrScholarship,
      'lateCharge': lateCharge,
      'toPayFee': toPayFee,
      'dueFee': dueFee,
      'paidFee': paidFee,
    };
  }
}
