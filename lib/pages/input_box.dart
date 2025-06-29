import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/helpers/global_variable.dart';
import 'package:todo_app/helpers/provider.dart';
import 'dart:ui';

class InputBox extends StatefulWidget {
  const InputBox({super.key});

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<AppStateModel>(context);
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Container(
        color: Colors.black.withOpacity(0.4),
        // color: Colors.amber,
        child: Center(
          child: Container(
            margin: EdgeInsets.all(30),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: lightMode ? Colors.white : Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    cursorColor: Colors.green,
                    style: TextStyle(
                      color: lightMode ? Colors.black : Colors.white,
                    ),
                    controller: myController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 25),

                      prefixIcon: Icon(Icons.pending_actions_sharp),
                      hintText: "Add your task",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: lightMode ? Colors.grey : Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 20,
                        ),

                        overlayColor: Colors.green[900],
                      ),
                      onPressed: () {
                        taskProvider.toggleInputBox();
                        myController.clear();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 20,
                        ),

                        overlayColor: Colors.green[900],
                      ),
                      onPressed: () {
                        if (myController.text.trim().isNotEmpty) {
                          taskProvider.write({
                            'title': myController.text.trim(),
                            'completion': false,
                          });
                        }
                        taskProvider.toggleInputBox();
                      },
                      child: Text(
                        "Add",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
