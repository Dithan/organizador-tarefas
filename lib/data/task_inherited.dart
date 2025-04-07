import 'package:flutter/material.dart';
import 'package:primeiro_projeto/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({super.key, required this.child}) : super(child: child);

  @override
  // ignore: overridden_fields
  final Widget child;

  final List<Task> taskList = [
    Task(
      nome: "Aprender Flutter",
      image: "assets/images/dash.png",
      dificuldade: 5,
    ),
    Task(
      nome: "Andar de Bike",
      image: "assets/images/bike.webp",
      dificuldade: 3,
    ),
    Task(
      nome: "Meditar",
      image: "assets/images/meditar.jpeg",
      dificuldade: 4,
    ),
    Task(
      nome: "Ler",
      image: "assets/images/livro.jpg",
      dificuldade: 3,
    ),
    Task(
      nome: "Jogar",
      image: "assets/images/jogar.jpg",
      dificuldade: 1,
    ),
  ];

  void newTask(String name, int difficulty, String photo) {
    taskList.add(Task(nome: name, image: photo, dificuldade: difficulty));
  }

  static TaskInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskInherited>();
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
