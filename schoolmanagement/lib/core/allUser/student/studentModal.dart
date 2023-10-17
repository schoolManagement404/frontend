class student {
  //a class to store student data
  final String student_id;
  final String classroom_id;
  final String name;
  final String studentClass;
  final String section;
  final String rollNo;
  final String profilePicUrl;
  final DateTime joinedDate;
  //constructor
  const student(
      {required this.student_id,
      required this.classroom_id,
      required this.name,
      required this.studentClass,
      required this.section,
      required this.rollNo,
      required this.profilePicUrl,
      required this.joinedDate});
  //factory method to convert json to dart object
  factory student.fromJson(Map<String, dynamic> json) {
    return student(
      student_id: json['student_id'],
      classroom_id: json['classroom_id'],
      name: json['name'],
      studentClass: json['studentClass'],
      section: json['section'],
      rollNo: json['rollNo'],
      profilePicUrl: json['profilePicUrl'],
      joinedDate: DateTime.parse(json['joinedDate']),
    );
  }
  //method to convert dart object to json
  Map<String, dynamic> toJson() => {
        'student_id': student_id,
        'classroom_id': classroom_id,
        'name': name,
        'studentClass': studentClass,
        'section': section,
        'rollNo': rollNo,
        'profilePicUrl': profilePicUrl,
        'joinedDate': joinedDate.toIso8601String(),
      };
}
