import 'package:flutter/material.dart';
import 'update_task_screen.dart';

class DPRScreen extends StatefulWidget {
  const DPRScreen({super.key});

  @override
  State<DPRScreen> createState() => _DPRScreenState();
}

class _DPRScreenState extends State<DPRScreen> {
  // 1. Remove hardcoded "abc" - Start with empty list
  List<Map<String, dynamic>> tasks = [];

  final TextEditingController _taskNameController = TextEditingController();

  // Function to handle slider updates from the other screen
  void _updateTaskProgress(int index, double newProgress) {
    setState(() {
      tasks[index]['progress'] = newProgress.toInt();
    });
  }

  // 2. Added Delete Function
  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Task deleted'), duration: Duration(seconds: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (tasks.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: const Text('General', style: TextStyle(color: Colors.grey, fontSize: 13)),
            ),
          Expanded(
            child: tasks.isEmpty 
              ? const Center(child: Text('Click + to create your first task', style: TextStyle(color: Colors.grey)))
              : ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) => _buildTaskItem(index),
                ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateTaskSheet(context),
        backgroundColor: Colors.blue.shade700,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  Widget _buildTaskItem(int index) {
    final task = tasks[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${index + 1}. ${task['name']}', 
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              // DELETE BUTTON
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                onPressed: () => _deleteTask(index),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey.shade100,
                child: Text('${task['progress']}%', 
                    style: const TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              const Spacer(),
              SizedBox(
                height: 36,
                child: OutlinedButton(
                  onPressed: () async {
                    // 3. FIX: Wait for the result from the Update screen
                    final double? result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UpdateTaskScreen(
                          taskName: task['name'],
                          initialProgress: task['progress'].toDouble(),
                        ),
                      ),
                    );
                    if (result != null) {
                      _updateTaskProgress(index, result);
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.blue.shade700),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('Update', style: TextStyle(color: Colors.blue.shade700)),
                ),
              ),
            ],
          ),
          const Divider(height: 32),
        ],
      ),
    );
  }

  void _showCreateTaskSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16, right: 16, top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Create Task', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text('Task Name', style: TextStyle(color: Colors.grey, fontSize: 14)),
            TextField(
              controller: _taskNameController,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'E.g - Excavation, Painting...'),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_taskNameController.text.isNotEmpty) {
                    setState(() {
                      tasks.add({'name': _taskNameController.text, 'progress': 0, 'category': 'General'});
                    });
                    _taskNameController.clear();
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade700),
                child: const Text('Done', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}