class Task {
  final String id;
  final String name;
  final String category;
  double progress; // 0.0 to 100.0

  Task({
    required this.id,
    required this.name,
    this.category = 'General',
    this.progress = 0.0,
  });
}