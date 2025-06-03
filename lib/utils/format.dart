class Format {
  static String toTime(double value, Duration totalDuration) {
    final totalSeconds = totalDuration.inSeconds;
    final elapsedSeconds = (value * totalSeconds).round();

    final minutes = (elapsedSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (elapsedSeconds % 60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }
}
