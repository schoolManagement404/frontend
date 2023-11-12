class CalenderModel {
  List<OneDayEvents>? oneDayEvents;
  List<RangeEvents>? rangeEvents;

  CalenderModel({this.oneDayEvents, this.rangeEvents});

  CalenderModel.fromJson(Map<String, dynamic> json) {
    if (json['one_day_events'] != null) {
      oneDayEvents = <OneDayEvents>[];
      json['one_day_events'].forEach((v) {
        oneDayEvents!.add(new OneDayEvents.fromJson(v));
      });
    }
    if (json['range_events'] != null) {
      rangeEvents = <RangeEvents>[];
      json['range_events'].forEach((v) {
        rangeEvents!.add(new RangeEvents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.oneDayEvents != null) {
      data['one_day_events'] =
          this.oneDayEvents!.map((v) => v.toJson()).toList();
    }
    if (this.rangeEvents != null) {
      data['range_events'] = this.rangeEvents!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventName'] = this.eventName;
    data['date'] = this.date;
    data['isHoliday'] = this.isHoliday;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventName'] = this.eventName;
    data['start'] = this.start;
    data['end'] = this.end;
    data['isHoliday'] = this.isHoliday;
    return data;
  }
}
