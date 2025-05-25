import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../core/presentation/controller.dart';
import '../../../../shared/utils/app_router.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../domain/entities/medication.dart';
import '../cubit/pharmacy_cubit.dart';

class HomeController extends Controller<Object> {
  HomeController(super.logger, super.popupManager);

  late AuthCubit _authCubit;
  late PharmacyCubit _pharmacyCubit;

  List<Medication> get medications => _pharmacyCubit.medications;

  List<String> get categories => _pharmacyCubit.categories;

  String? get currentSearchQuery => _pharmacyCubit.currentSearchQuery;

  String? get selectedCategory => _pharmacyCubit.selectedCategory;

  @override
  void onStart() async {
    super.onStart();
    _authCubit = context.read<AuthCubit>()..stream.listen(_handleAuthState);
    _pharmacyCubit = context.read<PharmacyCubit>()..stream.listen(_handleState);
  }

  void _handleState(PharmacyState state) {
    if (state is MedicationsFetchFailure) {
      popupManager.showToastMessage(
        context,
        'Failed to fetch medications, please try again.',
      );
    }
  }

  void _handleAuthState(AuthState state) {
    if (state is LogoutSuccess) {
      if (context.mounted) {
        popupManager.showToastMessage(
          context,
          'Logout successful, redirecting to login page.',
        );
      }
      // Some delay to show the toast message
      Future.delayed(const Duration(milliseconds: 500), () {
        if (context.mounted) {
          context.goNamed(RouteConfig.loginRoute.name);
        }
      });
    } else if (state is LogoutFailure) {
      if (context.mounted) {
        popupManager.showToastMessage(
          context,
          'Logout failed, please try again.',
        );
      }
    }
  }

  Future<void> searchMedications(String query) async {
    await _pharmacyCubit.fetchMedications(name: query.toLowerCase());
  }

  void onCategoryToggleChanged(String category, bool isSelected) {
    if (isSelected) {
      _pharmacyCubit.categorySelected(category);
    } else {
      _pharmacyCubit.categorySelected(null);
    }
  }

  void goToMedicationDetails(Medication medication) {
    context.goNamed(RouteConfig.medicationDetailsRoute.name, extra: medication);
  }

  void logout() {
    _authCubit.logout();
  }
}
