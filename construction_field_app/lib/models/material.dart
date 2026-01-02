class MaterialItem {
  final String name;
  final String category;
  final String uom;
  int stock;

  MaterialItem({
    required this.name,
    required this.category,
    required this.uom,
    this.stock = 0,
  });
}