import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final String projectName;

  const DashboardScreen({
    super.key,
    required this.projectName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Project Overview',
            style: Theme.of(context).textTheme.headlineSmall,
          ),

          const SizedBox(height: 12),

          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_city,
                    size: 32,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      projectName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          Text(
            'Quick Actions',
            style: Theme.of(context).textTheme.titleMedium,
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              _quickAction(
                context,
                Icons.how_to_reg,
                'Attendance',
              ),
              _quickAction(
                context,
                Icons.list_alt,
                'Records',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quickAction(
    BuildContext context,
    IconData icon,
    String label,
  ) {
    return Expanded(
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Icon(icon, size: 28, color: Colors.blue),
              const SizedBox(height: 8),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}
