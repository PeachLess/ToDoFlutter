import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

class TaskList extends StatelessWidget {
  const TaskList(
      {Key? key,
      required this.tasks,
      required this.delete,
      required this.setDone})
      : super(key: key);
  final List<Task> tasks;
  final Function delete;
  final Function setDone;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: tasks.isEmpty
            ? const Center(
                child: Text(
                'There is no tasks',
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ))
            : ListView.builder(
                itemBuilder: (ctx, ind) {
                  return Card(
                      child:
                          // tasks[ind].isDone ?
                          ListTile(
                    title: Text(tasks[ind].title),
                    subtitle: Text(DateFormat.MMMd().format(tasks[ind].date)),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () => delete(tasks[ind].id),
                    ),
                  ));
                  //     : CheckboxListTile(
                  //         title: Text(tasks[ind].title),
                  //         subtitle: Text(
                  //             DateFormat.MMMd().format(tasks[ind].date)),
                  //         onChanged: (val) => setDone(tasks[ind].id),
                  //         value: tasks[ind].isDone),
                  // margin: const EdgeInsets.symmetric(
                  //     vertical: 6, horizontal: 10));
                },
                itemCount: tasks.length,
              ));
  }
}
