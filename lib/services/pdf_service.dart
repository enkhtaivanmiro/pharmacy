import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import '../models/prescription_model.dart';

class PdfService {
  static Future<Uint8List> generatePrescriptionPdf(PrescriptionModel prescription) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(40),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.Text(prescription.hospitalName, style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold, color: PdfColors.blue800)),
                    pw.SizedBox(height: 8),
                    pw.Text('ЭМИЙН ЖОР', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold, letterSpacing: 3)),
                    pw.SizedBox(height: 4),
                    pw.Text('MNS 5376:2016 стандартын дагуу', style: pw.TextStyle(fontSize: 11, color: PdfColors.grey700)),
                  ],
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Divider(thickness: 2),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [pw.Text('Огноо: ${DateFormat('yyyy оны MM сарын dd').format(prescription.prescriptionDate)}', style: pw.TextStyle(fontSize: 11, color: PdfColors.grey700))],
              ),
              pw.SizedBox(height: 20),
              _buildSectionTitle('ӨВЧТӨНИЙ МЭДЭЭЛЭЛ'),
              pw.SizedBox(height: 10),
              pw.Container(
                padding: pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey400), borderRadius: pw.BorderRadius.circular(6)),
                child: pw.Column(
                  children: [
                    _buildPdfInfoRow('Овог, нэр:', prescription.patientName),
                    _buildPdfInfoRow('Регистрийн дугаар:', prescription.patientId),
                    _buildPdfInfoRow('Нас:', '${prescription.patientAge} нас'),
                    _buildPdfInfoRow('Хүйс:', prescription.patientGender),
                    _buildPdfInfoRow('Оношлогоо:', prescription.diagnosis),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),
              _buildSectionTitle('Rp: (ЭМИЙН ЖОР)'),
              pw.SizedBox(height: 10),
              pw.Container(
                padding: pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(color: PdfColors.blue50, border: pw.Border.all(color: PdfColors.blue200), borderRadius: pw.BorderRadius.circular(6)),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    _buildPdfInfoRow('Эмийн нэр:', prescription.medicationName, bold: true),
                    pw.SizedBox(height: 4),
                    _buildPdfInfoRow('Нэг удаагийн тун:', '${prescription.dosage} мг'),
                    _buildPdfInfoRow('Давтамж:', 'Өдөрт ${prescription.frequency} удаа'),
                    _buildPdfInfoRow('Хугацаа:', '${prescription.duration} өдөр'),
                    pw.SizedBox(height: 8),
                    pw.Divider(color: PdfColors.blue300),
                    pw.SizedBox(height: 8),
                    _buildPdfInfoRow('Өдрийн нийт тун:', '${prescription.dailyDosage} мг', bold: true),
                    _buildPdfInfoRow('Нийт эмчилгээний тун:', '${prescription.totalDosage} мг', bold: true),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),
              _buildSectionTitle('S: (ХЭРЭГЛЭХ ЗААВАРЧИЛГАА)'),
              pw.SizedBox(height: 10),
              pw.Container(
                width: double.infinity,
                padding: pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(color: PdfColors.grey100, borderRadius: pw.BorderRadius.circular(6)),
                child: pw.Text(prescription.instructions, style: pw.TextStyle(fontSize: 12)),
              ),
              pw.Spacer(),
              pw.Divider(),
              pw.SizedBox(height: 15),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Эмчийн овог, нэр:', style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
                      pw.SizedBox(height: 4),
                      pw.Text(prescription.doctorName, style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 8),
                      pw.Text('Тусгай зөвшөөрлийн дугаар: ${prescription.doctorLicense}', style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
                    ],
                  ),
                  pw.Column(
                    children: [
                      pw.Container(width: 150, height: 1, color: PdfColors.grey800),
                      pw.SizedBox(height: 4),
                      pw.Text('Эмчийн гарын үсэг', style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
    return pdf.save();
  }
  
  static pw.Widget _buildSectionTitle(String title) {
    return pw.Text(title, style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: PdfColors.blue800));
  }
  
  static pw.Widget _buildPdfInfoRow(String label, String value, {bool bold = false}) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(vertical: 3),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(width: 160, child: pw.Text(label, style: pw.TextStyle(fontSize: 11, color: PdfColors.grey700))),
          pw.Expanded(child: pw.Text(value, style: pw.TextStyle(fontSize: 11, fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal))),
        ],
      ),
    );
  }
}