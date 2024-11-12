import 'package:student/features/home/cubit/fetch_student/student_state.dart';

import '../../../../utils/utils.dart';

class StudentCubit extends Cubit<StudentState> {
  StudentCubit() : super(StudentInitialState());

  List<Student> studentList = [];

  fetchStudents(String query) async {
    emit(StudentLoadingState());
    if (query.isNotEmpty) {
      final result = studentList
          .where((element) =>
              element.firstName.toLowerCase().contains(query.toLowerCase()) ||
              element.lastName.toLowerCase().contains(query.toLowerCase()) ||
              element.email.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(StudentLoadedState(studentList: result));
    } else {
      final response = await repository.fetchStudent();
      response.fold(
          ifLeft: (l) => emit(StudentErrorState(error: l.failureMessage())),
          ifRight: (r) {
            studentList = r.dataList ?? [];
            emit(StudentLoadedState(studentList: r.dataList ?? []));
          });
    }
  }

  onSearchStudent(String query) async {
    emit(StudentLoadingState());
    final response = await repository.fetchStudent();
    response.fold(
        ifLeft: (l) => emit(StudentErrorState(error: l.failureMessage())),
        ifRight: (r) {
          studentList = r.dataList ?? [];
          emit(StudentLoadedState(studentList: r.dataList ?? []));
        });
  }

  deleteStudent(int id) async {
    emit(StudentLoadingState());
    final response = await repository.delete(id);
    response.fold(
        ifLeft: (l) => emit(StudentErrorState(error: l.failureMessage())),
        ifRight: (r) {
          studentList.removeWhere((element) => element.id == id);
          emit(StudentLoadedState(studentList: studentList));
        });
  }

  createStudent(Student student) async {
    emit(StudentLoadingState());
    final response = await repository.createStudent(student);
    response.fold(
        ifLeft: (l) => emit(StudentErrorState(error: l.failureMessage())),
        ifRight: (r) {
          studentList.add(r.data as Student);
          emit(StudentLoadedState(studentList: studentList, isAdd: true));
        });
  }
}
