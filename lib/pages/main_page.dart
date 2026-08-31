import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_notes/core/dialogs.dart';
import 'package:my_notes/widgets/note_icon_button.dart';
import 'package:provider/provider.dart';
import '../change_notifier/new_note_controller.dart';
import '../change_notifier/note_provider.dart';
import '../core/constants.dart';
import '../models/notes.dart';
import '../services/auth_service.dart';
import '../widgets/no_notes.dart';
import '../widgets/note_fab.dart';
import '../widgets/note_grid.dart';
import '../widgets/note_icon_button_outlined.dart';
import '../widgets/note_list.dart';
import '../widgets/search_field.dart';
import '../widgets/view_options.dart';
import 'new_or_edit_note_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Notes 📑'),
        actions: [
          NoteIconButtonOutlined(
            icon: FontAwesomeIcons.rightFromBracket,
            onPressed: () async {
              final bool shouldLogout= await showConfirmationDialogue(
                  context: context,
                  title: 'Do you want to sign out?'
              )?? false;
              if (shouldLogout) AuthService.logout();
            },
          ),
        ],
      ),
      floatingActionButton: NoteFab(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                  create: (context) => NewNoteController(),
                  child: NewOrEditNotePage(
                    isNewNote: true,
                  ),
                ),
              )
          );
        },
      ),
      body: Consumer<NotesProvider>(
        builder: (context, notesProvider, child) {
          final List<Note> notes = notesProvider.notes;
          return notes.isEmpty && notesProvider.searchTerm.isEmpty
              ? const NoNotes()
              : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              children: [
                const SearchField(),
                if (notes.isNotEmpty)...[
                  const ViewOptions(),
                  Expanded(
                    child: notesProvider.isGrid ? NotesGrid(notes:notes) : NotesList(notes:notes),
                  ),
                ]
                else
                  Expanded(
                    child: Center(
                        child: Text(
                          "No notes found",
                          textAlign: TextAlign.center,
                        )
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
















