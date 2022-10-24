import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTask extends StatefulWidget {
  const NewTask({Key? key, required this.addTask}) : super(key: key);
  final Function addTask;

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final _titleController = TextEditingController();
  DateTime? _chosenDate;

  void _submit() {
    final title = _titleController.text;

    if (title.isEmpty || _chosenDate == null) {
      return;
    }

    widget.addTask(title, _chosenDate);

    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2050))
        .then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        _chosenDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Name of task'),
            controller: _titleController,
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Text(_chosenDate == null
                    ? 'No chosed date'
                    : 'Chosen date: ${DateFormat.yMd().format(_chosenDate as DateTime)}'),
              ),
              IconButton(
                  onPressed: _showDatePicker,
                  icon: const Icon(Icons.calendar_month))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          RaisedButton(
            child: const Text('Add'),
            onPressed: _submit,
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
          )
        ],
      ),
    );
  }
}
