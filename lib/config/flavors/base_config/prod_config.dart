import 'base_config.dart';

class ProdConfig implements BaseConfig {
  @override
  String get baseUrl => "https://kges.cyberasol.com/api/api/TeacherMobileApp";

  @override
  bool get reportErrors => false;

  @override
  bool get trackEvents => false;

  @override
  bool get useHttps => false;
}
