import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patch_skill_test/controller/dashboard/dashboard_event.dart';

class HomePageBloc extends Bloc<HomePageEvent, int> {
  final PageController controller;
  static const Duration _duration = Duration(milliseconds: 300);
  static const Curve _curve = Curves.linear;
  HomePageBloc()
      : controller = PageController(),
        super(0) {
    on<gotoDiscover>(
      (event, emit) {
        emit(0);
        controller.animateToPage(0, duration: _duration, curve: _curve);
      },
    );
    on<gotoCart>(
      (event, emit) {
        emit(1);
        controller.animateToPage(1, duration: _duration, curve: _curve);
      },
    );
    on<gotoSell>(
      (event, emit) {
        emit(2);
        controller.animateToPage(2, duration: _duration, curve: _curve);
      },
    );
    on<gotoInbox>(
      (event, emit) {
        emit(3);
        controller.animateToPage(3, duration: _duration, curve: _curve);
      },
    );
    on<gotoProfile>(
      (event, emit) {
        emit(4);
        controller.animateToPage(4, duration: _duration, curve: _curve);
      },
    );
  }
  HomePageEvent activate(int value) {
    print(value);
    switch (value) {
      case 0:
        return const gotoDiscover();

      case 1:
        return const gotoCart();
      case 2:
        return const gotoSell();
      case 3:
        return const gotoInbox();
      default:
        return const gotoProfile();
    }
  }

  @override
  Future<void> close() {
    controller.dispose();
    // TODO: implement close
    return super.close();
  }
}
