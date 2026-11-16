import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Acerca de')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 48,
                child: Icon(Icons.person, size: 56),
              ),
              const SizedBox(height: 16),
              Text(
                'Miguel Caro Orozco',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              const Text(
                'Estudiante de Desarrollo de Aplicaciones Móviles',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.school_outlined),
                        title: Text('Programa'),
                        subtitle: Text('Desarrollo de aplicaciones móviles'),
                      ),
                      ListTile(
                        leading: Icon(Icons.code),
                        title: Text('Tecnología'),
                        subtitle: Text('Flutter y Dart'),
                      ),
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
}
