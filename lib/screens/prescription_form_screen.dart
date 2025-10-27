import 'package:flutter/material.dart';
import '../models/prescription_model.dart';
import '../utils/dosage_calculator.dart';
import '../widgets/patient_info_card.dart';
import '../widgets/medication_form.dart';
import 'prescription_pdf_screen.dart';

class PrescriptionFormScreen extends StatefulWidget {
  const PrescriptionFormScreen({super.key});

  @override
  State<PrescriptionFormScreen> createState() => _PrescriptionFormScreenState();
}

class _PrescriptionFormScreenState extends State<PrescriptionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final _patientNameController = TextEditingController();
  final _patientAgeController = TextEditingController();
  final _patientIdController = TextEditingController();
  final _diagnosisController = TextEditingController();
  final _doctorNameController = TextEditingController();
  final _doctorLicenseController = TextEditingController();
  final _hospitalNameController = TextEditingController();
  final _medicationNameController = TextEditingController();
  final _dosageController = TextEditingController();
  final _frequencyController = TextEditingController();
  final _durationController = TextEditingController();
  final _instructionsController = TextEditingController();
  
  String _selectedGender = 'Эрэгтэй';
  DateTime _selectedDate = DateTime.now();
  
  @override
  void dispose() {
    _patientNameController.dispose();
    _patientAgeController.dispose();
    _patientIdController.dispose();
    _diagnosisController.dispose();
    _doctorNameController.dispose();
    _doctorLicenseController.dispose();
    _hospitalNameController.dispose();
    _medicationNameController.dispose();
    _dosageController.dispose();
    _frequencyController.dispose();
    _durationController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  void _generatePrescription() {
    if (_formKey.currentState!.validate()) {
      final dosagePerDay = DosageCalculator.calculateDailyDosage(
        double.parse(_dosageController.text),
        int.parse(_frequencyController.text),
      );
      
      final totalDosage = DosageCalculator.calculateTotalDosage(
        double.parse(_dosageController.text),
        int.parse(_frequencyController.text),
        int.parse(_durationController.text),
      );
      
      final prescription = PrescriptionModel(
        patientName: _patientNameController.text,
        patientAge: int.parse(_patientAgeController.text),
        patientId: _patientIdController.text,
        patientGender: _selectedGender,
        diagnosis: _diagnosisController.text,
        doctorName: _doctorNameController.text,
        doctorLicense: _doctorLicenseController.text,
        hospitalName: _hospitalNameController.text,
        medicationName: _medicationNameController.text,
        dosage: double.parse(_dosageController.text),
        frequency: int.parse(_frequencyController.text),
        duration: int.parse(_durationController.text),
        instructions: _instructionsController.text,
        prescriptionDate: _selectedDate,
        dailyDosage: dosagePerDay,
        totalDosage: totalDosage,
      );
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PrescriptionPdfScreen(prescription: prescription),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.medical_services, size: 28),
            SizedBox(width: 8),
            Text('Эмийн Жор Бичих', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // 5 давхаргын widget nesting
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.local_hospital,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'MNS 5376:2016',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Эмийн Жорын Стандарт',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 20),
                
                PatientInfoCard(
                  patientNameController: _patientNameController,
                  patientAgeController: _patientAgeController,
                  patientIdController: _patientIdController,
                  diagnosisController: _diagnosisController,
                  selectedGender: _selectedGender,
                  onGenderChanged: (value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                  selectedDate: _selectedDate,
                  onDateChanged: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                ),
                
                SizedBox(height: 16),
                
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person, color: Theme.of(context).primaryColor),
                            SizedBox(width: 8),
                            Text(
                              'Эмчийн Мэдээлэл',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _doctorNameController,
                          decoration: InputDecoration(
                            labelText: 'Эмчийн овог, нэр',
                            prefixIcon: Icon(Icons.badge),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Эмчийн нэрийг оруулна уу';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          controller: _doctorLicenseController,
                          decoration: InputDecoration(
                            labelText: 'Тусгай зөвшөөрлийн дугаар',
                            prefixIcon: Icon(Icons.credit_card),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Дугаарыг оруулна уу';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          controller: _hospitalNameController,
                          decoration: InputDecoration(
                            labelText: 'Эмнэлгийн нэр',
                            prefixIcon: Icon(Icons.local_hospital),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Эмнэлгийн нэрийг оруулна уу';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 16),
                
                MedicationForm(
                  medicationNameController: _medicationNameController,
                  dosageController: _dosageController,
                  frequencyController: _frequencyController,
                  durationController: _durationController,
                  instructionsController: _instructionsController,
                ),
                
                SizedBox(height: 24),
                
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _generatePrescription,
                    icon: Icon(Icons.picture_as_pdf, size: 24),
                    label: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'Эмийн Жор Үүсгэх',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}