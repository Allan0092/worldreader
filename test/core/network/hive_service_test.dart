import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:worldreader/app/di/di.dart';
import 'package:worldreader/core/network/hive_service.dart';
import 'package:worldreader/features/auth/data/model/auth_hive_model.dart';

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  await initDependencies();
  var directory = await getApplicationDocumentsDirectory();
  var path = '${directory.path}softwarica_student_management.db';

  Hive.init(path);

  // Register Adapters
  Hive.registerAdapter(AuthHiveModelAdapter());
}

void main() {
  setUpAll(() async {
    await init();
  });

  final HiveService hiveService = HiveService();
  final AuthHiveModel user = AuthHiveModel(
    fName: 'user1',
    lName: "last1",
    email: "user1@email.com",
    password: "password1",
  );
  String id = "";

  group("Hive Database", () {
    test("Register User", () async {
      await hiveService.register(user);
    });

    test("login user", () async {
      AuthHiveModel loginUser =
          await hiveService.login("user1@email.com", "password1") ??
              AuthHiveModel.initial();

      expect(loginUser, user);
      id = user.userId ?? "";
    });

    test("Delete User", () async {
      await hiveService.deleteAuth(id);
    });
  });
}
