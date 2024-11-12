import 'package:student/utils/helper.dart';

class GlobalVariables {
  static final mainNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "main");
  static final homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "home");
  static final addStudentNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: "add_student");
  static final settingsNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: "setting");
}
