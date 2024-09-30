import 'package:auto_route/auto_route.dart';
import 'package:todo_firebase/res/routes/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashView.page, initial: true),
        AutoRoute(page: LoginView.page),
        AutoRoute(page: HomeView.page),
      ];
}
