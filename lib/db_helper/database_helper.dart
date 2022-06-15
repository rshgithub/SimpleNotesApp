
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:my_notes_app/modal_class/notes.dart';
import 'package:path/path.dart';


class DatabaseHelper {
  static DatabaseHelper ? _instance;

  static Database ? _database;
  static const _databaseName = "note_db";
  static const _databaseVersion = 1;
  static const _NoteTable = "NOTE";

  static String id_column = 'id' , title_column = 'title' , date_column = 'date' , priority_column = 'priority' , color_column = 'color' , description_column = 'description';

  DatabaseHelper(Database db) { _database = db ; }

  static Future<DatabaseHelper> getInstance() async {
    if (_instance == null) {_instance = DatabaseHelper( await open_or_create_database());}
    return  Future.value(_instance);
  }


  static Future<Database> open_or_create_database() async {
    var path = join(await getDatabasesPath(), _databaseName);
    var database = await  openDatabase(path, version: _databaseVersion , onCreate: (db, version) {
              db.execute('CREATE TABLE $_NoteTable($id_column INTEGER PRIMARY KEY AUTOINCREMENT , $title_column TEXT, ''$description_column TEXT, $priority_column INTEGER, $color_column INTEGER,$date_column TEXT)');},
        onUpgrade: (db, oldVersion, newVersion) {});

    return Future.value(database);
  }


  Future<int> addNewNote(Note note) async {
    Database? database = await _database;
    var output = await database!.insert(_NoteTable, note.toMap(),nullColumnHack: id_column);
    return output;
  }


  Future<int> updateNote(Note note)  async{
    Database? database = await _database;
    var updatedRowsCount = await database!.update(_NoteTable, note.toMap(), where: "$id_column = ? ", whereArgs: [note.id]);
    return updatedRowsCount ;
  }


  Future<int> deleteNote(Note note)  async{
    Database? database = await _database;
    var deletedRows = await database!.delete(_NoteTable, where: "$id_column = ?", whereArgs: [note.id]);
    return deletedRows ;
  }


  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database? database = await _database;
    return await database!.query(_NoteTable, orderBy: '$priority_column ASC');
  }


  Future<List<Note>> getAllNotes() async {
    var noteMapList = await getNoteMapList();
    int count = noteMapList.length;
    List<Note> noteList = [];
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));}
    return noteList;
  }


  void close(){
    _database?.close();
  }


}
