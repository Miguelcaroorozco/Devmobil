import 'package:flutter/material.dart';

class ButtonsScreen extends StatelessWidget {
  const ButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Botones'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Tipos de botones',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _showMessage(context, 'ElevatedButton'),
              child: const Text('ElevatedButton'),
            ),
            FilledButton(
              onPressed: () => _showMessage(context, 'FilledButton'),
              child: const Text('FilledButton'),
            ),
            OutlinedButton(
              onPressed: () => _showMessage(context, 'OutlinedButton'),
              child: const Text('OutlinedButton'),
            ),
            TextButton(
              onPressed: () => _showMessage(context, 'TextButton'),
              child: const Text('TextButton'),
            ),
            IconButton(
              onPressed: () => _showMessage(context, 'IconButton'),
              icon: const Icon(Icons.favorite),
              tooltip: 'IconButton',
            ),
            const SizedBox(height: 8),
            FloatingActionButton.extended(
              onPressed: () => _showMessage(context, 'FloatingActionButton'),
              icon: const Icon(Icons.add),
              label: const Text('FloatingActionButton'),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'DropdownButton',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Uno', child: Text('Opción uno')),
                DropdownMenuItem(value: 'Dos', child: Text('Opción dos')),
              ],
              onChanged: (value) {
                if (value != null) {
                  _showMessage(context, 'Seleccionaste $value');
                }
              },
            ),
            const SizedBox(height: 16),
            PopupMenuButton<String>(
              onSelected: (value) => _showMessage(context, value),
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'Opción A', child: Text('Opción A')),
                PopupMenuItem(value: 'Opción B', child: Text('Opción B')),
              ],
              child: const ListTile(
                leading: Icon(Icons.more_vert),
                title: Text('PopupMenuButton'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}