import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeButton extends StatelessWidget {

  final dynamic label;
  final Function() onPressed;

   AdaptativeButton({
    this.label,
    required this.onPressed,
});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ?
        CupertinoButton(
            child: Text(label),
            onPressed: onPressed,
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.symmetric(
            horizontal: 20
          ),
        )
        : ElevatedButton(
          child: Text(
          label,
          style: TextStyle(
          color: Theme.of(context).textTheme.button?.color,
            ),
          ),
          onPressed: onPressed,
    );
  }
}
