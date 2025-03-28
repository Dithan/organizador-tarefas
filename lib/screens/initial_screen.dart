import 'package:flutter/material.dart';
import 'package:primeiro_projeto/data/task_inherited.dart';
import 'package:primeiro_projeto/screens/form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.blue,
        title: Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Tarefas",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 8, bottom: 120),
        children: TaskInherited.of(context)!.taskList,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (contextNew) {
            return FormScreen(
              taskContext: context,
            );
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
