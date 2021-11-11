import 'package:get/get.dart';
import 'package:pluriza/domain/models/user.dart';

class UserController extends GetxController {
  final _users = Rx<List<User>>([]);

  set newUser(User newUser) {
    if (users.where((user) => user.id == newUser.id).isEmpty) {
      _users.value.add(newUser);
      _users.refresh();
    }
  }

  void deleteAll() {
    _users.value = [];
  }

  List<User> get users => _users.value;

  User? getUserById(int userId) {
    try {
      return users.firstWhere((user) => user.id == userId);
    } catch (e) {
      return null;
    }
  }
}
