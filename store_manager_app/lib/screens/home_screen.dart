import 'package:flutter/material.dart';
import 'package:store_manager_app/bloc/user_bloc.dart';
import 'package:store_manager_app/tabs/orders_tab.dart';
import 'package:store_manager_app/tabs/users_tab.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageIndex = 0;
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: BlocProvider(
          blocs: [Bloc((i) =>UserBloc())],
          dependencies: [],
          child: PageView(
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                _pageIndex = page;
              });
            },
            children: [
              UsersTab(),
              OrdersTab(),
              Container(color: Colors.red),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        onTap: (item) {
          _pageController.animateToPage(
            item,
            duration: Duration(microseconds: 500),
            curve: Curves.ease,
          );
        },
        currentIndex: _pageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Clients",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Products",
          ),
        ],
      ),
    );
  }
}
