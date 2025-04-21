import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditorScreen extends StatefulWidget {
  final PlatformFile? file;

  const EditorScreen({super.key, this.file});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  late TextEditingController _filenameController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    if (widget.file != null) {
      final content = utf8.decode(widget.file!.bytes!);
      _filenameController = TextEditingController(text: widget.file!.name);
      _contentController = TextEditingController(text: content);
    } else {
      _filenameController = TextEditingController();
      _contentController = TextEditingController();
    }
  }

  Future<void> _save(BuildContext context) async {
    final newFile = await FilePicker.platform.saveFile(
      fileName: kIsWeb
          ? _filenameController.text
          : widget.file != null
              ? widget.file!.name
              : 'nouveau_fichier.txt',
      bytes: utf8.encode(_contentController.text),
    );

    if (newFile != null && context.mounted) {
      context.pop();
    }
  }

  @override
  void dispose() {
    _filenameController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editeur'),
        backgroundColor: ColorScheme.of(context).inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => _save(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            kIsWeb
                ? TextField(
                    controller: _filenameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Nom du fichier à créer",
                    ),
                  )
                : Text(
                    widget.file != null
                        ? "File: ${widget.file!.name}"
                        : "Nouveau fichier",
                  ),
            const SizedBox(height: 8),
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Contenu du fichier",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
