import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/presentation/controlled_view.dart';
import '../../../../../core/presentation/custom_card.dart';
import '../../../../../core/presentation/sub_view.dart';
import '../../../../shared/presentation/pages/base_page.dart';
import '../../../../shared/presentation/widgets/empty_view.dart';
import '../../../../shared/utils/date_time_ext.dart';
import '../controllers/prescriptions_controller.dart';
import '../cubit/pharmacy_cubit.dart';

class PrescriptionsPageMobile
    extends ControlledView<PrescriptionsController, Object> {
  PrescriptionsPageMobile({super.key, super.params});

  @override
  Widget build(BuildContext context) {
    return BasePage(title: const _Title(), body: _Body());
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Text(
      'My Prescriptions',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class _Body extends SubView<PrescriptionsController> {
  @override
  Widget buildView(BuildContext context, PrescriptionsController controller) {
    return BlocBuilder<PharmacyCubit, PharmacyState>(
      buildWhen:
          (previous, current) =>
              current is PrescriptionsLoading ||
              current is PrescriptionsFetched ||
              current is PrescriptionsFetchFailure,
      builder: (context, state) {
        final prescriptions =
            state is PrescriptionsFetched
                ? state.prescriptions
                : controller.prescriptions;
        if (state is PrescriptionsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is PrescriptionsFetchFailure) {
          return Center(
            child: EmptyView.tryAgain(
              text: 'There was an error while fetching prescriptions.',
              onTryAgain: controller.onTryAgain,
            ),
          );
        }
        if (state is PrescriptionsFetched && prescriptions.isEmpty) {
          return Center(
            child: EmptyView(text: 'You don\'t have any prescriptions yet.'),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: prescriptions.length,
          itemBuilder: (context, index) {
            final prescription = prescriptions[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: CustomCard(
                showArrowIcon: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      prescription.medicationNames,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Issued on: ${prescription.issueDate?.formatDefault()}',
                    ),
                  ],
                ),
                onTap:
                    () => controller.goToPrescriptionDetailsPage(prescription),
              ),
            );
          },
        );
      },
    );
  }
}
