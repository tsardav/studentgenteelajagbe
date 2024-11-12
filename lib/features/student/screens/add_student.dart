import 'dart:ui';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:form_validator/form_validator.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:hl_image_picker/hl_image_picker.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:student/components/custom_gradient_button.dart';
import 'package:student/features/home/cubit/fetch_student/student_cubit.dart';
import 'package:student/features/home/cubit/fetch_student/student_state.dart';

import '../../../utils/utils.dart';

class AddStudentScreen extends StatefulWidget {
  static String addStudentRoute = "add_student";
  const AddStudentScreen({super.key});
  @override
  State<AddStudentScreen> createState() => AddStudentScreenState();
}

class AddStudentScreenState extends State<AddStudentScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  final _picker = HLImagePicker();

  setEnrolmentStatus(String value) {
    statusController.text = value;
  }

  File? media;

  pickImage() async {
    try {
      //   final result = await ImagePickers.pickerPaths(
      //     galleryMode: GalleryMode.image,
      //     selectCount: 1,
      //     showCamera: true,
      //   );
      //   log("hello world: $result");

      //   setState(() {
      //     media = File(result.first.path ?? "");
      //   });
      final result = await _picker.openPicker(
        pickerOptions: HLPickerOptions(
          usedCameraButton: true,
          mediaType: MediaType.image,
        ),
      );
      setState(() {
        media = File(result.first.path);
      });
    } catch (e) {
      log("camera error : $e");
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text("Add New Student")
            .textStyle(Styles.x18dp_2FC67E_500w(color: Colors.black)),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: REdgeInsets.only(top: 24, bottom: 8),
                // padding: REdgeInsets.all(31.25),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryTint,
                ),
                child: media == null
                    ? SvgPicture.asset(
                        "assets/svgs/person.svg",
                      ).paddingAll(31.25)
                    : Image.file(
                        media!,
                        fit: BoxFit.fill,
                        width: 100.w,
                        height: 100.h,
                      ),
              ).alignAtCenter(),
              SizedBox(
                height: 24.h,
                child: TextButton(
                    onPressed: () => pickImage(),
                    style: TextButton.styleFrom(
                      padding:
                          REdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      foregroundColor: AppColors.primary,
                    ),
                    child: const Text("Change picture").textStyle(
                      Styles.x12dp_48504C_500w(color: AppColors.primary),
                    )),
              ).alignAtCenter(),
              24.h.heightBox,
              const Text("First name")
                  .textStyle(Styles.x12dp_48504C_500w(color: Colors.black))
                  .paddingOnly(bottom: 8.h),
              TextFormField(
                textInputAction: TextInputAction.next,
                validator: ValidationBuilder().required().build(),
                controller: firstNameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(hintText: "Enter first name"),
              ).paddingOnly(bottom: 20.h),
              const Text("Last name")
                  .textStyle(Styles.x12dp_48504C_500w(color: Colors.black))
                  .paddingOnly(bottom: 8.h),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: lastNameController,
                validator: ValidationBuilder().required().build(),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(hintText: "Enter last name"),
              ).paddingOnly(bottom: 20.h),
              const Text("Email address")
                  .textStyle(Styles.x12dp_48504C_500w(color: Colors.black))
                  .paddingOnly(bottom: 8.h),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: emailController,
                validator: ValidationBuilder().required().email().build(),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration:
                    const InputDecoration(hintText: "Enter email address"),
              ).paddingOnly(bottom: 20.h),
              const Text("Enrolment status")
                  .textStyle(Styles.x12dp_48504C_500w(color: Colors.black))
                  .paddingOnly(bottom: 8.h),
              CustomDropdown<String>(
                validator: ValidationBuilder().required().build(),
                hintText: 'Select job role',
                items: const ['Enrolled', 'Graduated', 'Alumni'],
                initialItem: 'Enrolled',
                decoration: CustomDropdownDecoration(
                  headerStyle: Styles.x14dp_48504C_400w(
                      color: Colors.black.withOpacity(0.7)),
                  closedBorder:
                      Border.all(width: 1.w, color: AppColors.greyLight),
                  expandedBorder: GradientBoxBorder(
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryLight],
                    ),
                    width: 1.w,
                    // borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                onChanged: (value) => setEnrolmentStatus(value ?? ""),
              ).paddingOnly(bottom: 52.h),
              SizedBox(
                width: double.infinity,
                height: 54.h,
                child: BlocListener<StudentCubit, StudentState>(
                    listener: (context, state) {
                      if (state is StudentLoadingState) {
                        return context.loaderOverlay.show();
                      }
                      if (state is StudentLoadedState) {
                        context.loaderOverlay.hide();
                        if (state.isAdd == true) {
                          showSuccessDialog();
                        }
                      }
                      if (state is StudentErrorState) {
                        context.loaderOverlay.hide();
                      }
                    },
                    child: CustomGradientButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            Student student = Student(
                              id: DateTime.now().millisecondsSinceEpoch,
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              email: emailController.text,
                              enrolmentStatus: statusController.text.isEmpty
                                  ? "Enrolled"
                                  : statusController.text,
                            );
                            context.read<StudentCubit>().createStudent(student);
                          }
                        },
                        colors: const [
                          AppColors.primaryDeepLight,
                          AppColors.primary
                        ],
                        text: "Add Student")
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(8.r),
                    //     ),
                    //     elevation: 0,
                    //     backgroundColor: AppColors.primary,
                    //   ),

                    //   child: const Text("Add Student").textStyle(
                    //       Styles.x16dp_2FC67E_500w(color: Colors.white)),
                    // ),
                    ),
              ),
              100.h.heightBox,
            ],
          ).paddingSymmetric(horizontal: 24.w),
        ),
      ),
    );
  }

  showSuccessDialog() async {
    return await showAdaptiveDialog(
      barrierDismissible: false,
      barrierColor: AppColors.primary.withOpacity(0.5),
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: AlertDialog(
          backgroundColor: Colors.white,
          // elevation: 5,
          clipBehavior: Clip.antiAlias,
          titlePadding: EdgeInsets.zero,
          insetPadding: REdgeInsets.symmetric(horizontal: 0),
          iconPadding: EdgeInsets.zero,
          contentPadding: REdgeInsets.symmetric(horizontal: 24),
          content: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                36.h.heightBox,
                SvgPicture.asset("assets/svgs/success.svg"),
                8.h.heightBox,
                Text(
                  "Success",
                  style: Styles.x16dp_2FC67E_700w(color: Colors.black),
                ),
                8.h.heightBox,
                Text(
                  "Student added successfully.",
                  style: Styles.x14dp_48504C_400w(
                      color: Colors.black.withOpacity(0.5)),
                  textAlign: TextAlign.center,
                ),
                24.h.heightBox,
                SizedBox(
                  width: 287.w,
                  height: 48.h,
                  child: CustomGradientButton(
                      onPressed: () {
                        context.pop();
                        context.go("/");
                      },
                      colors: const [
                        AppColors.primaryDeepLight,
                        AppColors.primary
                      ],
                      text: "View Students"),
                ),
                36.h.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
