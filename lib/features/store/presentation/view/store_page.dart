import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldreader/features/store/domain/entity/book_entity.dart';
import 'package:worldreader/features/store/presentation/view_model/store_bloc.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<StoreBloc>().add(LoadBooks());
    return Scaffold(
      body: BlocConsumer<StoreBloc, StoreState>(
        listener: (context, state) {
          if (state.successMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.successMessage!)),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.error != null) {
            return Center(child: Text(state.error!));
          } else if (state.books.isEmpty) {
            return const Center(
              child: Text('No books available in the store. Check back later!'),
            );
          } else {
            return _buildBookGrid(state.books, context);
          }
        },
      ),
    );
  }

  Widget _buildBookGrid(List<BookEntity> books, BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.7,
      ),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return Card(
          elevation: 4,
          color: Colors.grey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: book.coverURL.isNotEmpty
                    ? Image.network(
                        "http://10.0.2.2:5000/${book.coverURL}",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.book, size: 100);
                        },
                      )
                    : const Icon(Icons.book, size: 100),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      book.title,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'By ${book.author}',
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (book.verifiedStatus)
                      const Icon(Icons.verified, color: Colors.blue, size: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<StoreBloc>().add(AddToLibrary(
                            bookId: book.bookId, context: context));
                      },
                      child: const Text('Add to Library'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
