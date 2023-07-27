import 'package:equatable/equatable.dart';

class Calendar extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String color;

  const Calendar({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.color,
  });

  @override
  List<Object?> get props => [id, title, description, date, color];

// May need to modify this method to match the data model
  factory Calendar.fromJson(Map<String, dynamic> json) => Calendar(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        date: DateTime.parse(json["date"]),
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "date": date.toIso8601String(),
        "color": color,
      };
}
