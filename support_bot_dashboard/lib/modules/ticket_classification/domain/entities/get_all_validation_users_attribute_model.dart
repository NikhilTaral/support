import 'package:equatable/equatable.dart';

class GetAllValidationUsersAttributeModel {
  final List<UserDetails>? data;
  final bool? success;
  final num? failCode;
  final String? message;

  GetAllValidationUsersAttributeModel({
    this.data,
    this.success,
    this.failCode,
    this.message,
  });

  GetAllValidationUsersAttributeModel copyWith({
    List<UserDetails>? data,
    bool? success,
    num? failCode,
    String? message,
  }) =>
      GetAllValidationUsersAttributeModel(
        data: data ?? this.data,
        success: success ?? this.success,
        failCode: failCode ?? this.failCode,
        message: message ?? this.message,
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
