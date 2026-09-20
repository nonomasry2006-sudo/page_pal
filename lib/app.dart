import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/cubit/auth_cubit.dart';
import 'features/auth/data/auth_local_data_source.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/library/cubit/library_cubit.dart';
import 'features/library/data/library_local_data_source.dart';
import 'features/library/data/library_repository.dart';
import 'features/sessions/cubit/notes_cubit.dart';
import 'features/sessions/data/note_local_data_source.dart';
import 'features/sessions/data/note_repository.dart';

class BookReadingTrackerApp extends StatelessWidget {
  const BookReadingTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Auth — available everywhere
        BlocProvider(
          create: (context) => AuthCubit(
            AuthRepositoryImpl(AuthLocalDataSource()),
          ),
        ),
        // Library
        BlocProvider(
          create: (context) {
            final cubit = LibraryCubit(
              LibraryRepository(LibraryLocalDataSource()),
            );
            cubit.loadLibrary();
            return cubit;
          },
        ),
        // Notes
        BlocProvider(
          create: (context) => NotesCubit(
            NoteRepositoryImpl(NoteLocalDataSource()),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'PagePal',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        themeMode: ThemeMode.dark,
        routerConfig: AppRouter.router,
      ),
    );
  }
}