int calculateReadingTime(String content) {
  final worldsCount = content.split(RegExp(r'\s+')).length;
  final avgHumanReadingSpeed = 200;
  final readingTime = worldsCount / avgHumanReadingSpeed;
  return readingTime.ceil();
}
