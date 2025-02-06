import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension GoSubRoute on BuildContext{
  void goSubRoute(String location, {Object? extra}){
    go(_newRoute(location), extra: extra);
  }
  void pushSubRoute(String location, {Object? extra}){
    push(_newRoute(location), extra: extra);
  }

  String _newRoute(String location) {
    GoRouterState state = GoRouter.of(this).state;
    String topRoute = state.fullPath?.split('/').elementAtOrNull(1) ?? '';
    topRoute = '/$topRoute';
    String delimiter = topRoute.endsWith('/') || location.startsWith('/')? '':'/';
    print(topRoute + delimiter + location);
    return topRoute + delimiter + location;
  }
}