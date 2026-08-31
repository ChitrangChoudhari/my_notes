import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/constants.dart';

class NoteFab extends StatelessWidget {
  const NoteFab({
    required this.onPressed,
    super.key,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: black,
              offset: Offset(4,4),
            ),
          ]
      ),
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: emerald,
        foregroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: sky,
          ),
        ),
        child: FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }
}