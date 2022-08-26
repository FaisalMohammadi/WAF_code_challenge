import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

/// instance of get-it that is used for dependency-injection
final locator = GetIt.instance;

/// initialize get-it
@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
Future initDependencies() async {
  // call generated code that adds the dependencies to the get-it-instance
  $initGetIt(locator);

  // wait for it to finish
  await locator.allReady();
}

/// disposes all services and re-adds them to get-it
Future reInitDependencies() async {
  // remove and dispose all services that were registered in get-it
  await locator.reset(dispose: true);

  // re-initialize get-it
  await initDependencies();
}