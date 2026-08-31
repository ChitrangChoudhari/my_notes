import 'package:flutter/material.dart';
import '../core/constants.dart';

class NoteButton extends StatelessWidget {
  const NoteButton({
    super.key,
    required this.child,
    this.onPressed,
  });

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(2,2),
              color: navy,
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child:ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: navy,
            foregroundColor: whiteblue,
            disabledBackgroundColor: gray300,
            disabledForegroundColor: black,
            side: BorderSide(
              color: black,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: child,
        )
    );
  }
}