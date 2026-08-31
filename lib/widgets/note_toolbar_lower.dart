import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/constants.dart';

class NoteToolBarLower extends StatelessWidget {
  const NoteToolBarLower({
    super.key,
    required this.quillController,
  });
  final QuillController quillController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      clipBehavior: Clip.none,
      child: QuillToolbar.simple(
        configurations: QuillSimpleToolbarConfigurations(
          controller: quillController,
          decoration: BoxDecoration(
            color: emerald.withOpacity(0.5),
          ),
          multiRowsDisplay: false,
          showFontFamily: false,
          showFontSize: false,
          showStrikeThrough: false,
          showInlineCode: false,
          showAlignmentButtons: false,
          showDirection: false,
          showDividers: false,
          showHeaderStyle: false,
          showListCheck: false,
          showCodeBlock: false,
          showRedo: false,
          showUndo: false,
          showBoldButton: false,
          showItalicButton: false,
          showUnderLineButton: false,
          showColorButton: false,
          showBackgroundColorButton: false,
          showClearFormat: false,
          showListNumbers: false,
          showListBullets: false,
          showSearchButton: false,
          showQuote: false,
          showLink: false,
          buttonOptions: QuillSimpleToolbarButtonOptions(
            base: QuillToolbarToggleStyleButtonOptions(
              iconSize: 10,
            ),
            subscript: QuillToolbarToggleStyleButtonOptions(
              iconTheme: QuillIconTheme(
                iconButtonUnselectedData:
                IconButtonData(
                    color: navy
                ),
                iconButtonSelectedData:
                IconButtonData(
                  color: white,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      navy,
                    ),
                  ) ,
                ),
              ),
              iconSize: 10,
            ),
            superscript: QuillToolbarToggleStyleButtonOptions(
              iconTheme: QuillIconTheme(
                iconButtonUnselectedData:
                IconButtonData(
                    color: navy
                ),
                iconButtonSelectedData:
                IconButtonData(
                  color: white,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      navy,
                    ),
                  ) ,
                ),
              ),
              iconSize: 10,
            ),
            indentIncrease: QuillToolbarIndentButtonOptions(
              afterButtonPressed: ColorScheme.dark,
              iconTheme: QuillIconTheme(
                iconButtonUnselectedData:
                IconButtonData(
                    color: navy
                ),

              ),
              iconSize: 10,
            ),
            indentDecrease: QuillToolbarIndentButtonOptions(
              iconTheme: QuillIconTheme(
                iconButtonUnselectedData:
                IconButtonData(
                    color: navy
                ),
              ),
              iconSize: 10,
            ),
            clipboardCut: QuillToolbarToggleStyleButtonOptions(
              iconTheme: QuillIconTheme(
                iconButtonUnselectedData:
                IconButtonData(
                    color: navy
                ),
              ),
              iconSize: 10,
            ),
            clipboardCopy: QuillToolbarToggleStyleButtonOptions(
              iconTheme: QuillIconTheme(
                iconButtonUnselectedData:
                IconButtonData(
                    color: navy
                ),
              ),
              iconSize: 10,
            ),
            clipboardPaste: QuillToolbarToggleStyleButtonOptions(
              iconTheme: QuillIconTheme(
                iconButtonUnselectedData:
                IconButtonData(
                    color: navy
                ),
              ),
              iconSize: 10,
            ),
          ),
        ),
      ),
    );
  }
}