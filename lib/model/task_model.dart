// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum Status { pending, completed }

class TaskModel {
  String? taskName;
  String? date;
  Status status;

  TaskModel({
    this.taskName,
    this.date,
    this.status = Status.pending,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'taskName': taskName,
      'date': date,
      'status': status.toString().split('.').last,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskName: map['taskName'] != null ? map['taskName'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      status: Status.values
          .firstWhere((e) => e.toString().split('.').last == map['status']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
