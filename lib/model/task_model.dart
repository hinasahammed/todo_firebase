class TaskModel {
  String taskName;
  final String date;
  bool isCompleted;

  TaskModel({
    required this.taskName,
    required this.date,
    this.isCompleted = false, 
  });
}
