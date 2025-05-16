import 'package:flutter/material.dart';
import 'package:primeiro_projeto/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({super.key, required this.child}) : super(child: child);

  @override
  // ignore: overridden_fields
  final Widget child;

  final List<Task> taskList = [
    Task("Aprender Flutter", "assets/images/dash.png", 5),
    Task("Andar de Bike", "assets/images/bike.webp", 3),
    Task("Meditar", "assets/images/meditar.jpeg", 4),
    Task("Ler", "assets/images/livro.jpg", 3),
    Task("Jogar", "assets/images/jogar.jpg", 1),
  ];

  void newTask(String name, int difficulty, String photo, int level) {
    taskList.add(Task(
      name,
      photo,
      difficulty,
      level,
    ));
  }

  static TaskInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskInherited>();
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
