

final class Failure {
  const Failure({required this.title, required this.message});

  /// Title of the failure
  final String title;
  
  final String message;

  @override
  List<Object?> get props => [title, message];
}


