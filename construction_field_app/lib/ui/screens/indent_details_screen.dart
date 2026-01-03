import 'package:flutter/material.dart';

class IndentDetailsScreen extends StatefulWidget {
  const IndentDetailsScreen({super.key});

  @override
  State<IndentDetailsScreen> createState() => _IndentDetailsScreenState();
}

class _IndentDetailsScreenState extends State<IndentDetailsScreen> {
  final TextEditingController _indentIdController = TextEditingController(text: "MT002");
  final TextEditingController _remarksController = TextEditingController();

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
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Create Indent', style: TextStyle(color: Colors.grey, fontSize: 12)),
            Text('Add details of Indent', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel('Indent ID*'),
            _buildTextField(_indentIdController, ''),
            
            const SizedBox(height: 24),
            _buildLabel('Upload Photo of Material list (Up to 10)*'),
            _buildUploadBox(),
            
            const SizedBox(height: 24),
            _buildLabel('Delivery date'),
            _buildDatePickerField('Select expected date of delivery'),
            
            const SizedBox(height: 24),
            _buildLabel('Assigned to'),
            _buildSelectTeammateField(),
            
            const SizedBox(height: 24),
            _buildLabel('Remarks'),
            _buildLargeTextField(_remarksController, 'Enter remarks'),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Logic: Return the indent details back to MaterialScreen
            Navigator.pop(
              context,
              {
                'id': _indentIdController.text,
                'date': '05 Jan, 2026', // Mock date for demo
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1A56DB),
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Create Indent', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        fillColor: Colors.grey.shade50,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
      ),
    );
  }

  Widget _buildUploadBox() {
    return Container(
      height: 64, width: 64,
      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
      child: const Icon(Icons.add, color: Colors.blue),
    );
  }

  Widget _buildDatePickerField(String hint) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(hint, style: const TextStyle(color: Colors.grey)),
          const Icon(Icons.calendar_month_outlined, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildSelectTeammateField() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Select teammate', style: TextStyle(color: Colors.grey)),
          Icon(Icons.keyboard_arrow_down, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildLargeTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
      ),
    );
  }
}