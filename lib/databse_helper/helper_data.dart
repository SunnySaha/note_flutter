import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:note_life/note_model.dart';
import 'package:path_provider/path_provider.dart';


class DatabaseHelper{

  static DatabaseHelper _databaseHelper;
  static Database _database;

  String table = 'note_table';
  String id = 'id';
  String title = 'title';
  String description = 'description';
  String date = 'date';
  String priority = 'priority';

  DatabaseHelper._createInstance();

  factory DatabaseHelper(){

    if(_databaseHelper == null){

       _databaseHelper= DatabaseHelper._createInstance();
    }

    return _databaseHelper;
  }

  //get the database
  Future<Database> get database async{
    if(_database == null){
        _database = await initializeDatabase();
    }
    return _database;
  }

  //INITIALIZED DATABASE
   Future<Database> initializeDatabase() async{

      Directory directory =  await getApplicationDocumentsDirectory();
      String path = directory.path + 'notes.db';
      var noteDatabse = openDatabase(path, version: 1, onCreate: _createTable);
      return noteDatabse;
    }


  //CREATE TABLE
  void _createTable(Database db, int newVersion)async{
    
    await db.execute('CREATE TABLE $table($id INTEGER PRIMARY KEY AUTOINCREMENT, $title TEXT, $description TEXT, $priority INTEGER, $date TEXT)');
  }

  //FETCH THE DATA

  Future<List<Map<String, dynamic>>> getNoteMapList()async{

    Database db = await this.database; //the database which is get before

    var result = await db.query(table, orderBy: '$priority ASC');
    return result;
  }

  //INSERT DATA

  Future<int> insertNote(Note note)async{
    Database db = await this.database;

    var result = db.insert(table, note.toMap());
    return result;
  }

  // UPDATE DATA

  Future<int> updateNote(Note note)async{
   var db = await this.database;
    var result = db.update(table, note.toMap(), where: '$id=?', whereArgs: [note.id]);
  }

  //DELETE DATA
  Future<int> deleteNote(int id)async{
    var db = await this.database;
    var result = db.delete('DELETE FROM $table WHERE $id = $id');
    return result;
  }

  //  GET NUMBER OF NOTES IN OUR TABLE

  Future<int> getCount()async{

    Database db = await this.database;
    List<Map<String, dynamic>> item = await db.rawQuery('SELECT COUNT (*) FROM $table');
    var result = Sqflite.firstIntValue(item);
    return result;
  }

  //GET NOTEMAP LIST AND CONVERT INTO LIST NOTE

  Future<List<Note>> getNoteList()async{

    var noteMapList = await getNoteMapList();
    int count = noteMapList.length;

    List<Note> noteList = List<Note>();

    for(int i=0; i<count; i++){
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }
}