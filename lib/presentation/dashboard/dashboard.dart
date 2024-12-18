import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patch_skill_test/controller/dashboard/dashboard_bloc.dart';
import 'package:patch_skill_test/presentation/dashboard/widget/cartPage.dart';
import 'package:patch_skill_test/presentation/dashboard/widget/discoverPage.dart';
import 'package:patch_skill_test/presentation/dashboard/widget/inboxPage.dart';
import 'package:patch_skill_test/presentation/dashboard/widget/profilePage.dart';
import 'package:patch_skill_test/presentation/dashboard/widget/sellPage.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final homePageBloc = context.read<HomePageBloc>();

    return Scaffold(
      bottomNavigationBar: BlocBuilder<HomePageBloc, int>(builder: (_, state) {
        print("this is state $state");
        return BottomNavigationBar(
            iconSize: 18,
            type: BottomNavigationBarType.fixed,
            onTap: (i) {
              homePageBloc.add(homePageBloc.activate(i));
              print("this is i $i");
            },
            currentIndex: state,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.search_outlined), label: "Discover"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_outlined), label: "Cart"),
              BottomNavigationBarItem(icon: Icon(Icons.add), label: "Sell"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.inbox_outlined), label: "Inbox"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_2_outlined), label: "Profile"),
            ]);
      }),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: homePageBloc.controller,
        itemBuilder: (_, i) {
          return [
            const DiscoverPage(),
            const CartPage(),
            const SellPage(),
            const Inbox(),
            const Profile()
          ][i];
        },
        itemCount: 5,
      ),
    );
  }
}
