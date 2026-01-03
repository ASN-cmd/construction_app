import 'package:flutter/material.dart';
import 'dpr_preview_screen.dart'; // Ensure you create this file next

class ReportCustomizationScreen extends StatefulWidget {
  final String reportType;
  const ReportCustomizationScreen({super.key, required this.reportType});

  @override
  State<ReportCustomizationScreen> createState() => _ReportCustomizationScreenState();
}

class _ReportCustomizationScreenState extends State<ReportCustomizationScreen> {
  Map<String, bool> reportParts = {
    'Task Updates': true,
    'Issues': true,
    'Inventory': true,
    'Material': true,
    'Payables': true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('My Organisation', style: TextStyle(color: Colors.grey, fontSize: 12)),
            const Text('home', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          const Icon(Icons.chat_bubble_outline, color: Colors.black),
          TextButton(onPressed: () {}, child: const Text('Help', style: TextStyle(color: Colors.blue))),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select duration', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _durationOption('Today', true),
                _durationOption('7 days', false),
                _durationOption('15 days', false),
              ],
            ),
            const SizedBox(height: 16),
            
            // Added Date Selection Row to match Powerplay UI
            Row(
              children: [
                _datePickerField('From*', '02 Jan, 2026'),
                const SizedBox(width: 12),
                _datePickerField('To*', '02 Jan, 2026'),
              ],
            ),
            
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            const Text('Parts in the Report', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            
            ...reportParts.keys.map((key) => _buildPartTile(key)).toList(),
            
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Show loading feedback
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Generating Report...'), duration: Duration(seconds: 1)),
                  );

                  // THE CONNECT CHANGE: Navigate to the Final Preview
                  Future.delayed(const Duration(milliseconds: 500), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DprPreviewScreen()),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Create Report', 
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _datePickerField(String label, String date) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(date, style: const TextStyle(fontSize: 14)),
                const Icon(Icons.calendar_month, size: 18, color: Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _durationOption(String label, bool isSelected) {
    return Row(
      children: [
        Icon(isSelected ? Icons.radio_button_checked : Icons.radio_button_off, color: Colors.blue),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }

  Widget _buildPartTile(String title) {
    return CheckboxListTile(
      value: reportParts[title],
      onChanged: (val) => setState(() => reportParts[title] = val!),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text('Includes all $title data', style: const TextStyle(fontSize: 11)),
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.blue.shade700,
      contentPadding: EdgeInsets.zero,
    );
  }
}