class ApplianceModel {
  Map<String, Segment> segments = {};
  String deviceFlued = ''; //TODO:check if null
  String segmentLabel = '';
  double meters = 0;
  String roomName = 'N/A';
  String tdUnit = '';
  double totalLength = 15.0;
  double tdMu = 0;
  double tdKG = 0;
  double totalLp = 0;
  double totalHp = 0;
}

class Segment {
  Segment(this.segmentMeters, this.lineHpLp);
  double segmentMeters = 0;
  String lineHpLp = '';
  double tdMu = 0;
  @override
  String toString() {
    // TODO: implement toString
    return tdMu.toString();
  }
}
