import 'package:flutter/material.dart';
import 'package:store_manager_app/bloc/user_bloc.dart';
import 'package:store_manager_app/widgets/user_tile.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class UsersTab extends StatelessWidget {
  const UsersTab({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _userBloc = BlocProvider.getBloc<UserBloc>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: "Search",
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
            ),
            onChanged: _userBloc.onChangedSearch,
          ),
        ),
        StreamBuilder<List>(
            stream: _userBloc.outUsers,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                );
              } else if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    "No user found.",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              } else {
                // TODO: Corrigir a criação da lista, esta crianco com base no número de usuários e não de usuários com compras
                return Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return UserTile(snapshot.data![index]);
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: snapshot.data!.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                  ),
                );
              }
            })
      ],
    );
  }
}
