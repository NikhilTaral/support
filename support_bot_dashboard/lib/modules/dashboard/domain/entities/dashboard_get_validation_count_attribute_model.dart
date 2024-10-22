import 'package:equatable/equatable.dart';

class ValidationCountAttributeModel extends Equatable {
  final num? correct;
  final num? incorrect;
  final num? notValidated;

  const ValidationCountAttributeModel(
      {required this.correct,
      required this.incorrect,
      required this.notValidated
      });

  @override
  List<Object?> get props =>
      [correct, incorrect, notValidated];
}
