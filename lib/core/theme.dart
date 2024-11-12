import '../utils/utils.dart';

class AppTheme {
  static ThemeData lightTheme() => ThemeData(
        scaffoldBackgroundColor: Colors.black,
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          isCollapsed: true,
          filled: true,
          hintStyle: Styles.x12dp_48504C_400w(color: AppColors.greySubtle),
          contentPadding: REdgeInsets.symmetric(vertical: 16, horizontal: 20),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.w, color: AppColors.greyLight),
            borderRadius: BorderRadius.circular(8.r),
          ),
          focusedBorder: GradientOutlineInputBorder(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.primaryLight],
            ),
            width: 1.w,
            borderRadius: BorderRadius.circular(8.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.w, color: AppColors.red),
            borderRadius: BorderRadius.circular(8.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.w, color: AppColors.red),
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          labelTextStyle:
              WidgetStateProperty.resolveWith((Set<WidgetState> state) {
            if (!state.contains(WidgetState.selected)) {
              return Styles.x10dp_48504C_500w(color: AppColors.greySubtle);
            } else {
              return Styles.x10dp_48504C_500w(color: AppColors.primary);
            }
          }),
        ),
      );
}
