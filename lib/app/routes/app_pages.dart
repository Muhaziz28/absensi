import 'package:get/get.dart';

import '../modules/add_anak/bindings/add_anak_binding.dart';
import '../modules/add_anak/views/add_anak_view.dart';
import '../modules/add_istri/bindings/add_istri_binding.dart';
import '../modules/add_istri/views/add_istri_view.dart';
import '../modules/add_personil/bindings/add_personil_binding.dart';
import '../modules/add_personil/views/add_personil_view.dart';
import '../modules/add_riwayat_pendidikan/bindings/add_riwayat_pendidikan_binding.dart';
import '../modules/add_riwayat_pendidikan/views/add_riwayat_pendidikan_view.dart';
import '../modules/agama/bindings/agama_binding.dart';
import '../modules/agama/views/agama_view.dart';
import '../modules/all_data_absensi/bindings/all_data_absensi_binding.dart';
import '../modules/all_data_absensi/views/all_data_absensi_view.dart';
import '../modules/all_presensi/bindings/all_presensi_binding.dart';
import '../modules/all_presensi/views/all_presensi_view.dart';
import '../modules/anak/bindings/anak_binding.dart';
import '../modules/anak/views/anak_view.dart';
import '../modules/data_kepolisian/bindings/data_kepolisian_binding.dart';
import '../modules/data_kepolisian/views/data_kepolisian_view.dart';
import '../modules/detail_personil/bindings/detail_personil_binding.dart';
import '../modules/detail_personil/views/detail_personil_view.dart';
import '../modules/edit_anak/bindings/edit_anak_binding.dart';
import '../modules/edit_anak/views/edit_anak_view.dart';
import '../modules/edit_istri/bindings/edit_istri_binding.dart';
import '../modules/edit_istri/views/edit_istri_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/list_personil/bindings/list_personil_binding.dart';
import '../modules/list_personil/views/list_personil_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/presensi_detail/bindings/presensi_detail_binding.dart';
import '../modules/presensi_detail/views/presensi_detail_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/riwayat_pendidikan/bindings/riwayat_pendidikan_binding.dart';
import '../modules/riwayat_pendidikan/views/riwayat_pendidikan_view.dart';
import '../modules/tunjangan_kinerja/bindings/tunjangan_kinerja_binding.dart';
import '../modules/tunjangan_kinerja/views/tunjangan_kinerja_view.dart';
import '../modules/update_istri/bindings/update_istri_binding.dart';
import '../modules/update_istri/views/update_istri_view.dart';
import '../modules/update_password/bindings/update_password_binding.dart';
import '../modules/update_password/views/update_password_view.dart';
import '../modules/update_profile/bindings/update_profile_binding.dart';
import '../modules/update_profile/views/update_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PERSONIL,
      page: () => const AddPersonilView(),
      binding: AddPersonilBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.UPDATE_PROFILE,
      page: () => UpdateProfileView(),
      binding: UpdateProfileBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PASSWORD,
      page: () => const UpdatePasswordView(),
      binding: UpdatePasswordBinding(),
    ),
    GetPage(
      name: _Paths.PRESENSI_DETAIL,
      page: () => PresensiDetailView(),
      binding: PresensiDetailBinding(),
    ),
    GetPage(
      name: _Paths.ALL_PRESENSI,
      page: () => const AllPresensiView(),
      binding: AllPresensiBinding(),
    ),
    GetPage(
      name: _Paths.AGAMA,
      page: () => const AgamaView(),
      binding: AgamaBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_ISTRI,
      page: () => UpdateIstriView(),
      binding: UpdateIstriBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ISTRI,
      page: () => const AddIstriView(),
      binding: AddIstriBinding(),
    ),
    GetPage(
      name: _Paths.ANAK,
      page: () => const AnakView(),
      binding: AnakBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ANAK,
      page: () => const AddAnakView(),
      binding: AddAnakBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT_PENDIDIKAN,
      page: () => const RiwayatPendidikanView(),
      binding: RiwayatPendidikanBinding(),
    ),
    GetPage(
      name: _Paths.ADD_RIWAYAT_PENDIDIKAN,
      page: () => const AddRiwayatPendidikanView(),
      binding: AddRiwayatPendidikanBinding(),
    ),
    GetPage(
      name: _Paths.LIST_PERSONIL,
      page: () => ListPersonilView(),
      binding: ListPersonilBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PERSONIL,
      page: () => DetailPersonilView(),
      binding: DetailPersonilBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_ISTRI,
      page: () => EditIstriView(),
      binding: EditIstriBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_ANAK,
      page: () => EditAnakView(),
      binding: EditAnakBinding(),
    ),
    GetPage(
      name: _Paths.ALL_DATA_ABSENSI,
      page: () => const AllDataAbsensiView(),
      binding: AllDataAbsensiBinding(),
    ),
    GetPage(
      name: _Paths.TUNJANGAN_KINERJA,
      page: () => const TunjanganKinerjaView(),
      binding: TunjanganKinerjaBinding(),
    ),
    GetPage(
      name: _Paths.DATA_KEPOLISIAN,
      page: () => const DataKepolisianView(),
      binding: DataKepolisianBinding(),
    ),
  ];
}
