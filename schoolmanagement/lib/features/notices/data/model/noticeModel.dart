// ignore_for_file: unnecessary_getters_setters

class Notice {
  String? _sId;
  String? _noticeId;
  List<String>? _noticeAttendance;
  bool? _isCompleted;
  String? _noticeTitle;
  String? _noticeDescription;
  String? _noticeDate;
  String? _noticeTime;
  String? _noticeVenue;
  String? _noticeStatus;
  String? _noticeType;
  int? _iV;
  String? _publishedDate;

  Notice(
      {String? sId,
      String? noticeId,
      List<String>? noticeAttendance,
      bool? isCompleted,
      String? noticeTitle,
      String? noticeDescription,
      String? noticeDate,
      String? noticeTime,
      String? noticeVenue,
      String? noticeStatus,
      String? noticeType,
      int? iV,
      String? publishedDate}) {
    if (sId != null) {
      _sId = sId;
    }
    if (noticeId != null) {
      _noticeId = noticeId;
    }
    if (noticeAttendance != null) {
      _noticeAttendance = noticeAttendance;
    }
    if (isCompleted != null) {
      _isCompleted = isCompleted;
    }
    if (noticeTitle != null) {
      _noticeTitle = noticeTitle;
    }
    if (noticeDescription != null) {
      _noticeDescription = noticeDescription;
    }
    if (noticeDate != null) {
      _noticeDate = noticeDate;
    }
    if (noticeTime != null) {
      _noticeTime = noticeTime;
    }
    if (noticeVenue != null) {
      _noticeVenue = noticeVenue;
    }
    if (noticeStatus != null) {
      _noticeStatus = noticeStatus;
    }
    if (noticeType != null) {
      _noticeType = noticeType;
    }
    if (iV != null) {
      _iV = iV;
    }
    if (publishedDate != null) {
      _publishedDate = publishedDate;
    }
  }

  String? get sId => _sId;
  set sId(String? sId) => _sId = sId;
  String? get noticeId => _noticeId;
  set noticeId(String? noticeId) => _noticeId = noticeId;
  List<String>? get noticeAttendance => _noticeAttendance;
  set noticeAttendance(List<String>? noticeAttendance) =>
      _noticeAttendance = noticeAttendance;
  bool? get isCompleted => _isCompleted;
  set isCompleted(bool? isCompleted) => _isCompleted = isCompleted;
  String? get noticeTitle => _noticeTitle;
  set noticeTitle(String? noticeTitle) => _noticeTitle = noticeTitle;
  String? get noticeDescription => _noticeDescription;
  set noticeDescription(String? noticeDescription) =>
      _noticeDescription = noticeDescription;
  String? get noticeDate => _noticeDate;
  set noticeDate(String? noticeDate) => _noticeDate = noticeDate;
  String? get noticeTime => _noticeTime;
  set noticeTime(String? noticeTime) => _noticeTime = noticeTime;
  String? get noticeVenue => _noticeVenue;
  set noticeVenue(String? noticeVenue) => _noticeVenue = noticeVenue;
  String? get noticeStatus => _noticeStatus;
  set noticeStatus(String? noticeStatus) => _noticeStatus = noticeStatus;
  String? get noticeType => _noticeType;
  set noticeType(String? noticeType) => _noticeType = noticeType;
  int? get iV => _iV;
  set iV(int? iV) => _iV = iV;
  String? get publishedDate => _publishedDate;
  set publishedDate(String? publishedDate) => _publishedDate = publishedDate;

  Notice.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _noticeId = json['notice_id'];
    _noticeAttendance = json['notice_attendance'].cast<String>();
    _isCompleted = json['is_completed'];
    _noticeTitle = json['notice_title'];
    _noticeDescription = json['notice_description'];
    _noticeDate = json['notice_date'];
    _noticeTime = json['notice_time'];
    _noticeVenue = json['notice_venue'];
    _noticeStatus = json['notice_status'];
    _noticeType = json['notice_type'];
    _iV = json['__v'];
    _publishedDate = json['published_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = _sId;
    data['notice_id'] = _noticeId;
    data['notice_attendance'] = _noticeAttendance;
    data['is_completed'] = _isCompleted;
    data['notice_title'] = _noticeTitle;
    data['notice_description'] = _noticeDescription;
    data['notice_date'] = _noticeDate;
    data['notice_time'] = _noticeTime;
    data['notice_venue'] = _noticeVenue;
    data['notice_status'] = _noticeStatus;
    data['notice_type'] = _noticeType;
    data['__v'] = _iV;
    data['published_date'] = _publishedDate;
    return data;
  }
}
