import '../repositories/auth_repository.dart';

class AuthService {
  final AuthRepository repo;
  AuthService(this.repo);

  Future<bool> verifyOtp(String otp) async {
    return otp == '123456';
  }

  Future<void> saveLogin(String phone) async {
    await repo.saveLogin(phone);
  }

  Future<bool> isLoggedIn() async {
    return repo.isLoggedIn();
  }

  Future<void> saveRole(String role) async {
    await repo.saveRole(role);
  }

  Future<String?> getRole() async {
    return repo.getRole();
  }

  Future<void> logout() async {
    await repo.logout();
  }

  Future<String?> getPhone() async => repo.getPhone();
}

