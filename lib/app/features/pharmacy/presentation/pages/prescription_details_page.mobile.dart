import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../shared/presentation/pages/base_page.dart';
import '../../../../shared/presentation/widgets/label_and_value.dart';
import '../../../../shared/utils/date_time_ext.dart';
import '../../domain/entities/prescription.dart';

class PrescriptionDetailsPageMobile extends StatelessWidget {
  const PrescriptionDetailsPageMobile(this.prescription, {super.key});

  final Prescription prescription;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      backButtonEnabled: true,
      title: _Title(),
      body: _Body(prescription),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Prescription details',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class _Body extends StatelessWidget {
  const _Body(this.prescription);

  final Prescription prescription;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelAndValue('Prescription ID: ', prescription.id),
            const SizedBox(height: 8),
            LabelAndValue('Medication Names: ', prescription.medicationNames),
            const SizedBox(height: 8),
            LabelAndValue(
              'Issue Date: ',
              prescription.issueDate.formatDefault(),
            ),
            const SizedBox(height: 8),
            LabelAndValue('Additional Notes: ', '--'),
            const SizedBox(height: 8),
            Text(
              'Attachments:',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            _buildAttachments(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachments(BuildContext context) {
    if (prescription.attachments.isEmpty) {
      return const Text('--');
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemCount: prescription.attachments.length,
      itemBuilder: (context, index) {
        final path = prescription.attachments[index];
        return _buildAttachmentItem(context, path);
      },
    );
  }

  Widget _buildAttachmentItem(BuildContext context, String path) {
    return GestureDetector(
      onTap: () => _showFullScreenImage(context, path),
      child: Card(
        elevation: 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: _loadImage(path),
        ),
      ),
    );
  }

  Widget _loadImage(String path) {
    return Image.file(
      File(path),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Center(
          child: Icon(
            Icons.broken_image,
            size: 50,
            color: Theme.of(context).disabledColor,
          ),
        );
      },
    );
  }

  void _showFullScreenImage(BuildContext context, String path) {
    Navigator.of(context).push(
      // ignore: inference_failure_on_instance_creation
      MaterialPageRoute(
        builder:
            (context) => Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: Text(
                  'Image preview',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: InteractiveViewer(
                    minScale: 0.5,
                    maxScale: 3,
                    child: Image.file(File(path)),
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
