import 'package:flutter/material.dart';

class UpdateTaskScreen extends StatefulWidget {
  final String taskName;
  final double initialProgress; // Added this to fix the dpr_screen error

  const UpdateTaskScreen({
    super.key, 
    required this.taskName, 
    required this.initialProgress, // Fixed constructor
  });

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  late double _currentProgress;

  @override
  void initState() {
    super.initState();
    // Initialize the slider with the value passed from the list
    _currentProgress = widget.initialProgress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.taskName, style: const TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('TASK DETAILS', style: TextStyle(color: Colors.grey, fontSize: 12, letterSpacing: 1.2, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Text('${_currentProgress.toInt()}/100 %', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    const Icon(Icons.keyboard_arrow_down, color: Colors.blue),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _topButton('Update progress', true),
                const SizedBox(width: 12),
                _topButton('No progress today', false),
              ],
            ),
            const SizedBox(height: 30),
            
            // Slider Section - Now Fully Functional
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: _currentProgress,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.blue.shade50,
                    onChanged: (val) {
                      setState(() {
                        _currentProgress = val;
                      });
                    },
                  ),
                ),
                Text('${_currentProgress.toInt()}%', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            
            const SizedBox(height: 30),
            const Text('Photo/Video (0/30)', style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w500)),
            const SizedBox(height: 12),
            _addAttachmentBox(),
            
            const SizedBox(height: 40),
            const Text('Add additional details (Optional)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            _detailTile('Material Used'),
            _detailTile('Labour worked'),
            _detailTile('Remarks'),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // This returns the new progress value back to dpr_screen.dart
            Navigator.pop(context, _currentProgress);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1A56DB), // Powerplay Blue
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Save Update', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _topButton(String label, bool isSelected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          border: Border.all(color: isSelected ? Colors.blue : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(label, textAlign: TextAlign.center, 
            style: TextStyle(color: isSelected ? Colors.blue : Colors.black, fontSize: 13, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _addAttachmentBox() {
    return Container(
      height: 64,
      width: 64,
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.add, color: Colors.blue, size: 28),
    );
  }

  Widget _detailTile(String title) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(title, style: const TextStyle(fontSize: 14, color: Colors.black87)),
        trailing: const Icon(Icons.add, color: Colors.blue, size: 20),
      ),
    );
  }
}