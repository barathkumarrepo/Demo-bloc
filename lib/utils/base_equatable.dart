import 'package:equatable/equatable.dart';

class BaseEquatable extends Equatable {
  @override
  List<Object?> get props => [];

  @override
  bool operator ==(Object other) => false;
}
