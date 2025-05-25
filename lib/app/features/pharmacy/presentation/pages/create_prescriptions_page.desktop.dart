import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/presentation/controlled_view.dart';
import '../../../../../core/presentation/custom_card.dart';
import '../../../../../core/presentation/sub_view.dart';
import '../../../../shared/presentation/pages/base_page.dart';
import '../../../../shared/utils/date_time_ext.dart';
import '../../../../shared/widgets/custom_text_form_field.dart';
import '../controllers/create_prescriptions_controller.dart';
import '../cubit/pharmacy_cubit.dart';

class CreatePrescriptionsPageDesktop
    extends ControlledView<CreatePrescriptionsController, Object> {
  CreatePrescriptionsPageDesktop({super.key, super.params});

  @override
  Widget build(BuildContext context) {
    return BasePage(title: _Title(), body: _Body(), bottom: _Bottom());
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Create prescriptions',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class _Body extends SubView<CreatePrescriptionsController> {
  @override
  Widget buildView(
    BuildContext context,
    CreatePrescriptionsController controller,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.2,
        vertical: 16,
      ),
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _MedicationSelectionCard(),
            _IssueDatePicker(),
            _AdditionalNotes(),
            _AttachmentPicker(),
          ],
        ),
      ),
    );
  }
}

class _MedicationSelectionCard extends SubView<CreatePrescriptionsController> {
  @override
  Widget buildView(
    BuildContext context,
    CreatePrescriptionsController controller,
  ) {
    return BlocBuilder<PharmacyCubit, PharmacyState>(
      buildWhen: (previous, current) => current is MedicationsSelected,
      builder: (context, state) {
        final medications =
            state is MedicationsSelected
                ? state.selectedMedications
                : controller.selectedMedications;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'First you need to select medications for your prescription:',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            CustomCard(
              padding: const EdgeInsets.all(12),
              enableShadows: false,
              onTap: controller.openMedicationSelectionView,
              showBorder: true,
              borderColor: Theme.of(context).primaryColor,
              showArrowIcon: true,
              child: Text(
                medications.isEmpty
                    ? 'Select medications'
                    : '${medications.length} medication selected',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      medications.isEmpty
                          ? Theme.of(context).disabledColor
                          : Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _IssueDatePicker extends SubView<CreatePrescriptionsController> {
  @override
  Widget buildView(
    BuildContext context,
    CreatePrescriptionsController controller,
  ) {
    return BlocBuilder<PharmacyCubit, PharmacyState>(
      buildWhen: (previous, current) => current is IssueDateSelected,
      builder: (context, state) {
        final issueDate =
            state is IssueDateSelected ? state.issueDate : controller.issueDate;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Select the issue date for your prescription:',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            CustomCard(
              padding: const EdgeInsets.all(12),
              enableShadows: false,
              onTap: controller.openIssueDatePicker,
              showBorder: true,
              borderColor: Theme.of(context).primaryColor,
              showArrowIcon: true,
              child: Text(
                issueDate == null
                    ? 'Select issue date'
                    : issueDate.formatDefault(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      issueDate == null
                          ? Theme.of(context).disabledColor
                          : Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AdditionalNotes extends SubView<CreatePrescriptionsController> {
  @override
  Widget buildView(
    BuildContext context,
    CreatePrescriptionsController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '''Now you can add some additional information to your prescription (optional):''',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        CustomTextFormField(
          labelText: 'Additional Notes',
          onChanged: controller.setAdditionalNotes,
        ),
      ],
    );
  }
}

class _AttachmentPicker extends SubView<CreatePrescriptionsController> {
  @override
  Widget buildView(
    BuildContext context,
    CreatePrescriptionsController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '''You can also attach an image or photo to your prescription (optional):''',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        CustomCard(
          padding: const EdgeInsets.all(12),
          enableShadows: false,
          showBorder: true,
          borderColor: Theme.of(context).primaryColor,
          showArrowIcon: true,
          onTap: () {},
          child: Text(
            'Attach image or photo',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).disabledColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _Bottom extends SubView<CreatePrescriptionsController> {
  @override
  Widget buildView(
    BuildContext context,
    CreatePrescriptionsController controller,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: screenWidth * 0.2,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(fixedSize: Size(double.infinity, 64)),
        onPressed: controller.createPrescription,
        child: const Text('Create prescription'),
      ),
    );
  }
}
