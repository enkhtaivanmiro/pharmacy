import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/prescription_model.dart';
import '../services/pdf_service.dart';
import '../widgets/prescription_preview.dart';

class PrescriptionPdfScreen extends StatelessWidget {
  final PrescriptionModel prescription;

  const PrescriptionPdfScreen({super.key, required this.prescription});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Эмийн Жор',
          style: GoogleFonts.notoSans(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () async {
              await Printing.layoutPdf(
                onLayout: (format) =>
                    PdfService.generatePrescriptionPdf(prescription),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () async {
              final pdfData =
                  await PdfService.generatePrescriptionPdf(prescription);
              await Printing.sharePdf(
                  bytes: pdfData,
                  filename: 'emiin_jor_${prescription.patientName}.pdf');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: PrescriptionPreview(prescription: prescription),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.edit),
                      label: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Засах',
                          style: GoogleFonts.notoSans(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await Printing.layoutPdf(
                          onLayout: (format) =>
                              PdfService.generatePrescriptionPdf(prescription),
                        );
                      },
                      icon: const Icon(Icons.picture_as_pdf),
                      label: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'PDF Үзэх',
                          style: GoogleFonts.notoSans(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
