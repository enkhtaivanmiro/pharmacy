import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/prescription_model.dart';

class PrescriptionPreview extends StatelessWidget {
  final PrescriptionModel prescription;

  const PrescriptionPreview({super.key, required this.prescription});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(prescription.hospitalName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1976D2))),
                  SizedBox(height: 4),
                  Text('ЭМИЙН ЖОР', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2)),
                  SizedBox(height: 4),
                  Text('MNS 5376:2016', style: TextStyle(fontSize: 12, color: Color(0xFF757575))),
                ],
              ),
            ),
            Divider(height: 32, thickness: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text('Огноо: ${DateFormat('yyyy-MM-dd').format(prescription.prescriptionDate)}', style: TextStyle(color: Color(0xFF757575)))],
            ),
            SizedBox(height: 16),
            _buildSectionTitle('Өвчтөний мэдээлэл'),
            SizedBox(height: 8),
            _buildInfoRow('Овог, нэр:', prescription.patientName),
            _buildInfoRow('Регистрийн дугаар:', prescription.patientId),
            _buildInfoRow('Нас:', '${prescription.patientAge} нас'),
            _buildInfoRow('Хүйс:', prescription.patientGender),
            _buildInfoRow('Оношлогоо:', prescription.diagnosis),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 16),
            _buildSectionTitle('Rp: (Эмийн жор)'),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('Эмийн нэр:', prescription.medicationName),
                  _buildInfoRow('Нэг удаагийн тун:', '${prescription.dosage} мг'),
                  _buildInfoRow('Давтамж:', 'Өдөрт ${prescription.frequency} удаа'),
                  _buildInfoRow('Хугацаа:', '${prescription.duration} өдөр'),
                  SizedBox(height: 8),
                  Divider(),
                  SizedBox(height: 8),
                  _buildInfoRow('Өдрийн нийт тун:', '${prescription.dailyDosage} мг'),
                  _buildInfoRow('Нийт эмчилгээний тун:', '${prescription.totalDosage} мг'),
                ],
              ),
            ),
            SizedBox(height: 16),
            _buildSectionTitle('S: (Хэрэглэх зааварчилгаа)'),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(color: Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(8)),
              child: Text(prescription.instructions, style: TextStyle(fontSize: 14, color: Color(0xFF424242))),
            ),
            SizedBox(height: 24),
            Divider(),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Эмчийн овог, нэр:', style: TextStyle(color: Color(0xFF757575), fontSize: 12)),
                    SizedBox(height: 4),
                    Text(prescription.doctorName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 8),
                    Text('Тусгай зөвшөөрөл: ${prescription.doctorLicense}', style: TextStyle(color: Color(0xFF757575), fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    Text('___________________'),
                    SizedBox(height: 4),
                    Text('Эмчийн гарын үсэг', style: TextStyle(color: Color(0xFF757575), fontSize: 11)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1976D2)));
  }
  
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 150, child: Text(label, style: TextStyle(color: Color(0xFF757575), fontSize: 14))),
          Expanded(child: Text(value, style: TextStyle(color: Color(0xFF424242), fontSize: 14, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}