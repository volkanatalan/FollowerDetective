import 'package:flutter/foundation.dart';
import 'package:follower_detective/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserDatabase {
  static final String _DATABASE_NAME = "UserDatabase.db";        // ignore: non_constant_identifier_names
  static final String _TABLE_NAME = "Users";                     // ignore: non_constant_identifier_names
  static final String _COLUMN_ID = "id";                         // ignore: non_constant_identifier_names
  static final String _COLUMN_ACCESS_TOKEN = "accessToken";      // ignore: non_constant_identifier_names
  static final String _COLUMN_USERNAME = "username";             // ignore: non_constant_identifier_names
  static final String _COLUMN_FULL_NAME = "fullName";            // ignore: non_constant_identifier_names
  static final String _COLUMN_PHOTO_PATH = "profilePicture";     // ignore: non_constant_identifier_names


  /// A method that creates UserDatabase.
  Future<Database> _getDatabase() async {
    String path = await getDatabasesPath();
    debugPrint("database path: $path");

    return openDatabase(
      join(path, _DATABASE_NAME),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $_TABLE_NAME("
              "$_COLUMN_ID INTEGER PRIMARY KEY, "
              "$_COLUMN_ACCESS_TOKEN TEXT, "
              "$_COLUMN_USERNAME TEXT, "
              "$_COLUMN_FULL_NAME TEXT, "
              "$_COLUMN_PHOTO_PATH TEXT)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }



  /// A method that inserts users into the Users table.
  Future<void> insertUser(User user) async {
    // Get a reference to the database.
    final Database db = await _getDatabase();

    // Insert the User into the correct table. `conflictAlgorithm` should be
    // specified to use in case the same user is inserted twice.
    // In this case, replace any previous data.
    await db.insert(
      _TABLE_NAME,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }




  /// A method that retrieves all the users from the Users table.
  Future<List<User>> getUsers() async {
    // Get a reference to the database.
    final Database db = await _getDatabase();

    // Query the table for all the Users.
    final List<Map<String, dynamic>> maps = await db.query(_TABLE_NAME);

    // Convert the List<Map<String, dynamic> into a List<User>.
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'].toString(),
        accessToken: maps[i]['accessToken'],
        username: maps[i]['username'],
        fullName: maps[i]['fullName'],
        profilePicture: maps[i]['profilePicture'],
      );
    });
  }




  /// A method that retrieves all the users from the Users table.
  Future<User> getUser(String username) async {
    debugPrint("username: $username");

    // Get a reference to the database.
    final Database db = await _getDatabase();

    // Query the table for a specific user.
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM $_TABLE_NAME WHERE $_COLUMN_USERNAME = '$username';"
    );

    debugPrint("map list: ${maps[0]}");

    User user = User(
      id: maps[0]['id'].toString(),
      accessToken: maps[0]['accessToken'],
      username: maps[0]['username'],
      fullName: maps[0]['fullName'],
      profilePicture: maps[0]['profilePicture'],
    );

    return user;
  }



  /// A method that updates an existing user.
  Future<void> updateUser(User user) async {
    // Get a reference to the database.
    final Database db = await _getDatabase();

    // Update the given User.
    await db.update(
      _TABLE_NAME,
      user.toMap(),
      // Ensure that the User has a matching id.
      where: "id = ?",
      // Pass the User's id as a whereArg to prevent SQL injection.
      whereArgs: [user.id],
    );
  }



  /// A method that deletes an existing user.
  Future<void> deleteUser(String id) async {
    // Get a reference to the database.
    final Database db = await _getDatabase();

    // Remove the User from the Database.
    await db.delete(
      _TABLE_NAME,
      // Use a `where` clause to delete a specific user.
      where: "id = ?",
      // Pass the User's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}