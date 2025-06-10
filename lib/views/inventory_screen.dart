import 'package:computer_spares_service/models/spare_part.dart';
import 'package:computer_spares_service/services/inventory_service.dart';
import 'package:flutter/material.dart';

class InventoryScreen extends StatelessWidget {
  final InventoryService inventoryService;

  const InventoryScreen({Key? key, required this.inventoryService})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final spareParts = inventoryService.getAllSpareParts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          _buildInventoryStats(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: spareParts.length,
              itemBuilder: (context, index) {
                final part = spareParts[index];
                return _buildSparePartCard(context, part);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryStats() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Total Items', inventoryService.totalParts.toString()),
          _buildStatItem(
            'Low Stock',
            inventoryService.lowStockCount.toString(),
          ),
          _buildStatItem(
            'Out of Stock',
            inventoryService.outOfStockCount.toString(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(label),
      ],
    );
  }

  Widget _buildSparePartCard(BuildContext context, SparePart part) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    part.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (part.isOutOfStock)
                  const Chip(
                    label: Text('OUT OF STOCK'),
                    backgroundColor: Colors.red,
                    labelStyle: TextStyle(color: Colors.white),
                  )
                else if (part.isLowStock)
                  const Chip(
                    label: Text('LOW STOCK'),
                    backgroundColor: Colors.orange,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Category: ${part.category}'),
            Text('Price: ₹${part.price.toStringAsFixed(2)}'),
            Text('Stock: ${part.stockQuantity} units'),
            Text('Description: ${part.description}'),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () => _showUpdateStockDialog(context, part),
                  child: const Text('Update Stock'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showUpdateStockDialog(BuildContext context, SparePart part) {
    final controller = TextEditingController(
      text: part.stockQuantity.toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Stock - ${part.name}'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'New Stock Quantity',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newQuantity = int.tryParse(controller.text) ?? 0;
              inventoryService.updateStock(part.id, newQuantity);
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}
