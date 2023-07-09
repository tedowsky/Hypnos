double calculateGoodSleepIndex(int rem, int deep, int light, int wake,
    Duration duration, double efficiency) {
  int durationInMinutes = duration.inMinutes;

  // Calcolo del Phase Balance
  double phaseBalance =
      (wake / durationInMinutes * 100 + light / durationInMinutes * 100) -
          (rem / durationInMinutes * 100 + deep / durationInMinutes * 100);

  // Calcolo del GoodSleepIndex di base
  double baseGSI = 0;
  if (phaseBalance <= 30) {
    baseGSI = 3.0;
  } else if (phaseBalance > 30 && phaseBalance <= 40) {
    baseGSI = 2.0;
  } else if (phaseBalance > 40 && phaseBalance <= 50) {
    baseGSI = 1.0;
  }

  // Calcolo del Rem Score
  double remScore = 1;
  if (rem / durationInMinutes * 100 > 20) {
    remScore = 0.5;
  } else if (rem >= 0 && rem <= 5) {
    remScore = 0.1;
  } else if (rem > 5 && rem <= 10) {
    remScore = 0.2;
  } else if (rem > 10 && rem <= 15) {
    remScore = 0.3;
  } else if (rem > 15 && rem <= 20) {
    remScore = rem * 0.4;
  }

  // Calcolo del Deep Score
  double deepScore = 1;
  if (deep > 0.15) {
    deepScore = 0.5;
  } else if (deep >= 0 && deep <= 5) {
    deepScore = 0.15;
  } else if (deep > 5 && deep <= 0.10) {
    deepScore = 0.3;
  } else if (deep > 10 && deep <= 0.15) {
    deepScore = 0.45;
  }

  // Calcolo del GSI finale
  double finalGSI = (baseGSI * (remScore + deepScore)) +
      ((durationInMinutes >= 7 && durationInMinutes <= 9)
              ? 1.0
              : ((durationInMinutes > 6 && durationInMinutes < 10)
                  ? 0.0
                  : -1.0)) *
          efficiency;

  // Limita il valore finale tra 0 e 5
  finalGSI = finalGSI.clamp(0.0, 5.0);

  return finalGSI;
}
