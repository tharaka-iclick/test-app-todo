import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_todo_app/core/common_widgets/common_alert_dialog_box.dart';
import 'package:test_todo_app/core/theme/dimensions.dart';
import 'package:test_todo_app/core/theme/skin.dart';
import 'package:test_todo_app/modules/todo_home/domain/entities/todo.dart';
import 'package:test_todo_app/modules/todo_home/presentation/bloc/todo_bloc.dart';
import 'package:test_todo_app/modules/todo_home/presentation/widgets/add_button.dart';
import 'package:test_todo_app/modules/todo_home/presentation/widgets/todo_item.dart';

class TodoHome extends StatefulWidget {
  const TodoHome({super.key});

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TodoBloc>().add(TodoFetchAll());
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _showEditTodoDialog(BuildContext blocContext, Todo todo) {
    _titleController.text = todo.title;
    _descriptionController.text = todo.description ?? '';

    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: BlocProvider.of<TodoBloc>(blocContext),
        child: AlertDialog(
          title: const Text('Edit Todo'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Title is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSimensions.marginMedium),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description (optional)',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final updatedTodo = todo.copyWith(
                    title: _titleController.text.trim(),
                    description: _descriptionController.text.trim(),
                  );
                  BlocProvider.of<TodoBloc>(
                    blocContext,
                  ).add(TodoUpdate(todo: updatedTodo));
                  Navigator.of(dialogContext).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Skin.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddTodoDialog(BuildContext blocContext) {
    _titleController.clear();
    _descriptionController.clear();

    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: BlocProvider.of<TodoBloc>(blocContext),
        child: AlertDialog(
          title: const Text('Add New Todo'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: AppSimensions.marginMedium),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description (optional)',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final todo = Todo(
                  id: '',
                  title: _titleController.text.trim(),
                  description: _descriptionController.text.trim(),
                  isCompleted: false,
                );
                BlocProvider.of<TodoBloc>(blocContext).add(TodoAdd(todo: todo));
                Navigator.of(dialogContext).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Skin.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleTodo(Todo todo, BuildContext blocContext) {
    final updatedTodo = todo.copyWith(isCompleted: !todo.isCompleted);
    BlocProvider.of<TodoBloc>(blocContext).add(TodoUpdate(todo: updatedTodo));
  }

  void _deleteTodo(String todoId, BuildContext blocContext) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: BlocProvider.of<TodoBloc>(blocContext),
        child: CommonDialog(
          title: 'Delete Todo',
          message: const Text('Are you sure you want to delete this todo?'),
          confirmText: 'Delete',
          cancelText: 'Cancel',
          confirmButtonColor: Colors.red,
          onPressed: () {
            BlocProvider.of<TodoBloc>(
              blocContext,
            ).add(TodoDelete(todoId: todoId));
            Navigator.of(dialogContext).pop();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is TodoFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.failure.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(AppSimensions.paddingMedium),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: AppSimensions.paddingMedium,
                ),
                child: AddButton(
                  buttonText: 'Add Todo',
                  onPressed: () => _showAddTodoDialog(context),
                ),
              ),

              Expanded(child: _buildTodoList(state)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTodoList(TodoState state) {
    if (state is TodoLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is TodoFailure) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: AppSimensions.marginMedium),
            Text(
              'Error loading todos',
              style: TextStyle(
                fontSize: AppSimensions.fontSizeLarge,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: AppSimensions.marginSmall),
            Text(
              state.failure.message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppSimensions.fontSizeMedium,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    if (state is TodoSucces) {
      if (state.todos.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 64,
                color: Colors.grey[400],
              ),
              const SizedBox(height: AppSimensions.marginMedium),
              Text(
                'No todos yet',
                style: TextStyle(
                  fontSize: AppSimensions.fontSizeLarge,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: AppSimensions.marginSmall),
              Text(
                'Tap "Add Todo" to create your first todo',
                style: TextStyle(
                  fontSize: AppSimensions.fontSizeMedium,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: () async {
          context.read<TodoBloc>().add(TodoFetchAll());
        },
        child: ListView.builder(
          itemCount: state.todos.length,
          itemBuilder: (context, index) {
            final todo = state.todos[index];
            return TodoItem(
              todo: todo,
              onToggle: () => _toggleTodo(todo, context),
              onDelete: () => _deleteTodo(todo.id, context),
              onTap: () => _showEditTodoDialog(context, todo),
            );
          },
        ),
      );
    }

    return const Center(child: Text('Welcome! Tap "Add Todo" to get started.'));
  }
}
