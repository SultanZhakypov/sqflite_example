import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'init_injectable.config.dart';

final sl = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
void configureInjection(String environment) =>
    $initGetIt(sl, environment: environment);

abstract class Env {
  static const dev = 'dev';
  static const prod = 'prod';
}
