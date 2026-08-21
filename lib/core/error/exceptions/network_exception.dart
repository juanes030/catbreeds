class NetworkException implements Exception {
  final String message;

  const NetworkException([
    this.message = 'Please check your internet connection.',
  ]);
}