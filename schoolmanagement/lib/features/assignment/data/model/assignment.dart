// ignore_for_file: non_constant_identifier_names

class assignment {
  final String classroom_id;
  final String teacher_id;
  final String subject_id;
  final String? assignment_id;
  final String assignment_name;
  final String assignment_description;
  final DateTime assignment_deadline;
  final DateTime created_date;
  final String assignment_file;

  assignment({
    this.assignment_id,
    required this.classroom_id,
    required this.teacher_id,
    required this.subject_id,
    required this.assignment_name,
    required this.assignment_description,
    required this.assignment_file,
    required this.assignment_deadline,
    required this.created_date,
  });
  //factory constructior to convert json to dart object
  factory assignment.fromJson(Map<String, dynamic> json) => assignment(
        assignment_id: json['assignment_id'],
        classroom_id: json['classroom_id'],
        teacher_id: json['teacher_id'],
        subject_id: json['subject_id'],
        assignment_name: json['assignment_name'],
        assignment_description: json['assignment_description'],
        assignment_file: json['assignment_file'],
        assignment_deadline: DateTime.parse(json['assignment_deadline']),
        created_date: DateTime.parse(json['created_date']),
      );
  //method to convert dart object to json
  Map<String, dynamic> toJson() => {
        'assignment_id': assignment_id,
        'classroom_id': classroom_id,
        'teacher_id': teacher_id,
        'subject_id': subject_id,
        'assignment_name': assignment_name,
        'assignment_description': assignment_description,
        'assignment_file': assignment_file,
        'assignment_deadline': assignment_deadline.toIso8601String(),
        'created_date': created_date.toIso8601String(),
      };
}
