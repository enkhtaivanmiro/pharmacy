import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PatientInfoCard extends StatelessWidget {
  final TextEditingController patientNameController;
  final TextEditingController patientAgeController;
  final TextEditingController patientIdController;
  final TextEditingController diagnosisController;
  final String selectedGender;
  final Function(String?) onGenderChanged;
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;

  const PatientInfoCard({
    super.key,
    required this.patientNameController,
    required this.patientAgeController,
    required this.patientIdController,
    required this.diagnosisController,
    required this.selectedGender,
    required this.onGenderChanged,
    required this.selectedDate,
    required this.onDateChanged,
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
                Icon(Icons.person_outline, color: Theme.of(context).primaryColor, size: 28),
                SizedBox(width: 8),
                Text('Өвчтөний Мэдээлэл', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 18)),
              ],
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: patientNameController,
              decoration: InputDecoration(
                labelText: 'Өвчтөний овог, нэр',
                hintText: 'Болд Бат',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) => value == null || value.isEmpty ? 'Өвчтөний нэрийг оруулна уу' : null,
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: patientIdController,
                    decoration: InputDecoration(
                      labelText: 'Регистрийн дугаар',
                      hintText: 'УБ12345678',
                      prefixIcon: Icon(Icons.fingerprint),
                    ),
                    validator: (value) => value == null || value.isEmpty ? 'РД оруулна уу' : null,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: patientAgeController,
                    decoration: InputDecoration(
                      labelText: 'Нас',
                      hintText: '30',
                      prefixIcon: Icon(Icons.cake),
                      suffixText: 'нас',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Нас оруулна уу';
                      if (int.tryParse(value) == null) return 'Тоо оруулна уу';
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xFFE0E0E0)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.wc, color: Theme.of(context).primaryColor),
                  SizedBox(width: 12),
                  Text('Хүйс:', style: TextStyle(color: Color(0xFF757575))),
                  SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text('Эрэгтэй'),
                            value: 'Эрэгтэй',
                            groupValue: selectedGender,
                            onChanged: onGenderChanged,
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text('Эмэгтэй'),
                            value: 'Эмэгтэй',
                            groupValue: selectedGender,
                            onChanged: onGenderChanged,
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: diagnosisController,
              decoration: InputDecoration(
                labelText: 'Оношлогоо',
                hintText: 'Томуу, халууралт',
                prefixIcon: Icon(Icons.healing),
              ),
              maxLines: 2,
              validator: (value) => value == null || value.isEmpty ? 'Оношлогоогоо оруулна уу' : null,
            ),
            SizedBox(height: 12),
            InkWell(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (picked != null) onDateChanged(picked);
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFE0E0E0)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, color: Theme.of(context).primaryColor),
                    SizedBox(width: 12),
                    Text('Жор бичсэн огноо: ${DateFormat('yyyy-MM-dd').format(selectedDate)}', style: TextStyle(fontSize: 16, color: Color(0xFF616161))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}