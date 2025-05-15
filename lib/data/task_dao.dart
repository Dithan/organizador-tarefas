// ignore_for_file: avoid_print

import 'package:primeiro_projeto/components/task.dart';
import 'package:primeiro_projeto/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT'
      ')';

  static const String _tablename = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  // CRUD

  // Salva nova tarefa
  save(Task tarefa) async {
    print("Iniciando o save: ");
    // Abre o banco de dados
    final Database bancoDeDados = await getDatabase();
    // Verifica se a tabela existe
    var itemExists = await find(tarefa.nome);
    Map<String, dynamic> taskMap = toMap(tarefa);
    if (itemExists.isEmpty) {
      print("A tarefa não existia");
      return await bancoDeDados.insert(
        _tablename,
        taskMap,
      );
    } else {
      // Se a tarefa for duplicada, aplica-se o update
      print("A tarefa já existia");
      return await bancoDeDados.update(
        _tablename,
        taskMap,
        where: '$_name = ?',
        whereArgs: [tarefa.nome],
      );
    }
  }

  Map<String, dynamic> toMap(Task tarefa) {
    print("Convertendo tarefa em Map: ");
    final Map<String, dynamic> mapaDeTarefas = {};
    mapaDeTarefas[_name] = tarefa.nome;
    mapaDeTarefas[_difficulty] = tarefa.dificuldade;
    mapaDeTarefas[_image] = tarefa.image;
    print("Mapa de Tarefas: $mapaDeTarefas");
    return mapaDeTarefas;
  }

  // Consulta tarefas
  Future<List<Task>> findAll() async {
    print("Acessando o findAll: ");
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tablename);
    print("Procurando dados no banco... encontrado: $result");
    return toList(result);
  }

  // Converte Map para List
  List<Task> toList(List<Map<String, dynamic>> listaDeTarefas) {
    print("Convertendo to list");
    final List<Task> tarefas = [];
    for (Map<String, dynamic> linha in listaDeTarefas) {
      final Task tarefa = Task(
          nome: linha[_name],
          image: linha[_image],
          dificuldade: linha[_difficulty]);
      tarefas.add(tarefa);
    }
    print("Lista de tarefas: $tarefas");
    return tarefas;
  }

  // Consulta apenas uma linha da tabela
  Future<List<Task>> find(String nomedaTarefa) async {
    print("Acessando find: ");
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados
        .query(_tablename, where: '$_name = ?', whereArgs: [nomedaTarefa]);
    print("Tarefa encontrada: ${toList(result)}");
    return toList(result);
  }

  delete(String nomeDaTarefa) async {
    print("Deletando tarefa: $nomeDaTarefa");
    final Database bancoDeDados = await getDatabase();
    return bancoDeDados
        .delete(_tablename, where: '$_name = ?', whereArgs: [nomeDaTarefa]);
  }
}
