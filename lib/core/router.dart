import 'package:student/features/settings/screens/screens.dart';
import 'package:student/utils/utils.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  navigatorKey: GlobalVariables.mainNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      pageBuilder: (context, state, navigationShell) =>
          _buildPage(MenuScreen(shell: navigationShell)),
      branches: [
        StatefulShellBranch(
          navigatorKey: GlobalVariables.homeNavigatorKey,
          routes: [
            GoRoute(
              path: "/",
              name: "/",
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: HomeScreen(),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: GlobalVariables.addStudentNavigatorKey,
          routes: [
            GoRoute(
              path: "/${AddStudentScreen.addStudentRoute}",
              name: AddStudentScreen.addStudentRoute,
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: AddStudentScreen(),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: GlobalVariables.settingsNavigatorKey,
          routes: [
            GoRoute(
              path: "/${SettingsScreen.settingsRoute}",
              name: SettingsScreen.settingsRoute,
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: SettingsScreen(),
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);

Page _buildPage(Widget child) {
  return Platform.isIOS
      ? CupertinoPage(child: child)
      : MaterialPage(child: child);
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key, required this.shell});
  final StatefulNavigationShell shell;

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

ValueNotifier<int> tabIndex = ValueNotifier(0);

class _MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
      reverseDuration: const Duration(milliseconds: 2000),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: widget.shell,
      bottomNavigationBar: NavigationBar(
        animationDuration: const Duration(milliseconds: 1200),
        indicatorColor: Colors.transparent,
        backgroundColor: Colors.white,
        elevation: 10.r,
        selectedIndex: widget.shell.currentIndex,
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        onDestinationSelected: (value) {
          widget.shell.goBranch(value,
              initialLocation: value == widget.shell.currentIndex);
        },
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        destinations: [
          NavigationDestination(
            icon: SvgPicture.asset("assets/svgs/home.svg"),
            selectedIcon: SvgPicture.asset("assets/svgs/home_selected.svg"),
            label: "Home",
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 58.w,
                height: 58.h,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(300.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      spreadRadius: 0.r,
                      blurRadius: 16.r,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: SvgPicture.asset(
                  "assets/svgs/add.svg",
                  fit: BoxFit.none,
                ),
              ),
            ],
          ).onTap(() => context.go("/${AddStudentScreen.addStudentRoute}")),
          NavigationDestination(
            icon: SvgPicture.asset("assets/svgs/settings.svg"),
            selectedIcon: SvgPicture.asset("assets/svgs/settings_selected.svg"),
            label: "Settings",
          ),
        ],
      ).paddingSymmetric(horizontal: 12.r),
    );
  }
}
