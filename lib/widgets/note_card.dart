import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:my_notes/change_notifier/new_note_controller.dart';
import 'package:provider/provider.dart';
import '../change_notifier/note_provider.dart';
import '../core/constants.dart';
import '../core/dialogs.dart';
import '../core/utils.dart';
import '../models/notes.dart';
import '../pages/new_or_edit_note_page.dart';
import 'note_tag.dart';


class NoteCard extends StatelessWidget {
  const NoteCard({
    required this.note,
    required this.isInGrid,
    super.key,
  });

  final Note note;
  final bool isInGrid;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (_)=>NewNoteController()..note=note,
              child: NewOrEditNotePage(
                isNewNote: false,
              ),
            ),
          ),
        );
      },
      child: Container(
          decoration: BoxDecoration(
            color: sky.withOpacity(0.955),
            border: Border.all(color: navy,width:2),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color:sky,
                offset: Offset(4,4),
              ),
            ],
          ),
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (note.title!=null)...[
                Text(
                  note.title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: black,
                  ),
                ),
                SizedBox(height:4),
              ],
              if (note.tags!=null)...[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      note.tags!.length, (index)=>NoteTag(label: note.tags![index],),
                    ),
                  ),
                ),
                SizedBox(height:4),
              ],
              if (note.content!=null)
              isInGrid
                  ? Expanded(
                      child: Text(
                        note.content!,
                        style: TextStyle(color: gray700),
                      )
                    )
                  : Text(
                      'Some Content',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color:gray700),
                    ),
              if(isInGrid) Spacer(),
              Row(
                children: [
                  Text(
                    toShortDate(note.dateModified),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight:FontWeight.w600,
                      color: gray900,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      final shouldDelete= await showConfirmationDialogue(
                          context: context,
                          title: "Do you want to delete this note?"
                      ) ?? false;
                      if (shouldDelete && context.mounted) {
                        context.read<NotesProvider>().deleteNote(note);
                      }
                    },
                    child: const FaIcon(
                        FontAwesomeIcons.trash
                    ),
                  ),
                ],
              ),
            ],
          )
      ),
    );
  }
}


