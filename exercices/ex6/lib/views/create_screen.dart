import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/article_view_model.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New article"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator:
                    (value) =>
                        (value == null || value.isEmpty)
                            ? "Please enter a name"
                            : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: "Price",
                  prefixText: "\$",
                ),
                keyboardType: TextInputType.number,
                validator:
                    (value) =>
                        (value == null ||
                                value.isEmpty ||
                                !RegExp(r'^\d+(.\d{1,2})?$').hasMatch(value))
                            ? "Please enter a price"
                            : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final name = _nameController.text;
                    final priceString = _priceController.text;
                    final price = double.parse(priceString);
                    Provider.of<ArticleViewModel>(
                      context,
                      listen: false,
                    ).createArticle(name, price);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Create article'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
