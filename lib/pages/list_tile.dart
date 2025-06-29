import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/helpers/global_variable.dart';
import 'package:todo_app/helpers/provider.dart';

class ListBox extends StatefulWidget {
  const ListBox({super.key});

  @override
  State<ListBox> createState() => _ListBoxState();
}

class _ListBoxState extends State<ListBox> {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<AppStateModel>(context);
    return ListView.builder(
      shrinkWrap: true, // Important for using ListView inside Column
      physics: NeverScrollableScrollPhysics(),
      itemCount:
          taskProvider.enteries.length, // Use enteries.length for consistency
      itemBuilder: (BuildContext context, int index) {
        final entry = taskProvider.enteries[index];
        final key = entry.key; // Use the unique Hive key
        final task = entry.value;

        if (task is Map && task.containsKey('title')) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Slidable(
              // *** IMPORTANT CHANGE HERE ***
              key: ValueKey(key), // Use the unique Hive key as the ValueKey
              endActionPane: ActionPane(
                motion: const StretchMotion(),
                extentRatio: 0.25,
                children: [
                  SlidableAction(
                    onPressed: (context) => taskProvider.taskRemoval(key),
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: lightMode ? Colors.grey : Colors.white,
                  ),
                  color: lightMode ? Colors.white : Colors.black,
                ),
                child: CheckboxListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  checkColor: Colors.white,
                  activeColor: Colors.green,
                  title: Text(
                    task['title'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: lightMode ? Colors.black : Colors.white,
                      decoration:
                          task['completion']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                    ),
                  ),
                  value: task['completion'],
                  onChanged: (value) {
                    taskProvider.updateTasks(key, value ?? false);
                  },
                ),
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
