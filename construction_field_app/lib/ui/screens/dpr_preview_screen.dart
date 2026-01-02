import 'package:flutter/material.dart';

class DprPreviewScreen extends StatelessWidget {
  const DprPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Preview'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.download)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Blue Header Section (Mimicking your screenshot)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: const Color(0xFF003399),
              child: Column(
                children: [
                  const Text('My Organisation', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: const Text('Daily Report - 02 Jan, 2026', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 12),
                  const Text('Created by Site Manager', style: TextStyle(color: Colors.white, fontSize: 10)),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionHeader('Tasks Summary'),
                  _mockTaskSummary(),
                  const SizedBox(height: 20),
                  _sectionHeader('Attendance Summary'),
                  _mockAttendanceTable(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActions(),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }

  Widget _mockTaskSummary() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _summaryBox('COMPLETED', '0', Colors.green),
        _summaryBox('IN PROGRESS', '0', Colors.orange),
        _summaryBox('NOT STARTED', '0', Colors.blueGrey),
      ],
    );
  }

  Widget _summaryBox(String label, String count, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
          Text(count, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _mockAttendanceTable() {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      children: const [
        TableRow(children: [
          Padding(padding: EdgeInsets.all(8), child: Text('Labour', style: TextStyle(fontWeight: FontWeight.bold))),
          Padding(padding: EdgeInsets.all(8), child: Text('Present', textAlign: TextAlign.center)),
          Padding(padding: EdgeInsets.all(8), child: Text('Absent', textAlign: TextAlign.center)),
        ]),
        TableRow(children: [
          Padding(padding: EdgeInsets.all(8), child: Text('My Labour')),
          Padding(padding: EdgeInsets.all(8), child: Text('1', textAlign: TextAlign.center, style: TextStyle(color: Colors.green))),
          Padding(padding: EdgeInsets.all(8), child: Text('0', textAlign: TextAlign.center)),
        ]),
      ],
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: const Color(0xFF003399),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _bottomIconButton(Icons.edit, 'Edit'),
          _bottomIconButton(Icons.download, 'Download'),
          _bottomIconButton(Icons.share, 'Share'),
        ],
      ),
    );
  }

  Widget _bottomIconButton(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}