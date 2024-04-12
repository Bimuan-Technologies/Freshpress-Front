
class AccountRegisteredAlreadyException implements Exception {
  final String? message;

  AccountRegisteredAlreadyException({required this.message});
}