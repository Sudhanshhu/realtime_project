class AddEmployeeState {
  final bool isLoading;
  final String? error;

  const AddEmployeeState({
    this.isLoading = false,
    this.error,
  });

  AddEmployeeState copyWith({
    bool? isLoading,
    String? error,
  }) {
    return AddEmployeeState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
