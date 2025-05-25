import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../core/presentation/controller.dart';
import '../../../../shared/utils/app_router.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../domain/entities/prescription.dart';
import '../cubit/pharmacy_cubit.dart';

class PrescriptionsController extends Controller<Object> {
  PrescriptionsController(super.logger, super.popupManager);

  late AuthCubit _authCubit;
  late PharmacyCubit _pharmacyCubit;

  List<Prescription> get prescriptions => _pharmacyCubit.prescriptions;

  @override
  void onStart() {
    super.onStart();
    _authCubit = context.read<AuthCubit>();
    _pharmacyCubit =
        context.read<PharmacyCubit>()..stream.listen(_handleStates);
    _pharmacyCubit.fetchPrescriptions(_authCubit.userCache!.id);
  }

  void _handleStates(PharmacyState state) {
    if (state is PrescriptionsFetchFailure) {
      popupManager.showToastMessage(
        context,
        'Failed to fetch prescriptions, please try again.',
      );
    }
  }

  void onTryAgain() {
    _pharmacyCubit.fetchPrescriptions(_authCubit.userCache!.id);
  }

  void goToPrescriptionDetailsPage(Prescription prescription) {
    context.goNamed(
      RouteConfig.prescriptionDetailsRoute.name,
      extra: prescription,
    );
  }
}
