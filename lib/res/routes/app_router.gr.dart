// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:todo_firebase/view/home/home_view.dart' as _i1;
import 'package:todo_firebase/view/login/login_view.dart' as _i2;
import 'package:todo_firebase/view/register/register_view.dart' as _i3;
import 'package:todo_firebase/view/splash/splash_view.dart' as _i4;

/// generated route for
/// [_i1.HomeView]
class HomeView extends _i5.PageRouteInfo<void> {
  const HomeView({List<_i5.PageRouteInfo>? children})
      : super(
          HomeView.name,
          initialChildren: children,
        );

  static const String name = 'HomeView';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomeView();
    },
  );
}

/// generated route for
/// [_i2.LoginView]
class LoginView extends _i5.PageRouteInfo<void> {
  const LoginView({List<_i5.PageRouteInfo>? children})
      : super(
          LoginView.name,
          initialChildren: children,
        );

  static const String name = 'LoginView';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.LoginView();
    },
  );
}

/// generated route for
/// [_i3.RegisterView]
class RegisterView extends _i5.PageRouteInfo<void> {
  const RegisterView({List<_i5.PageRouteInfo>? children})
      : super(
          RegisterView.name,
          initialChildren: children,
        );

  static const String name = 'RegisterView';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.RegisterView();
    },
  );
}

/// generated route for
/// [_i4.SplashView]
class SplashView extends _i5.PageRouteInfo<void> {
  const SplashView({List<_i5.PageRouteInfo>? children})
      : super(
          SplashView.name,
          initialChildren: children,
        );

  static const String name = 'SplashView';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.SplashView();
    },
  );
}
