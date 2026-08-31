import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/constants.dart';

class NoteToolbarUpper extends StatelessWidget {
  const NoteToolbarUpper({
    super.key,
    required this.quillController,
  });

  final QuillController quillController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.none,
      child: QuillToolbar.simple(
        configurations: QuillSimpleToolbarConfigurations(
          controller: quillController,
          decoration: BoxDecoration(
            // gradient: RadialGradient(
            //   colors: [Colors.red, Colors.blue], // Colors to transition between
            //   center: Alignment.center, // Center of the gradient
            //   radius: 5, // Radius of the gradient
            // ),
            color: white,
          ),
          multiRowsDisplay: false,
          showQuote: false,
          showIndent: false,
          showLink: false,
          showClipboardCopy: false,
          showClipboardCut: false,
          showClipboardPaste: false,
          showInlineCode: false,
          showSubscript: false,
          showSuperscript: false,
          showCodeBlock: false,
          showDividers: false,
          buttonOptions: QuillSimpleToolbarButtonOptions(
            base: QuillToolbarToggleStyleButtonOptions(
              iconSize: 13,
            ),
            undoHistory: QuillToolbarHistoryButtonOptions(
              iconTheme: QuillIconTheme(
                iconButtonUnselectedData:
                IconButtonData(
                    color: navy
                ),
              ),
              iconSize: 10,
            ),
            redoHistory: QuillToolbarHistoryButtonOptions(
              iconTheme: QuillIconTheme(
                iconButtonUnselectedData:
                IconButtonData(
                    color: navy
                ),
              ),
              iconSize: 10,
            ),
            fontFamily: QuillToolbarFontFamilyButtonOptions(
              iconSize: 12,
            ),
            fontSize: QuillToolbarFontSizeButtonOptions(
              iconSize: 12,
            ),
            bold: QuillToolbarToggleStyleButtonOptions(
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
            italic: QuillToolbarToggleStyleButtonOptions(
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
            underLine: QuillToolbarToggleStyleButtonOptions(
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
            strikeThrough: QuillToolbarToggleStyleButtonOptions(
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
            color: QuillToolbarColorButtonOptions(iconTheme: QuillIconTheme(
              iconButtonUnselectedData:
              IconButtonData(
                  color: navy
              ),
            ),
              iconSize: 10,
            ),
            backgroundColor: QuillToolbarColorButtonOptions(
              iconTheme: QuillIconTheme(
                iconButtonUnselectedData:
                IconButtonData(
                    color: navy
                ),
              ),
              iconSize: 10,
            ),
            clearFormat: QuillToolbarClearFormatButtonOptions(
              iconTheme: QuillIconTheme(
                iconButtonUnselectedData:
                IconButtonData(
                    color: navy
                ),
              ),
              iconSize: 10,
            ),
            selectHeaderStyleDropdownButton: QuillToolbarSelectHeaderStyleDropdownButtonOptions(
              iconSize: 12,
            ),
            listNumbers: QuillToolbarToggleStyleButtonOptions(
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
            listBullets: QuillToolbarToggleStyleButtonOptions(
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
            toggleCheckList: QuillToolbarToggleCheckListButtonOptions(
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
            search: QuillToolbarSearchButtonOptions(
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