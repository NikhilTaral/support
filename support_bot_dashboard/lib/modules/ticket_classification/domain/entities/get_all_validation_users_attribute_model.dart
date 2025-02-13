import 'package:equatable/equatable.dart';

class GetAllValidationUsersAttributeModel {
  final List<UserDetails>? data;

  GetAllValidationUsersAttributeModel({
    this.data,
  });

  GetAllValidationUsersAttributeModel copyWith({
    List<UserDetails>? data,
  }) =>
      GetAllValidationUsersAttributeModel(
        data: data ?? this.data,
      );
}

class UserDetails extends Equatable {
  final String? name;
  final String? email;

  const UserDetails({
    this.name,
    this.email,
  });

  @override
  List<Object?> get props => [name, email];
}
