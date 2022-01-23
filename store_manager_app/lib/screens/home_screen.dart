import 'package:flutter/material.dart';
import 'package:store_manager_app/bloc/orders_bloc.dart';
import 'package:store_manager_app/bloc/user_bloc.dart';
import 'package:store_manager_app/tabs/orders_tab.dart';
import 'package:store_manager_app/tabs/products_tab.dart';
import 'package:store_manager_app/tabs/users_tab.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:store_manager_app/widgets/edit_category_dialog.dart';

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
          blocs: [Bloc((i) => UserBloc()), Bloc((i) => OrdersBloc())],
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
              ProductsTab(),
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
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget? _buildFloatingActionButton() {
    if (_pageIndex == 2) {
      return FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context, builder: (context) => EditCategoryDialog());
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
      );
    }
    return null;
  }
}
