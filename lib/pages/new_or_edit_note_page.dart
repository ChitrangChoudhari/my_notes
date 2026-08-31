import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_notes/change_notifier/new_note_controller.dart';
import 'package:my_notes/widgets/note_icon_button_outlined.dart';
import 'package:my_notes/widgets/note_meta_data.dart';
import 'package:provider/provider.dart';
import '../core/constants.dart';
import '../core/dialogs.dart';
import '../widgets/note_back_button.dart';
import '../widgets/note_toolbar_lower.dart';
import '../widgets/note_toolbar_upper.dart';


class NewOrEditNotePage extends StatefulWidget {
  const NewOrEditNotePage({
    required this.isNewNote,
    super.key,
  });

  final bool isNewNote;

  @override
  State<NewOrEditNotePage> createState() => _NewOrEditNotePageState();
}

class _NewOrEditNotePageState extends State<NewOrEditNotePage> {
  late final NewNoteController newNoteController;
  late final TextEditingController titleController;
  late final QuillController quillController;
  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    newNoteController = context.read<NewNoteController>();
    titleController = TextEditingController(text: newNoteController.title);
    quillController = QuillController.basic()..addListener(() {
      newNoteController.content=quillController.document;
    });
    focusNode=FocusNode();



    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      if(widget.isNewNote){
        focusNode.requestFocus();
        newNoteController.readOnly=false;
      }else {
        newNoteController.readOnly = true;
        quillController.document=newNoteController.content;
      }
    });
  }

  @override
  void dispose() {
    quillController.dispose();
    focusNode.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        if (!newNoteController.canSaveNote){
          Navigator.pop(context);
          return;
        }
        final bool? shouldSave=await showConfirmationDialogue(
            context: context,
            title: "Do you want to save this note?"
        );
        if (shouldSave==null) return;
        if (!context.mounted) return;
        if (shouldSave){
          newNoteController.saveNote(context);
        }
        Navigator.pop(context);
      },
      child: Scaffold(
          appBar: AppBar(
            leading: const NoteBackButton(),
            title: Text(
                widget.isNewNote?'New Note':'Edit Note'
            ),
            actions: [
              Selector<NewNoteController,bool>(
                selector: (context,newNoteController)=>newNoteController.readOnly,
                builder: (context,readOnly,child) => NoteIconButtonOutlined(
                  icon: readOnly? FontAwesomeIcons.pen : FontAwesomeIcons.bookOpen,
                  onPressed: () {
                      newNoteController.readOnly=!readOnly;
                      if (newNoteController.readOnly){
                        FocusScope.of(context).unfocus();
                        focusNode.unfocus();
                      }else{
                        focusNode.requestFocus();
                      }
                      setState(() {
                        quillController.readOnly=newNoteController.readOnly;
                      });
                  },
                ),
              ),
              Selector<NewNoteController,bool>(
                selector: (_,newNoteController)=>newNoteController.canSaveNote,
                builder: (_,canSaveNote,__) => NoteIconButtonOutlined(
                  icon: FontAwesomeIcons.check,
                  onPressed: canSaveNote?() {
                    newNoteController.saveNote(context);
                    Navigator.pop(context);
                  }:null,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Selector<NewNoteController,bool>(
                  selector: (context,controller)=>controller.readOnly,
                  builder: (context,readOnly,child)=> TextField(
                    controller: titleController,
                    style:TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Title here',
                      hintStyle: TextStyle(
                        color: gray500,
                      ),
                      border: InputBorder.none,
                    ),
                    canRequestFocus: !readOnly,
                    onChanged: (value){
                      newNoteController.title=value;
                    },
                  ),
                ),
                NoteMetaData(note: newNoteController.note),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(
                    color: gray500,
                    thickness: 2,
                  ),
                ),
                Expanded(
                  child:Selector<NewNoteController,bool>(
                    selector: (_,controller)=>controller.readOnly,
                    builder: (_,readOnly,__)=> Column(
                      children:[
                        if(!readOnly)
                          NoteToolbarUpper(quillController: quillController),
                        Expanded(
                          child: QuillEditor.basic(
                            configurations: QuillEditorConfigurations(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              controller: quillController,
                              placeholder: 'Note Here...',
                              expands: true,
                            ),
                            focusNode: focusNode,
                          ),
                        ),
                        if(!readOnly)
                          NoteToolBarLower(quillController: quillController,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}








