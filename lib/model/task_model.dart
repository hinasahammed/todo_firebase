import 'dart:convert';

class TaskModel {
  final String taskName;
  final String date;
  final bool isCompleted;

  TaskModel({
    required this.taskName,
    required this.date,
    this.isCompleted = false,
  });

  TaskModel copyWith({
    String? taskName,
    String? date,
    bool? isCompleted,
  }) {
    return TaskModel(
      taskName: taskName ?? this.taskName,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'taskName': taskName,
      'date': date,
      'isCompleted': isCompleted,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskName: map['taskName'] as String,
      date: map['date'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) => TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TaskModel(taskName: $taskName, date: $date, isCompleted: $isCompleted)';

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.taskName == taskName &&
      other.date == date &&
      other.isCompleted == isCompleted;
  }

  @override
  int get hashCode => taskName.hashCode ^ date.hashCode ^ isCompleted.hashCode;
}
