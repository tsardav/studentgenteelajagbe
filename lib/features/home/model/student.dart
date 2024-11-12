import 'package:student/utils/utils.dart';

class Student {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String enrolmentStatus;
  final String? image;

  Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.enrolmentStatus,
    this.image,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      enrolmentStatus: json['enrolment_status'],
      image: json['image'] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'enrolment_status': enrolmentStatus,
        'image': image,
      };

  String get fullName => "$firstName $lastName";

  Color get enrolmentStatusColor => switch (enrolmentStatus) {
        "Enrolled" => AppColors.green,
        "Graduated" => Colors.orange,
        _ => AppColors.red,
      };
}
