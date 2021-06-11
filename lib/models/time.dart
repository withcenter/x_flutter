class Time {
  String time;

  Time(this.time);

  @override
  String toString() => 'Time(time: $time)';

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(json['time'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
    };
  }
}
