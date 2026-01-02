import 'package:flutter/material.dart';
import '../../services/attendance_service.dart';

class AddWorkerSheet extends StatefulWidget {
  final AttendanceService service;

  const AddWorkerSheet({
    super.key,
    required this.service,
  });

  @override
  State<AddWorkerSheet> createState() => _AddWorkerSheetState();
}

class _AddWorkerSheetState extends State<AddWorkerSheet> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _wageController = TextEditingController();

  String _designation = 'Mason';

  final List<String> _designations = [
    'Mason',
    'Helper',
    'Carpenter',
    'Electrician',
    'Plumber',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        top: 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add Worker',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Worker Name',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Enter name' : null,
            ),

            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: _designation,
              items: _designations
                  .map(
                    (d) => DropdownMenuItem(
                      value: d,
                      child: Text(d),
                    ),
                  )
                  .toList(),
              onChanged: (v) => setState(() => _designation = v!),
              decoration: const InputDecoration(
                labelText: 'Designation',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextFormField(
              controller: _wageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Daily Wage (₹)',
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Enter wage';
                if (double.tryParse(v) == null) return 'Invalid number';
                return null;
              },
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveWorker,
                child: const Text('Save Worker'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveWorker() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await widget.service.addWorker(
        name: _nameController.text.trim(),
        designation: _designation,
        dailyWage: double.parse(_wageController.text),
      );

      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving worker: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

}
