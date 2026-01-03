import 'package:flutter/material.dart';
import '../../models/material.dart'; // Import your model here
import 'add_material_screen.dart';
import 'indent_details_screen.dart';

class MaterialScreen extends StatefulWidget {
  const MaterialScreen({super.key});

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  bool isInventory = true;

  List<MaterialItem> inventoryList = [
    MaterialItem(name: 'vhfufu', category: 'guv', uom: 'pk', stock: 0),
    MaterialItem(name: 'sss', category: 'ss', uom: 'nos', stock: 0),
  ];

  List<Map<String, String>> indentList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildToggle(),
          const SizedBox(height: 10),
          if (isInventory) _buildInventoryTabs(),
          Expanded(
            child: isInventory ? _buildInventoryList() : _buildProcurementList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _handleFabAction(),
        backgroundColor: const Color(0xFF1A56DB),
        label: Text(isInventory ? '+ Add Material' : '+ New Indent', 
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  // Define the missing toggle method shown in your screenshot
  Widget _buildToggle() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            _toggleButton('Procurement', !isInventory),
            _toggleButton('Inventory', isInventory),
          ],
        ),
      ),
    );
  }

  Widget _toggleButton(String label, bool active) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => isInventory = label == 'Inventory'),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: active ? [const BoxShadow(color: Colors.black12, blurRadius: 4)] : [],
          ),
          child: Text(label, textAlign: TextAlign.center, 
              style: TextStyle(fontWeight: active ? FontWeight.bold : FontWeight.normal)),
        ),
      ),
    );
  }

  // Define the missing tabs method shown in your screenshot
  Widget _buildInventoryTabs() {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text('Material list', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
          SizedBox(width: 20),
          Text('Material Issue', style: TextStyle(color: Colors.grey)),
          SizedBox(width: 20),
          Text('Material Returns', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  // Rest of your list building methods...
  Widget _buildInventoryList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: inventoryList.length,
      itemBuilder: (context, index) {
        return _materialCard(inventoryList[index]);
      },
    );
  }

  Widget _buildProcurementList() {
    if (indentList.isEmpty) return _buildProcurementEmptyState();
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: indentList.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            title: Text("Indent: ${indentList[index]['id']}"),
            subtitle: Text("Delivery: ${indentList[index]['date']}"),
          ),
        );
      },
    );
  }

  Widget _buildProcurementEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, size: 80, color: Colors.blue.shade100),
          const Text("You don't have any Indents", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _materialCard(MaterialItem item) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("UOM: ${item.uom}\nIn Stock: ${item.stock}"),
          trailing: TextButton(
            onPressed: () => setState(() => item.stock++),
            child: const Text("+ Update"),
          ),
        ),
        const Divider(),
      ],
    );
  }

  void _handleFabAction() async {
    if (isInventory) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddMaterialScreen()),
      );
      if (result != null && result is MaterialItem) {
        setState(() => inventoryList.add(result));
      }
    } else {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const IndentDetailsScreen()),
      );
      if (result != null) {
        setState(() => indentList.add(result));
      }
    }
  }
}