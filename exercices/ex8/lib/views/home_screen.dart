import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _open(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(withData: true);

    if (result != null) {
      final file = result.files.single;
      if (context.mounted) {
        context.go('/editor', extra: file);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editeur de texte'),
        backgroundColor: ColorScheme.of(context).inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _open(context),
              child: const Text('Ouvrir un fichier texte existant'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/editor'),
              child: const Text('Créer un nouveau fichier texte'),
            ),
          ],
        ),
      ),
    );
  }
}
