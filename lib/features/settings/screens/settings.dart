import '../../../utils/utils.dart';

class SettingsScreen extends StatefulWidget {
  static String settingsRoute = "settings";
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const Text("Settings")
                  .textStyle(Styles.x18dp_2FC67E_500w())
                  .paddingOnly(bottom: 16.r)
                  .alignAtCenterLeft(),
              300.h.heightBox,
              const Text("Coming soon...")
                  .textStyle(Styles.x18dp_2FC67E_500w()),
            ],
          ).paddingSymmetric(horizontal: 24.r),
        ),
      ),
    );
  }
}
