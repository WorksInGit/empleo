import 'package:empleo/app/common/user_feedback.dart';
import 'package:empleo/app/modules/company/views/company_bottom_nav.dart';
import 'package:empleo/app/modules/company/views/company_login.dart';
import 'package:empleo/app/modules/company/views/company_register.dart';
import 'package:empleo/app/modules/company/views/posts/applicant_profile.dart';
import 'package:empleo/app/modules/company/views/posts/company_applications.dart';
import 'package:empleo/app/modules/company/views/posts/company_posts.dart';
import 'package:empleo/app/modules/company/views/verified_page.dart';
import 'package:empleo/app/modules/user/views/user_bottom_nav.dart';
import 'package:empleo/app/modules/user/views/home/apply_page.dart';
import 'package:empleo/app/modules/user/views/home/job_apply.dart';
import 'package:empleo/app/modules/user/views/user_login.dart';
import 'package:empleo/app/modules/user/views/user_signup.dart';
import 'package:empleo/app/routes/app_routes.dart';
import 'package:empleo/app/common/landing_page.dart';
import 'package:empleo/app/common/selection_page.dart';
import 'package:empleo/app/common/splash_screen.dart';
import 'package:get/route_manager.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: Routes.landing,
      page: () => LandingPage(),
    ),
    GetPage(
      name: Routes.selection,
      page: () => SelectionPage(),
    ),
    GetPage(
      name: Routes.userLogin,
      page: () => UserLogin(),
    ),
    GetPage(
      name: Routes.userHome,
      page: () => BottomNav(),
    ),
    GetPage(
      name: Routes.applyJob,
      page: () => ApplyPage(),
    ),
    GetPage(
      name: Routes.jobApply,
      page: () => JobApply(),
    ),
    GetPage(
      name: Routes.userLogin,
      page: () => UserLogin(),
    ),
    GetPage(
      name: Routes.userLogin,
      page: () => UserLogin(),
    ),
    GetPage(
      name: Routes.userLogin,
      page: () => UserLogin(),
    ),
    GetPage(
      name: Routes.companyLogin,
      page: () => CompanyLogin(),
    ),
    GetPage(name: Routes.companyRegister, page: () => CompanyRegister()),
    GetPage(name: Routes.companyRegister, page: () => CompanyRegister()),
    GetPage(name: Routes.verified, page: () => VerifiedPage()),
    GetPage(name: Routes.companyNav, page: () => CompanyNav()),
    GetPage(name: Routes.companyPosts, page: () => CompanyPosts()),
    GetPage(name: Routes.application, page: () => CompanyApplications()),
    GetPage(name: Routes.applicantProfile, page: () => ApplicantProfile()),
    GetPage(name: Routes.feedback, page: () => UserFeedback()),
    GetPage(
      name: Routes.signUp,
      page: () => UserSignUp(),
    ),
    GetPage(
      name: Routes.userLogin,
      page: () => UserLogin(),
    ),
  ];
}
