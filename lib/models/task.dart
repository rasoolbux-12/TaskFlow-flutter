class Task {
  String title;
  bool completed;
  String category;
  String dueDate;

  Task({
    required this.title,
    this.completed = false,
    this.category = "Personal",
    this.dueDate = "",
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'completed': completed,
      'category': category,
      'dueDate': dueDate,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      completed: json['completed'],
      category: json['category'] ?? "Personal",
      dueDate: json['dueDate'] ?? "",
    );
  }
}
