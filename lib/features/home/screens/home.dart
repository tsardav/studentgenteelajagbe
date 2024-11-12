import 'package:loader_overlay/loader_overlay.dart';
import 'package:student/components/custom_gradient_button.dart';
import 'package:student/components/sliver_delegate.dart';
import 'package:student/features/home/cubit/fetch_student/student_cubit.dart';
import 'package:student/features/home/cubit/fetch_student/student_state.dart';

import '../../../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  static String homeRoute = "home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<StudentCubit>().fetchStudents("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: SliverAppBarDelegate(
                minHeight: 100.h,
                maxHeight: 100.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Students")
                        .textStyle(Styles.x18dp_2FC67E_500w())
                        .paddingOnly(bottom: 16.r),
                    TextField(
                      onChanged: (value) =>
                          context.read<StudentCubit>().fetchStudents(value),
                      decoration: InputDecoration(
                        hintStyle: Styles.x14dp_48504C_400w(
                            color: AppColors.greySubtle),
                        prefixIcon: SvgPicture.asset(
                          "assets/svgs/search.svg",
                          fit: BoxFit.none,
                        ),
                        // fillColor: AppColors.greySubtle.withOpacity(0.3),
                        hintText: "Search student",
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 24),
              ),
              pinned: true,
              floating: true,
            ),
            SliverFillRemaining(
              child: BlocConsumer<StudentCubit, StudentState>(
                listener: (context, state) {
                  if (state is StudentLoadingState) {
                    if (state.isFetching) {
                      context.loaderOverlay.show();
                    }
                  }
                  if (state is StudentLoadedState) {
                    context.loaderOverlay.hide();
                  }

                  if (state is StudentErrorState) {
                    context.loaderOverlay.hide();
                  }
                },
                builder: (context, state) {
                  if (state is StudentLoadingState) {
                    return state.isFetching
                        ? const Center(child: CircularProgressIndicator())
                        : const SizedBox.shrink();
                  }
                  if (state is StudentLoadedState) {
                    return state.studentList.isEmpty
                        ? Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Text("Empty!!!").textStyle(
                                  Styles.x16dp_2FC67E_600w(
                                      color: Colors.black)),
                              12.h.heightBox,
                              const Text("No student found")
                                  .textStyle(Styles.x14dp_48504C_400w()),
                              8.h.heightBox,
                              SizedBox(
                                width: 170.w,
                                child: CustomGradientButton(
                                  onPressed: () => context.go(
                                      "/${AddStudentScreen.addStudentRoute}"),
                                  colors: const [
                                    AppColors.primaryDeepLight,
                                    AppColors.primary
                                  ],
                                  text: "Add Student",
                                ),
                              )
                            ],
                          ).paddingOnly(top: 250.h)
                        : GridView.builder(
                            padding: REdgeInsets.symmetric(
                                vertical: 16, horizontal: 24),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20.w,
                              mainAxisSpacing: 20.h,
                              childAspectRatio: 0.77,
                            ),
                            itemBuilder: (context, index) => Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 153.h,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                      child: Image.asset(
                                        "assets/images/student.png",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    8.h.heightBox,
                                    Text(state.studentList[index].fullName)
                                        .textStyle(
                                      Styles.x10dp_48504C_500w(
                                          color: Colors.black),
                                    ),
                                    2.h.heightBox,
                                    Text(state.studentList[index].email)
                                        .textStyle(
                                      Styles.x10dp_48504C_500w(
                                          color: Colors.black.withOpacity(0.5)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: REdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100.r),
                                        color: state.studentList[index]
                                            .enrolmentStatusColor,
                                      ),
                                      child: Text(state.studentList[index]
                                              .enrolmentStatus)
                                          .textStyle(Styles.x8dp_48504C_400w(
                                              color: Colors.white)),
                                    ),
                                    const Spacer(),
                                    SvgPicture.asset(
                                      "assets/svgs/delete.svg",
                                      fit: BoxFit.none,
                                    ).onTap(() {
                                      context
                                          .read<StudentCubit>()
                                          .deleteStudent(
                                              state.studentList[index].id);
                                    }),
                                  ],
                                ).paddingOnly(top: 8.w, left: 8.w, right: 8.r),
                              ],
                            ),
                            itemCount: state.studentList.length,
                          );
                  }
                  return Container();
                },
              ),
            )
          ],
        ).paddingSymmetric(horizontal: 0),
      ),
    );
  }
}
