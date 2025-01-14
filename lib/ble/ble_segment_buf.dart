class SegmentBuf {
  List<int> buf = [];
  int totalLen = 0;
  DateTime lastUpdateTime = DateTime.now();

  void add(List<int> data) {
    buf.addAll(data);
    lastUpdateTime = DateTime.now();
  }

  void clear() {
    buf.clear();
    totalLen = 0;
  }

  bool isEmpty() {
    return buf.isEmpty;
  }

  bool isOutDate() {
    if (DateTime.now().difference(lastUpdateTime).abs() >
        const Duration(seconds: 5)) {
      return true;
    }

    return false;
  }
}
