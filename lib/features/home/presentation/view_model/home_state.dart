import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldreader/app/di/di.dart';
import 'package:worldreader/features/library/presentation/view/library_page.dart';
import 'package:worldreader/features/map/presentation/view/explore_page.dart';
import 'package:worldreader/features/store/presentation/view/store_page.dart';
import 'package:worldreader/features/store/presentation/view_model/store_bloc.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const HomeState({
    required this.selectedIndex,
    required this.views,
  });

  static HomeState initial() {
    return HomeState(
      selectedIndex: 2,
      views: [
        const ExplorePage(),
        const LibraryPage(),
        BlocProvider(
          create: (context) => getIt<StoreBloc>(),
          child: const StorePage(),
        ),
      ],
    );
  }

  HomeState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
