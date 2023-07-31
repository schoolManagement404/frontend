class assignment {
  final String classroom_id;
  final String teacher_id;
  final String subject_id;
  final String assignment_id;
  final String assignment_name;
  final String assignment_description;
  final DateTime assignment_deadline;
  final DateTime created_date;
  final String assignment_file;

  assignment({
    required this.classroom_id,
    required this.teacher_id,
    required this.subject_id,
    required this.assignment_id,
    required this.assignment_name,
    required this.assignment_description,
    required this.assignment_deadline,
    required this.created_date,
    required this.assignment_file,
  });
  //factory constructior to convert json to dart object
  factory assignment.fromJson(Map<String, dynamic> json) => assignment(
        classroom_id: json['classroom_id'],
        teacher_id: json['teacher_id'],
        subject_id: json['subject_id'],
        assignment_id: json['assignment_id'],
        assignment_name: json['assignment_name'],
        assignment_description: json['assignment_description'],
        assignment_deadline: DateTime.parse(json['assignment_deadline']),
        created_date: DateTime.parse(json['created_date']),
        assignment_file: json['assignment_file'],
      );
  //method to convert dart object to json
  Map<String, dynamic> toJson() => {
        'classroom_id': classroom_id,
        'teacher_id': teacher_id,
        'subjecct_id': subject_id,
        'assigmnet_id': assignment_id,
        'assignment_name': assignment_name,
        'assignment_description': assignment_description,
        'assignment_deadline': assignment_deadline.toIso8601String(),
        'created_date': created_date.toIso8601String(),
        'assignment_file': assignment_file,
      };
}
