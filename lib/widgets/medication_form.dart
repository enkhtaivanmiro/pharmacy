import 'package:flutter/material.dart';

class MedicationForm extends StatelessWidget {
  final TextEditingController medicationNameController;
  final TextEditingController dosageController;
  final TextEditingController frequencyController;
  final TextEditingController durationController;
  final TextEditingController instructionsController;

  const MedicationForm({
    super.key,
    required this.medicationNameController,
    required this.dosageController,
    required this.frequencyController,
    required this.durationController,
    required this.instructionsController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFF1976D2).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.medication, color: Color(0xFF1976D2), size: 28),
                ),
                SizedBox(width: 8),
                Text(
                  'Эмийн Мэдээлэл',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 16),
            
            // Зураг (эмийн зураг)
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFF1976D2).withOpacity(0.3)),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.medical_services_outlined,
                      size: 80,
                      color: Color(0xFF1976D2).withOpacity(0.6),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Эмийн Иллюстраци',
                      style: TextStyle(
                        color: Color(0xFF757575),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            
            // Эмийн нэр
            TextFormField(
              controller: medicationNameController,
              decoration: InputDecoration(
                labelText: 'Эмийн нэр',
                hintText: 'Парацетамол',
                prefixIcon: Icon(Icons.medical_services),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Эмийн нэрийг оруулна уу';
                }
                return null;
              },
            ),
            SizedBox(height: 12),
            
            // Тун ба давтамж
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: dosageController,
                    decoration: InputDecoration(
                      labelText: 'Нэг удаагийн тун',
                      hintText: '500',
                      prefixIcon: Icon(Icons.scatter_plot),
                      suffixText: 'мг',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Тун оруулна уу';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Тоо оруулна уу';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: frequencyController,
                    decoration: InputDecoration(
                      labelText: 'Давтамж',
                      hintText: '3',
                      prefixIcon: Icon(Icons.repeat),
                      suffixText: 'удаа/өдөр',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Давтамж оруулна уу';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Тоо оруулна уу';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            
            // Хугацаа
            TextFormField(
              controller: durationController,
              decoration: InputDecoration(
                labelText: 'Хэрэглэх хугацаа',
                hintText: '7',
                prefixIcon: Icon(Icons.schedule),
                suffixText: 'өдөр',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Хугацааг оруулна уу';
                }
                if (int.tryParse(value) == null) {
                  return 'Тоо оруулна уу';
                }
                return null;
              },
            ),
            SizedBox(height: 12),
            
            // Зааварчилгаа
            TextFormField(
              controller: instructionsController,
              decoration: InputDecoration(
                labelText: 'Хэрэглэх зааварчилгаа',
                hintText: 'Хоолны дараа ууна',
                prefixIcon: Icon(Icons.info_outline),
                alignLabelWithHint: true,
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Зааварчилгааг оруулна уу';
                }
                return null;
              },
            ),
            
            // Тунгийн тооцооны мэдээлэл
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFF1F8E9),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFF8BC34A)),
              ),
              child: Row(
                children: [
                  Icon(Icons.calculate, color: Color(0xFF558B2F)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Тунгийн тооцоо автоматаар хийгдэнэ',
                      style: TextStyle(
                        color: Color(0xFF558B2F),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}