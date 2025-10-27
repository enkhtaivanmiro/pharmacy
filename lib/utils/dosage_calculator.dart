class DosageCalculator {
  static double calculateDailyDosage(double dosagePerTime, int frequency) {
    return dosagePerTime * frequency;
  }
  
  static double calculateTotalDosage(
    double dosagePerTime,
    int frequency,
    int duration,
  ) {
    return dosagePerTime * frequency * duration;
  }
  
  static int calculatePillCount(double totalDosage, double dosagePerPill) {
    return (totalDosage / dosagePerPill).ceil();
  }
}