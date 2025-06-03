class Format {
  static String toTime(double value, Duration totalDuration) {
    final hour = 60;
    final totalSeconds = totalDuration.inSeconds;
    final elapsedSeconds = (value * totalSeconds).round();
    final isOverHour = totalDuration.inHours > 0;

    final hours = (elapsedSeconds ~/ (hour * hour));
    final minutes = (elapsedSeconds % (hour * hour) ~/ hour).toString().padLeft(
      2,
      '0',
    );
    final seconds = (elapsedSeconds % hour).toString().padLeft(2, '0');

    String getHourStr() =>
        isOverHour ? "${hours.toString().padLeft(2, '0')}:" : '';

    return '${getHourStr()}$minutes:$seconds';
  }
}
