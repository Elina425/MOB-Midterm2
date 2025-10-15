import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/homework_repo.dart';
import '../models/homework.dart';

abstract class HomeworkEvent {}
class LoadHomeworks extends HomeworkEvent {}
class AddHomework extends HomeworkEvent {
  final Homework hw;
  AddHomework(this.hw);
}
class ToggleHomework extends HomeworkEvent {
  final String id;
  ToggleHomework(this.id);
}

class HomeworkState {
  final List<Homework> homeworks;
  HomeworkState(this.homeworks);
}

class HomeworkBloc extends Bloc<HomeworkEvent, HomeworkState> {
  final HomeworkStorage repo;

  HomeworkBloc(this.repo) : super(HomeworkState([])) {
    on<LoadHomeworks>((event, emit) => emit(HomeworkState(repo.getAll())));
    on<AddHomework>((event, emit) async {
      await repo.add(event.hw);
      emit(HomeworkState(repo.getAll()));
    });
    on<ToggleHomework>((event, emit) async {
      await repo.toggle(event.id);
      emit(HomeworkState(repo.getAll()));
    });
    add(LoadHomeworks());
  }
}
