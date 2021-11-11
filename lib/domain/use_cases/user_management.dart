import 'package:pluriza/data/repositories/json_placeholder.dart';
import 'package:pluriza/domain/models/user.dart';
import 'package:pluriza/domain/use_cases/controllers/users.dart';

class UsersManager {
  Future<User> userById(UserController controller, int userId) async {
    if (controller.users.isEmpty || controller.getUserById(userId) == null) {
      controller.newUser = await JsonPlaceholder().fetchUser(userId);
    }
    return controller.getUserById(userId)!;
  }

  void deleteAll(UserController controller) => controller.deleteAll();
}
