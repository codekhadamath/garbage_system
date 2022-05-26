import 'dart:io';

import 'package:flutter/material.dart';
import 'package:garbage_system/services/fire_storage_service.dart';
import 'package:image_picker/image_picker.dart';

showAddBinImagesDialog(context, {required Function(List<String>) onSaved}) =>
    showDialog(
        context: context,
        builder: (context) => Dialog(
              child: AddBinImageDialog(
                onSaved: onSaved,
              ),
            ));

class AddBinImageDialog extends StatefulWidget {
  final Function(List<String>) onSaved;
  const AddBinImageDialog({Key? key, required this.onSaved}) : super(key: key);

  @override
  State<AddBinImageDialog> createState() => _AddBinImageDialogState();
}

class _AddBinImageDialogState extends State<AddBinImageDialog> {
  final List<XFile> _binImages = [];
  bool _isUploading = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Add bin images',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: [
                ..._binImages.map((imageFile) => Image.file(
                      File(imageFile.path),
                      fit: BoxFit.cover,
                    )),
                IconButton(
                    onPressed: () async {
                      final ImagePicker _picker = ImagePicker();
                      // Pick an image
                      final XFile? image =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (image == null) return;

                      setState(() {
                        _binImages.add(image);
                      });
                    },
                    icon: const Icon(Icons.add))
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            if (_isUploading) const CircularProgressIndicator(),
            if (_isUploading)
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
                    onPressed: () async {
                      if (_binImages.isEmpty) return;
                      setState((() => _isUploading = true));
                      final List<String> binImages = [];
                      for (var image in _binImages) {
                        final binImage = await FireStorageService.uploadImage(
                            image, (progress) {});
                        binImages.add(binImage);
                      }
                      setState((() => _isUploading = false));
                      widget.onSaved(binImages);
                      Navigator.pop(context);
                    },
                    child: const Text('Save'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
