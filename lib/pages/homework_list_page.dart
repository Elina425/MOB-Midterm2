import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/homework_bloc.dart';
import '../models/homework.dart';
import 'package:intl/intl.dart';

class HomeworkListPage extends StatelessWidget {
  const HomeworkListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Homework Tracker')),
      body: BlocBuilder<HomeworkBloc, HomeworkState>(
        builder: (context, state) {
          if (state.homeworks.isEmpty) {
            return const Center(child: Text('No homework yet.'));
          }
          return ListView.builder(
            itemCount: state.homeworks.length,
            itemBuilder: (_, i) {
              final hw = state.homeworks[i];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: Checkbox(
                    value: hw.isCompleted,
                    onChanged: (_) => context
                        .read<HomeworkBloc>()
                        .add(ToggleHomework(hw.id)),
                  ),
                  title: Text(
                    hw.title,
                    style: TextStyle(
                      decoration: hw.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle: Text(
                      '${hw.subject} • Due: ${DateFormat.yMMMd().format(hw.dueDate)}'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
