import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'attendance_screen.dart'; 
import 'records_screen.dart';    
import 'report_customization_screen.dart'; // Ensure this file exists

class ProjectHomeScreen extends StatefulWidget {
  final String projectName;
  const ProjectHomeScreen({super.key, required this.projectName});

  @override
  State<ProjectHomeScreen> createState() => _ProjectHomeScreenState();
}

class _ProjectHomeScreenState extends State<ProjectHomeScreen> {
  int _selectedIndex = 0;
  String selectedReportType = 'Summary Report'; // Default selection

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      DashboardScreen(projectName: widget.projectName),
      const Center(child: Text('Task Management Screen')),
      const Center(child: Text('Material/Inventory Screen')),
      const AttendanceScreen(), 
      const RecordsScreen(),     
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.close, color: Colors.black),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('My Organisation', style: TextStyle(color: Colors.grey, fontSize: 12)),
            Row(
              children: [
                Text(widget.projectName, style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                const Icon(Icons.unfold_more, color: Colors.black, size: 16),
              ],
            ),
          ],
        ),
        actions: [
          const Icon(Icons.chat_bubble_outline, color: Colors.black),
          const SizedBox(width: 10),
          TextButton(onPressed: () {}, child: const Text('Help', style: TextStyle(color: Colors.blue))),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue.shade800,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.description), label: 'Report'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Task'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2), label: 'Material'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Attendance'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Records'),
        ],
      ),
      floatingActionButton: _selectedIndex == 0 
        ? FloatingActionButton.extended(
            onPressed: () => _showReportTypeSelector(context),
            backgroundColor: Colors.blue.shade800,
            label: const Text('Create Report', style: TextStyle(color: Colors.white)),
          )
        : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showReportTypeSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        // StatefulBuilder allows the bottom sheet UI to update when a type is selected
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setSheetState) {
            return Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Select report type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 20),
                  _reportTypeOption(
                    'Detailed Report', 
                    'Shows day-wise logs—useful for detailed tracking.',
                    isSelected: selectedReportType == 'Detailed Report',
                    onTap: () => setSheetState(() => selectedReportType = 'Detailed Report'),
                  ),
                  const SizedBox(height: 12),
                  _reportTypeOption(
                    'Summary Report', 
                    'Shows key summaries—great for quick updates.', 
                    isNew: true,
                    isSelected: selectedReportType == 'Summary Report',
                    onTap: () => setSheetState(() => selectedReportType = 'Summary Report'),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close sheet
                        // Navigate to the customization screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReportCustomizationScreen(
                              reportType: selectedReportType,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade800,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Next', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _reportTypeOption(String title, String desc, {bool isNew = false, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50.withOpacity(0.5) : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.blue.shade800 : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                if (isNew) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(4)),
                    child: const Text('NEW', style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
                  )
                ],
                const Spacer(),
                if (isSelected) Icon(Icons.check_circle, color: Colors.blue.shade800, size: 20),
              ],
            ),
            const SizedBox(height: 4),
            Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}