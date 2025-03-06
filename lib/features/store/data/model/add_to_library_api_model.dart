import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AddToLibraryApiModel extends Equatable {
  final String userId;
  final String bookId;

  const AddToLibraryApiModel({required this.userId, required this.bookId});

  const AddToLibraryApiModel.empty()
      : userId = '',
        bookId = '';

  factory AddToLibraryApiModel.fromJson(Map<String, dynamic> json) {
    return AddToLibraryApiModel(userId: json['userId'], bookId: json['bookIs']);
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'bookId': bookId,
    };
  }

  @override
  List<Object?> get props => [userId, bookId];
}
