import 'package:flutter/material.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarjetas'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Tipos de Card',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Card(
            child: ListTile(
              leading: Icon(Icons.credit_card),
              title: Text('Card estándar'),
              subtitle: Text('Una tarjeta con elevación y contenido.'),
            ),
          ),
          Card.filled(
            child: const ListTile(
              leading: Icon(Icons.check_circle_outline),
              title: Text('Card.filled'),
              subtitle: Text('Una tarjeta con fondo relleno.'),
            ),
          ),
          Card.outlined(
            child: const ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Card.outlined'),
              subtitle: Text('Una tarjeta con borde visible.'),
            ),
          ),
          Card(
            elevation: 8,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Card personalizada',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Las tarjetas pueden agrupar información relacionada '
                    'y acciones para el usuario.',
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Ver más'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}