extension Capitalize on String {
  String capitalizeEachWord() {
    return trim()
        .split(RegExp(r'\s+'))
        .map(
          (word) =>
              word.isEmpty ? '' : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}',
        )
        .join(' ');
  }
}

extension DateTimeFormatter on DateTime {
  String formatDate() {
    final Duration diff = DateTime.now().difference(this);

    if (diff.inSeconds < 60) {
      return '${diff.inSeconds}s ago';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    }
    return '${diff.inDays}d ago';
  }
}
