import 'package:flutter/material.dart';
import './widgets/task_list.dart';
import './widgets/new_task.dart';
import './models/task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'To Do List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Task> _userTasks = [];

  void _addNewTask(String title, DateTime date) {
    final newTask = Task(
        id: DateTime.now().toString(),
        title: title,
        isDone: false,
        date: DateTime.now());

    setState(() {
      _userTasks.add(newTask);
    });
  }

  void _startAddNewTask(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              child: NewTask(addTask: _addNewTask),
              behavior: HitTestBehavior.opaque);
        });
  }

  void _deleteTask(String id) {
    setState(() {
      _userTasks.removeWhere((task) => task.id == id);
    });
  }

  void _setDone(String id) {
    setState(() {
      final doneTask = _userTasks.where((task) {
        return task.id == id;
      }).toList();
      doneTask[0].isDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(widget.title),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          height:
              MediaQuery.of(context).size.height - appBar.preferredSize.height,
          child: TaskList(
            tasks: _userTasks,
            delete: _deleteTask,
            setDone: _setDone,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTask(context),
        tooltip: 'Add new task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
