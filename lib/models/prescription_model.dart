class PrescriptionModel {
  final String patientName;
  final int patientAge;
  final String patientId;
  final String patientGender;
  final String diagnosis;
  
  final String doctorName;
  final String doctorLicense;
  final String hospitalName;
  
  final String medicationName;
  final double dosage;
  final int frequency;
  final int duration;
  final String instructions;
  
  final DateTime prescriptionDate;
  final double dailyDosage;
  final double totalDosage;
  
  PrescriptionModel({
    required this.patientName,
    required this.patientAge,
    required this.patientId,
    required this.patientGender,
    required this.diagnosis,
    required this.doctorName,
    required this.doctorLicense,
    required this.hospitalName,
    required this.medicationName,
    required this.dosage,
    required this.frequency,
    required this.duration,
    required this.instructions,
    required this.prescriptionDate,
    required this.dailyDosage,
    required this.totalDosage,
  });
}