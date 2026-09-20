import 'package:hive_flutter/hive_flutter.dart';

import '../../features/auth/models/user_account.dart';
import '../../features/explore/models/book_model.dart';
import '../../features/library/models/shelf_book_model.dart';
import '../../features/sessions/models/note_model.dart';

class HiveService {
  HiveService._();

  static const String shelvesBox = 'shelves';
  static const String notesBox = 'notes';
  static const String usersBox = 'users';
  static const String sessionBox = 'session';

  static Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ShelfBookModelAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ShelfStatusAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(BookModelAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(NoteModelAdapter());
    }
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(UserAccountAdapter());
    }

    // Open boxes
    await Hive.openBox<ShelfBookModel>(shelvesBox);
    await Hive.openBox<NoteModel>(notesBox);
    await Hive.openBox<UserAccount>(usersBox);
    await Hive.openBox<String>(sessionBox);
  }

  static Box<ShelfBookModel> get shelves =>
      Hive.box<ShelfBookModel>(shelvesBox);

  static Box<NoteModel> get notes =>
      Hive.box<NoteModel>(notesBox);

  static Box<UserAccount> get users =>
      Hive.box<UserAccount>(usersBox);

  static Box<String> get session =>
      Hive.box<String>(sessionBox);
}