import 'package:equatable/equatable.dart';

class HomeModel extends Equatable {
  // Define properties here

  @override
  List<Object> get props => [];
}

class QuestionModel extends Equatable {
  // Define properties here
  final String option;
  final String value;

  const QuestionModel({required this.option, required this.value});
  @override
  List<Object> get props => [];
}
