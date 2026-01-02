import 'package:flutter/material.dart';
// Ensure this path matches where you defined the MaterialItem class
import 'material_screen.dart'; 
import '../../models/material.dart';

class AddMaterialScreen extends StatefulWidget {
  const AddMaterialScreen({super.key});

  @override
  State<AddMaterialScreen> createState() => _AddMaterialScreenState();
}

class _AddMaterialScreenState extends State<AddMaterialScreen> {
  final _itemCodeController = TextEditingController();
  final _specController = TextEditingController();
  String? selectedUOM;
  String? selectedCategory;

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
        title: const Text('Add New Material', style: TextStyle(color: Colors.black, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel('Specifications (Optional)'),
            _buildTextField(_specController, 'Mention brand, color, size etc'),
            
            const SizedBox(height: 20),
            _buildLabel('UOM*'),
            _buildDropdown('Select Unit', ['nos', 'pk', 'kg', 'm'], (val) => setState(() => selectedUOM = val)),
            
            const SizedBox(height: 20),
            _buildLabel('Category'),
            _buildDropdown('Select category', ['Civil', 'Electrical', 'Plumbing'], (val) => setState(() => selectedCategory = val)),
            
            const SizedBox(height: 20),
            _buildLabel('Item code'),
            _buildTextField(_itemCodeController, 'Enter'),
            
            const SizedBox(height: 24),
            _expandableTile('Stock Details'),
            _expandableTile('Financial Details'),
            _expandableTile('Additional Details'),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomButtons(),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
    );
  }

  Widget _buildDropdown(String hint, List<String> items, Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(hint, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _expandableTile(String title) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.add, color: Colors.blue),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(0, 50),
                side: const BorderSide(color: Colors.blue),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Save & Create New', style: TextStyle(color: Colors.blue, fontSize: 13)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (_itemCodeController.text.isNotEmpty) {
                  // Logic: Return the new item to the MaterialScreen
                  Navigator.pop(
                    context,
                    MaterialItem(
                      name: _itemCodeController.text,
                      category: selectedCategory ?? 'General',
                      uom: selectedUOM ?? 'nos',
                      stock: 0,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                minimumSize: const Size(0, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Save', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}