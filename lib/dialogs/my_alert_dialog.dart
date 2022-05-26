import 'package:flutter/material.dart';

showAlertDialog(BuildContext context,
    {required String title,
    required String description,
    required Function() onSuccess}) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(description),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    onSuccess();
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'))
            ],
          ));
}
