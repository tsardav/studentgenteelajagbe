import 'package:student/utils/helper.dart';

class StudentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StudentInitialState extends StudentState {}

class StudentLoadingState extends StudentState {
  final bool isFetching;
  StudentLoadingState({this.isFetching = false});

  @override
  List<Object?> get props => [isFetching];
}

class StudentLoadedState extends StudentState {
  final List<Student> studentList;
  final bool? isAdd;
  StudentLoadedState({required this.studentList, this.isAdd});
  @override
  List<Object?> get props => [studentList];
}

class StudentErrorState extends StudentState {
  final String error;
  StudentErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}
