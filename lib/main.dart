import 'dart:ui';

import 'package:loader_overlay/loader_overlay.dart';
import 'package:student/features/home/cubit/fetch_student/student_cubit.dart';
import 'package:student/utils/helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StudentCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: false,
        fontSizeResolver: FontSizeResolvers.height,
        builder: (context, child) {
          return GlobalLoaderOverlay(
            overlayWholeScreen: true,
            overlayWidgetBuilder: (progress) =>
                const GlobalLoaderOverlayWidget(),
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: router,
              // theme: ThemeData.light(),
              theme: AppTheme.lightTheme(),
            ),
          );
        },
      ),
    );
  }
}

class GlobalLoaderOverlayWidget extends StatelessWidget {
  const GlobalLoaderOverlayWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      key: const Key("overlay key"),
      // key: GlobalLoaderOverlayWidget.showHideOverlayIconKey,
      filter: ImageFilter.blur(sigmaX: 5.5, sigmaY: 5.5),
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 1.w,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
