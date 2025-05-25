import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/presentation/controlled_view.dart';
import '../../../../../core/presentation/custom_card.dart';
import '../../../../../core/presentation/sub_view.dart';
import '../../../../../core/utils/string_ext.dart';
import '../../../../shared/presentation/pages/base_page.dart';
import '../../../../shared/utils/build_context_ext.dart';
import '../../../../shared/widgets/search_view.dart';
import '../../domain/entities/medication.dart';
import '../controllers/home_controller.dart';
import '../cubit/pharmacy_cubit.dart';

class HomePageDesktop extends ControlledView<HomeController, Object> {
  HomePageDesktop({super.key, super.params});

  @override
  Widget build(BuildContext context) {
    return BasePage(title: _Title(), body: _Body());
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Text('Pharmacy', style: context.textTheme.headlineLarge);
  }
}

class _Body extends SubView<HomeController> {
  @override
  Widget buildView(BuildContext context, HomeController controller) {
    return BlocBuilder<PharmacyCubit, PharmacyState>(
      buildWhen:
          (previous, current) =>
              current is MedicationsFetched ||
              current is MedicationsLoading ||
              current is MedicationsFetchFailure,
      builder: (context, state) {
        final medications =
            state is MedicationsFetched
                ? state.medications
                : controller.medications;
        return SearchView(
          padding: const EdgeInsets.all(8),
          enableShadows: true,
          searchBarHintText: 'Search for medications',
          itemPadding: EdgeInsets.only(bottom: 16),
          items:
              medications.map((e) => _createSearchItem(e, controller)).toList(),
          toggleItems:
              controller.categories
                  .map(
                    (category) => ToggleItem(
                      text: category,
                      itemsOnSelection:
                          medications
                              .where((e1) => e1.category == category)
                              .map((e2) => _createSearchItem(e2, controller))
                              .toList(),
                    ),
                  )
                  .toList(),
          onSearchTextChanged: controller.searchMedications,
        );
      },
    );
  }

  SearchItem _createSearchItem(
    Medication medication,
    HomeController controller,
  ) {
    return SearchItem(
      widget: CustomCard(
        onTap: () => controller.goToMedicationDetails(medication),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              medication.name.capitalizeFirstLetter(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(medication.description),
          ],
        ),
      ),
      searchTexts: [medication.name],
      isVisible: true,
    );
  }
}
