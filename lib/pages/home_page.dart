import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/helpers/global_variable.dart';
import 'package:todo_app/helpers/provider.dart';
import 'package:todo_app/pages/input_box.dart';
import 'package:todo_app/pages/list_tile.dart';

class Newpage extends StatefulWidget {
  const Newpage({super.key});

  @override
  State<Newpage> createState() => _NewpageState();
}

class _NewpageState extends State<Newpage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AppStateModel>(context, listen: false).initstate();
    });
   
  }

  @override
  Widget build(BuildContext context) {
    final taskprovider = Provider.of<AppStateModel>(context);

    return Scaffold(
      backgroundColor: lightMode ? Colors.white : Colors.black,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          setState(() {
            textinputs = true;
          });
        },
      ),
      body: Stack(
        children: [
          // Banner image with timer
          Container(
            height: 170,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/dasdas.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    taskprovider.formatDuration(d),
                    style: TextStyle(
                      fontSize: 60,
                      color: const Color.fromARGB(255, 196, 255, 201),

                      fontFamily: 'Wooden Log',
                    ),
                  ),
                  Text(
                    today,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 196, 255, 201),
                      fontSize: 25,
                      fontFamily: 'Wooden Log',
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Rounded container with tasks
          Container(
            margin: EdgeInsets.only(top: 140),
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: lightMode ? Colors.white : Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child:
                taskprovider.enteries.isNotEmpty
                    ? ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "have you finished ?",
                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      lightMode ? Colors.black : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Green Love',
                                ),
                              ),
                            ),
                            ListBox(),
                          ],
                        ),
                      ],
                    )
                    : Center(
                      child: Text(
                        "No tasks for today",
                        style: TextStyle(
                          fontSize: 16,
                          color: lightMode ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                lightMode = !lightMode;
              });
            },
            icon: Icon(Icons.lightbulb_circle, size: 30, color: Colors.white),
          ),

          // Input box UI
          if (textinputs) InputBox(),
        ],
      ),
    );
  }
}
