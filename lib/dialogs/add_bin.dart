import 'package:flutter/material.dart';
import 'package:garbage_system/contstants/style.dart';
import 'package:garbage_system/models/bin_model.dart';

showAddBinDialog(context, {required Function(Bin) onSaved}) => showDialog(
    context: context,
    builder: (context) => Dialog(
            child: AddBinDialog(
          onSvaed: onSaved,
        )));

class AddBinDialog extends StatefulWidget {
  final Function(Bin) onSvaed;
  const AddBinDialog({Key? key, required this.onSvaed}) : super(key: key);

  @override
  State<AddBinDialog> createState() => _AddBinDialogState();
}

class _AddBinDialogState extends State<AddBinDialog> {
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Add bin',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(hintText: 'Enter bin name'),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    return null;
                  }
                  return 'Bin name required';
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(hintText: 'Enter bin id'),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    return null;
                  }
                  return 'Bin id required';
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel')),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                      onPressed: () {
                        final isValid = _formKey.currentState!.validate();
                        if (!isValid) return;
                        widget.onSvaed(Bin(
                            name: _nameController.text,
                            id: _idController.text,
                            filledPercent: 0));
                        Navigator.pop(context);
                      },
                      child: const Text('Save'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
