import '../../../utils/utils.dart';

class StudentRepository {
  final ApiServices _apiServices;
  // final DatabaseManager _databaseManager = DatabaseManager();
  // final CacheStorage _cacheStorage = CacheStorage();

  StudentRepository(this._apiServices);

  Future<Either<Failure, ApiResponseImpl<List<Student>>>>
      fetchStudent() async => await _apiServices.fetchStudent();

  Future<Either<Failure, ApiResponseImpl<String>>> delete(int id) async =>
      await _apiServices.delete(studentId: id);
  Future<Either<Failure, ApiResponseImpl<Student>>> createStudent(
          Student student) async =>
      await _apiServices.createStudent(student: student);
}
