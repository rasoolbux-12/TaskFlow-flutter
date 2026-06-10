import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'models/task.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskFlow',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [
    Task(title: "Learn Flutter", completed: true),
    Task(title: "Build TaskFlow UI"),
    Task(title: "Study Dart"),
    Task(title: "Complete Internship Project"),
  ];

  final TextEditingController taskController = TextEditingController();
  final TextEditingController editController = TextEditingController();

  String selectedCategory = "Personal";
  String searchText = "";
  String selectedDate = "";
  bool isDarkMode = false;

  Future<void> saveDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', isDarkMode);
  }

  Future<void> loadDarkMode() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      isDarkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  Color getCategoryColor(String category) {
    switch (category) {
      case "Study":
        return Colors.blue;

      case "Work":
        return Colors.orange;

      case "Personal":
        return Colors.green;

      default:
        return Colors.grey;
    }
  }

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning 👋";
    } else if (hour < 17) {
      return "Good Afternoon ☀️";
    } else if (hour < 20) {
      return "Good Evening 🌇";
    } else {
      return "Good Night 🌙";
    }
  }

  int get completedTasks => tasks.where((task) => task.completed).length;

  int get remainingTasks => tasks.where((task) => !task.completed).length;

  List<Task> get filteredTasks {
    return tasks.where((task) {
      return task.title.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();

    final taskList = tasks.map((task) => jsonEncode(task.toJson())).toList();

    await prefs.setStringList('tasks', taskList);
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();

    final taskList = prefs.getStringList('tasks');

    if (taskList != null) {
      setState(() {
        tasks = taskList
            .map((task) => Task.fromJson(jsonDecode(task)))
            .toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadTasks();
    loadDarkMode();
  }

  void showAddTaskDialog() {
    String localDate = "";
    String localCategory = selectedCategory;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text("Add New Task"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: taskController,
                    decoration: const InputDecoration(
                      hintText: "Enter task title",
                    ),
                  ),

                  const SizedBox(height: 15),

                  DropdownButtonFormField<String>(
                    value: localCategory,
                    decoration: const InputDecoration(labelText: "Category"),
                    items: const [
                      DropdownMenuItem(value: "Study", child: Text("Study")),
                      DropdownMenuItem(value: "Work", child: Text("Work")),
                      DropdownMenuItem(
                        value: "Personal",
                        child: Text("Personal"),
                      ),
                    ],

                    onChanged: (value) {
                      setDialogState(() {
                        localCategory = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 15),

                  ElevatedButton.icon(
                    icon: const Icon(Icons.calendar_today),
                    label: Text(
                      localDate.isEmpty ? "Select Due Date" : localDate,
                    ),
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),
                      );

                      if (picked != null) {
                        setDialogState(() {
                          localDate = DateFormat('dd MMM yyyy').format(picked);
                        });
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    taskController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (taskController.text.isNotEmpty) {
                      setState(() {
                        tasks.add(
                          Task(
                            title: taskController.text,
                            category: localCategory,
                            dueDate: localDate,
                          ),
                        );
                      });

                      saveTasks();

                      taskController.clear();
                      selectedCategory = "Personal";
                      selectedDate = "";
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Add"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void showEditTaskDialog(int index) {
    editController.text = tasks[index].title;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Task"),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(hintText: "Edit task title"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (editController.text.isNotEmpty) {
                  setState(() {
                    tasks[index].title = editController.text;
                  });

                  saveTasks();

                  Navigator.pop(context);
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey.shade900 : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.grey.shade900 : Colors.white,
        elevation: 0,
        title: Text(
          "TaskFlow",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          Row(
            children: [
              Icon(
                Icons.wb_sunny,
                color: isDarkMode ? Colors.grey : Colors.orange,
              ),

              Switch(
                value: isDarkMode,
                onChanged: (value) async {
                  setState(() {
                    isDarkMode = value;
                  });

                  await saveDarkMode();
                },
              ),

              Icon(
                Icons.nightlight_round,
                color: isDarkMode ? Colors.blue : Colors.grey,
              ),

              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            Text(
              getGreeting(),
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              "You have ${tasks.length} tasks today",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 25),

            // Statistics Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Colors.orange, Colors.deepOrange],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        "$completedTasks",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Completed",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  Container(height: 50, width: 1, color: Colors.white30),
                  Column(
                    children: [
                      Text(
                        "$remainingTasks",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Remaining",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              decoration: InputDecoration(
                hintText: "Search tasks...",
                hintStyle: TextStyle(
                  color: isDarkMode ? Colors.grey : Colors.black54,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),

            const SizedBox(height: 20),

            Text(
              "Today's Tasks",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: filteredTasks.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.assignment_outlined,
                            size: 80,
                            color: isDarkMode ? Colors.white70 : Colors.grey,
                          ),

                          const SizedBox(height: 15),

                          Text(
                            "No Tasks Yet",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            "Tap + to create your first task",
                            style: TextStyle(
                              color: isDarkMode ? Colors.white60 : Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredTasks.length,
                      itemBuilder: (context, index) {
                        final task = filteredTasks[index];
                        final originalIndex = tasks.indexOf(task);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.grey.shade800
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              onTap: () {
                                setState(() {
                                  task.completed = !task.completed;
                                });

                                saveTasks();
                              },
                              leading: Icon(
                                task.completed
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: task.completed
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                              title: Text(
                                task.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: task.completed
                                      ? Colors.grey
                                      : (isDarkMode
                                            ? Colors.white
                                            : Colors.black),
                                  decoration: task.completed
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task.category.isEmpty
                                        ? "Personal"
                                        : task.category,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: getCategoryColor(task.category),
                                    ),
                                  ),

                                  if (task.dueDate.isNotEmpty)
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_today,
                                          size: 12,
                                          color: Colors.grey,
                                        ),

                                        const SizedBox(width: 4),

                                        Text(
                                          task.dueDate,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      showEditTaskDialog(originalIndex);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        tasks.removeAt(originalIndex);
                                      });

                                      saveTasks();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        onPressed: showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
