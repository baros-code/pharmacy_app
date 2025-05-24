import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../core/presentation/controller.dart';
import '../../../../shared/utils/app_router.dart';
import '../../domain/entities/medication.dart';
import '../cubit/pharmacy_cubit.dart';
// TODO(Baran): Maintain state returning from details page.

// TODO(Baran): Test the app with ios, sign in e.g
class HomeController extends Controller<Object> {
  HomeController(super.logger, super.popupManager);

  late PharmacyCubit _pharmacyCubit;

  List<Medication> get medications => _pharmacyCubit.medications;

  List<String> get categories => _pharmacyCubit.categories;

  @override
  bool get keepViewAlive => true;

  @override
  void onStart() async {
    super.onStart();
    _pharmacyCubit = context.read<PharmacyCubit>()..stream.listen(_handleState);
    _pharmacyCubit.fetchMedications();
  }

  void _handleState(PharmacyState state) {
    if (state is MedicationsFetchFailure) {
      popupManager.showToastMessage(context, state.error);
    }
  }

  Future<void> searchMedications(String query) async {
    await _pharmacyCubit.fetchMedications(name: query.toLowerCase());
  }

  void goToMedicationDetails(Medication medication) {
    context.goNamed(RouteConfig.medicationDetailsRoute.name, extra: medication);
  }
}
