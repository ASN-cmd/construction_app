import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final String projectName;

  const DashboardScreen({
    super.key,
    required this.projectName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Powerplay light grey background
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Header Section
            _buildProjectHeader(context),
            const SizedBox(height: 20),

            // Tasks Summary Title
            const Text(
              'Tasks Summary',
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 16, 
                color: Colors.black87
              ),
            ),
            const SizedBox(height: 12),

            // Horizontal Status Cards (Completed, In Progress, Not Started)
            Row(
              children: [
                _statusCard('COMPLETED', '0', '0', Colors.green),
                _statusCard('IN PROGRESS', '0', '0', Colors.orange),
                _statusCard('NOT STARTED', '0', '0', Colors.blueGrey),
              ],
            ),
            const SizedBox(height: 24),

            // Activity Row
            const Text(
              'Activity',
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 16, 
                color: Colors.black87
              ),
            ),
            const SizedBox(height: 12),
            _activityRow(),
            
            const SizedBox(height: 24),

            // Attendance Summary Table
            _attendanceSummaryTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50, 
              borderRadius: BorderRadius.circular(8)
            ),
            child: const Icon(Icons.business, color: Colors.blue),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                projectName, 
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
              ),
              const Text(
                'No dates added', 
                style: TextStyle(color: Colors.grey, fontSize: 12)
              ),
            ],
          )
        ],
      ),
    );
  }

  // FIXED: Uses Row + Container for side accent to avoid BorderRadius/Border conflict
  Widget _statusCard(String title, String total, String delayed, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias, 
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 4,
                color: color,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 10,
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _statColumn('Total', total),
                          _statColumn('Delayed', delayed, isRed: true),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statColumn(String label, String value, {bool isRed = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 9, color: Colors.grey)),
        Text(
          value, 
          style: TextStyle(
            fontSize: 14, 
            fontWeight: FontWeight.bold, 
            color: isRed ? Colors.red : Colors.black
          )
        ),
      ],
    );
  }

  Widget _activityRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _activityIcon(Icons.assignment_outlined, 'Task Updates', '0'),
        _activityIcon(Icons.warning_amber_rounded, 'Issues Created', '0'),
        _activityIcon(Icons.person_outline, 'Attendance Logged', '1'),
      ],
    );
  }

  Widget _activityIcon(IconData icon, String label, String count) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              label, 
              style: const TextStyle(fontSize: 10, color: Colors.grey), 
              overflow: TextOverflow.ellipsis
            )
          ),
          Text(
            count, 
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)
          ),
        ],
      ),
    );
  }

  Widget _attendanceSummaryTable() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Attendance summary', 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
          ),
          const SizedBox(height: 4),
          const Text(
            'Total Labours on-site', 
            style: TextStyle(fontSize: 12, color: Colors.grey)
          ),
          const Text(
            '1', 
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
          ),
          const Divider(height: 24),
          // Table Header
          Row(
            children: const [
              Expanded(
                flex: 2, 
                child: Text('Labour / Vendor', style: TextStyle(fontSize: 11, color: Colors.grey))
              ),
              Expanded(
                child: Text('Total Present', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Colors.grey))
              ),
              Expanded(
                child: Text('Total Absents', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Colors.grey))
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Row Data
          Row(
            children: [
              const Expanded(
                flex: 2, 
                child: Text('My Labour (1)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
              ),
              Expanded(child: _badge('1 P', Colors.green.shade50, Colors.green)),
              Expanded(child: _badge('0 A', Colors.red.shade50, Colors.red)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Expanded(
                flex: 2, 
                child: Text('Vendor Labour (0)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
              ),
              Expanded(child: _badge('0 P', Colors.green.shade50, Colors.green)),
              Expanded(child: _badge('-', Colors.transparent, Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _badge(String text, Color bg, Color textCol) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: bg, 
        borderRadius: BorderRadius.circular(4)
      ),
      child: Text(
        text, 
        textAlign: TextAlign.center, 
        style: TextStyle(color: textCol, fontWeight: FontWeight.bold, fontSize: 12)
      ),
    );
  }
}