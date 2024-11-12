import 'package:student/utils/helper.dart';

final repository = RepoProvider().provideRepository();

class RepoProvider {
  StudentRepository provideRepository() => StudentRepository(ApiServices());
}
