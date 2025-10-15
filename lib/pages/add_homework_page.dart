import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/homework_bloc.dart';
import '../models/homework.dart';
import 'package:go_router/go_router.dart';

class AddHomeworkPage extends StatefulWidget {
  const AddHomeworkPage({super.key});

  @override
  State<AddHomeworkPage> createState() => _AddHomeworkPageState();
}

class _AddHomeworkPageState extends State<AddHomeworkPage> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _titleController = TextEditingController();
  DateTime? _dueDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Homework')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(labelText: 'Subject'),
                validator: (v) => v!.isEmpty ? 'Enter subject' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Homework Title'),
                validator: (v) => v!.isEmpty ? 'Enter title' : null,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                      child: Text(_dueDate == null
                          ? 'No date selected'
                          : 'Due: ${_dueDate!.toLocal().toString().split(" ")[0]}')),
                  ElevatedButton(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                        initialDate: DateTime.now(),
                      );
                      if (date != null) setState(() => _dueDate = date);
                    },
                    child: const Text('Select Date'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Save'),
                onPressed: () {
                  if (_formKey.currentState!.validate() && _dueDate != null) {
                    final hw = Homework(
                      subject: _subjectController.text,
                      title: _titleController.text,
                      dueDate: _dueDate!,
                    );
                    context.read<HomeworkBloc>().add(AddHomework(hw));
                    context.pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
