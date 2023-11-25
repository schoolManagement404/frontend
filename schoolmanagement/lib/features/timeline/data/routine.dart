class Routine {
  final String subject;
  final String teacher;
  final DateTime startTime;
  final int length;

  const Routine(
      {required this.subject,
      required this.teacher,
      required this.startTime,
      required this.length});

  factory Routine.fromJson(Map<String, dynamic> json) {
    return Routine(
      subject: json['subject'],
      teacher: json['teacher'],
      startTime: json['startTime'],
      length: json['length'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'teacher': teacher,
      'startTime': startTime,
      'length': length,
    };
  }

  @override
  String toString() {
    return 'Routine{subject: $subject, teacher: $teacher, startTime: $startTime, length: $length}';
  }
}
