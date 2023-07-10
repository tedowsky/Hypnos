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
  } else if (phaseBalance > 30 && phaseBalance <= 35) {
    baseGSI = 2.5;
  } else if (phaseBalance > 35 && phaseBalance <= 40) {
    baseGSI = 2.0;
  } else if (phaseBalance > 40 && phaseBalance <= 45) {
    baseGSI = 1.5;
  } else {
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
    remScore = 0.4;
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

  double durationMark = 0;
  if (durationInMinutes >= 420 && durationInMinutes <= 540) {
    // if sleep between 7 and 9 hours
    durationMark = 1;
  } else if (durationInMinutes > 390 && durationInMinutes < 570) {
    // if sleep between 6 and 7 or 9 and 10 hours
    durationMark = 0.5;
  } else if (durationInMinutes > 360 && durationInMinutes < 600) {
    // if sleep between 5 and 6 or 10 and 11 hours
    durationMark = 0.25;
  } else {
    durationMark = -0.25;
  }

  double efficencyMark = 0;
  if (efficiency >= 0.95) {
    efficencyMark = 1;
  } else if (efficiency >= 0.85 && efficiency < 0.95) {
    efficencyMark = 0.75;
  } else if (efficiency >= 0.75 && efficiency < 0.85) {
    efficencyMark = 0.5;
  } else {
    efficencyMark = 0;
  }

  // Calcolo del GSI finale
  double finalGSI =
      ((baseGSI * (remScore + deepScore)) + durationMark) + efficencyMark;

  // Limita il valore finale tra 0 e 5
  finalGSI = finalGSI.clamp(0.00, 5.00);

  return finalGSI;
}
