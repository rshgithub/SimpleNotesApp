import 'package:flutter/material.dart';
import 'package:my_notes_app/modal_class/notes.dart';
import '../db_helper/database_helper.dart';

class NotesSearch extends SearchDelegate<Note> {
  final List<Note> notes;
  List<Note> filteredNotes = [];
  NotesSearch({required this.notes});
  late DatabaseHelper database;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   DatabaseHelper.getInstance().then( (value){ database = value; });
  // }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context).copyWith(
        hintColor: Colors.black,
        primaryColor: Colors.white,
        textTheme: const TextTheme(
          headline6:  TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ));
    assert(theme != null);
    return theme;
  }

  List<Note> getFilteredList(List<Note> notesList) {
    for (var note in notesList) {
      if (note.title!.toLowerCase().contains(query) || note.description!.toLowerCase().contains(query)) { filteredNotes.add(note); }
    }
    return filteredNotes;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        splashRadius: 22,
        icon: const Icon(
          Icons.clear,
          color: Colors.black,
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      splashRadius: 22,
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      onPressed: () {
        //-----------------------
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query == '') {
      return Container(
        color: Colors.white,
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            SizedBox(
              width: 50,
              height: 50,
              child: Icon(
                Icons.search,
                size: 50,
                color: Colors.black,
              ),
            ),
            Text(
              'Enter a note to search.',
              style: TextStyle(color: Colors.black),
            )
          ],
        )),
      );
    } else {
      filteredNotes = [];
      getFilteredList(notes);
      if (filteredNotes.isEmpty) {
        return Container(
          color: Colors.white,
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              SizedBox(
                width: 50,
                height: 50,
                child: Icon(
                  Icons.sentiment_dissatisfied,
                  size: 50,
                  color: Colors.black,
                ),
              ),
              Text(
                'No results found',
                style: TextStyle(color: Colors.black),
              )
            ],
          )),
        );
      } else {
        return Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: filteredNotes.length ,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(
                  Icons.note,
                  color: Colors.black,
                ),
                title: Text(
                  filteredNotes[index].title!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black),
                ),
                subtitle: Text(
                  filteredNotes[index].description!,
                  style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                ),
                onTap: () {
                  close(context, filteredNotes[index]);
                },
              );
            },
          ),
        );
      }
    }
  }





  @override
  Widget buildSuggestions(BuildContext context) {
    if (query == '') {
      return Container(
        color: Colors.white,
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            SizedBox(
              width: 50,
              height: 50,
              child: Icon(
                Icons.search,
                size: 50,
                color: Colors.black,
              ),
            ),
            Text(
              'Enter a note to search.',
              style: TextStyle(color: Colors.black),
            )
          ],
        )),
      );
    } else {
      filteredNotes = [];
      getFilteredList(notes);
      if (filteredNotes.isEmpty) {
        return Container(
          color: Colors.white,
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              SizedBox(
                width: 50,
                height: 50,
                child: Icon(
                  Icons.sentiment_dissatisfied,
                  size: 50,
                  color: Colors.black,
                ),
              ),
              Text(
                'No results found',
                style: TextStyle(color: Colors.black),
              )
            ],
          )),
        );
      } else {
        return Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: filteredNotes.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(
                  Icons.note,
                  color: Colors.black,
                ),
                title: Text(
                  filteredNotes[index].title!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black),
                ),
                subtitle: Text(
                  filteredNotes[index].description!,
                  style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                ),
                onTap: () {
                  close(context, filteredNotes[index]);
                },
              );
            },
          ),
        );
      }
    }
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   database.close();
  // }
}

