import 'package:flutter/material.dart';
import 'note_details.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'databse_helper/helper_data.dart';
import 'note_model.dart';

class NoteList extends StatefulWidget{
  int counter =0;

  @override
  State<StatefulWidget> createState() {

    return _NoteListState();
  }

}

class _NoteListState extends State<NoteList>{

  DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Note> noteList;

  int counter =0;
  @override
  Widget build(BuildContext context) {

    if(noteList == null){
      noteList = List<Note>();
      updateListview();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body:_NoteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder:(context){
            return note_details();
          }));
        },
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );
  }



  ListView _NoteListView(){

    TextStyle textStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: counter,
      itemBuilder: (BuildContext context, int position){
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getPriorityColory(this.noteList[position].priority),
              child: getPriorityIcon(this.noteList[position].priority),
            ),
            trailing: GestureDetector(
                child:Icon(Icons.delete, color: Colors.greenAccent),
                onTap: (){
                    _delete(context, noteList[position]);
                },
            ),
            title: Text(this.noteList[position].title, style: textStyle,),
            subtitle: Text(this.noteList[position].date),

            onTap: (){

            },
          ),
        );

      },
    );
  }

  //COLOR PRIORITY
  Color getPriorityColory(int priority){

    switch(priority){
      case 1:
        return Colors.deepPurple;
        break;

      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }//end of the code of ColorPriority

  Icon getPriorityIcon(int priority){
    switch(priority){
      case 1:
        return Icon(Icons.play_arrow);
        break;

      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }//end of code priority icon

  //delete function whenever click in deleteIcon

  void _delete(BuildContext context, Note note)async{

    int result = await _databaseHelper.deleteNote(note.id);
    if(result!=0){
      _showSnackbar(context, "Data Delete Successfully");
      updateListview();
    }
  }

  void _showSnackbar(BuildContext context, String message){
    final snackbar = SnackBar(content: Text(message),);
    Scaffold.of(context).showSnackBar(snackbar);
  }

  //UPDATE LISTVIEW

  void updateListview(){
    final Future<Database> dbFuture = _databaseHelper.initializeDatabase();
    dbFuture.then((database){
      Future<List<Note>>noteListFuture = _databaseHelper.getNoteList();
      noteListFuture.then((noteList){

        setState(() {
          this.noteList = noteList;
          this.counter = noteList.length;
        });
      });
    });
  }


}//end of _NoteListState

