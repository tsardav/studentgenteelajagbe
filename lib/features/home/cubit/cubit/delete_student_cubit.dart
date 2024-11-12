import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'delete_student_state.dart';

class DeleteStudentCubit extends Cubit<DeleteStudentState> {
  DeleteStudentCubit() : super(DeleteStudentInitial());
}
