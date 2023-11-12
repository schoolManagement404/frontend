class CalenderModel {
  List<OneDayEvents>? oneDayEvents;
  List<RangeEvents>? rangeEvents;

  CalenderModel({this.oneDayEvents, this.rangeEvents});

  CalenderModel.fromJson(Map<String, dynamic> json) {
    if (json['one_day_events'] != null) {
      oneDayEvents = <OneDayEvents>[];
      json['one_day_events'].forEach((v) {
        oneDayEvents!.add(OneDayEvents.fromJson(v));
      });
    }
    if (json['range_events'] != null) {
      rangeEvents = <RangeEvents>[];
      json['range_events'].forEach((v) {
        rangeEvents!.add(RangeEvents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (oneDayEvents != null) {
      data['one_day_events'] = oneDayEvents!.map((v) => v.toJson()).toList();
    }
    if (rangeEvents != null) {
      data['range_events'] = rangeEvents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OneDayEvents {
  String? eventName;
  String? date;
  bool? isHoliday;

  OneDayEvents({this.eventName, this.date, this.isHoliday});

  OneDayEvents.fromJson(Map<String, dynamic> json) {
    eventName = json['eventName'];
    date = json['date'];
    isHoliday = json['isHoliday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventName'] = eventName;
    data['date'] = date;
    data['isHoliday'] = isHoliday;
    return data;
  }
}

class RangeEvents {
  String? eventName;
  String? start;
  String? end;
  bool? isHoliday;

  RangeEvents({this.eventName, this.start, this.end, this.isHoliday});

  RangeEvents.fromJson(Map<String, dynamic> json) {
    eventName = json['eventName'];
    start = json['start'];
    end = json['end'];
    isHoliday = json['isHoliday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventName'] = eventName;
    data['start'] = start;
    data['end'] = end;
    data['isHoliday'] = isHoliday;
    return data;
  }
}
