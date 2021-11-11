import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:pluriza/data/repositories/json_placeholder.dart';
import 'package:pluriza/domain/models/post.dart';
import 'package:pluriza/domain/models/user.dart';
import 'package:pluriza/domain/use_cases/controllers/users.dart';
import 'package:pluriza/domain/use_cases/user_management.dart';

class MockJson extends Mock implements JsonPlaceholder {
  @override
  Future<List<Post>> fetchPost() async {
    return List<Post>.generate(
        20, (i) => Post(id: i, userId: i, title: "Mock$i", body: "body"));
  }

  @override
  Future<User> fetchUser(int userId) async {
    return User(
        id: userId,
        name: "MockUser$userId",
        email: "mock.user$userId@pluriza.test.com",
        phone: "123456789",
        website: "mock@pluriza.com");
  }
}

class MockManager extends Mock implements UsersManager {
  @override
  Future<User> userById(UserController controller, int userId) async {
    if (controller.users.isEmpty || controller.getUserById(userId) == null) {
      controller.newUser = await MockJson().fetchUser(userId);
    }
    return controller.getUserById(userId)!;
  }

  @override
  void deleteAll(UserController controller) => controller.deleteAll();
}

void main() {
  Get.put(UserController());
  late UserController controller;
  late MockManager manager;

  setUp(() {
    controller = Get.find();
    manager = MockManager();
  });

  test('fetch-post', () async {
    await manager.userById(controller, 1);
    expect(controller.users.length, 1);
    await manager.userById(controller, 1);
    expect(controller.users.length, 1);
        await manager.userById(controller, 2);
    expect(controller.users.length, 2);
  });

  test('delete-all-users', () async {
    expect(controller.users.length, 2);
    manager.deleteAll(controller);
    expect(controller.users.length, 0);
  });
}
