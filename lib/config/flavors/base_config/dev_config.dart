import 'base_config.dart';

class DevConfig implements BaseConfig {
  @override
  String get baseUrl =>
      "https://erp.thethinkingschools.com/api/api/TeacherMobileApp";

  @override
  bool get reportErrors => false;

  @override
  bool get trackEvents => false;

  @override
  bool get useHttps => false;
}
