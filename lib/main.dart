import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/api/user_blocs.dart';
import 'package:untitled/api/user_event.dart';
import 'package:untitled/api/user_model.dart';
import 'package:untitled/api/user_repository.dart';
import 'package:untitled/api/user_states.dart';
import 'package:untitled/counter/counter_bloc.dart';
import 'package:untitled/counter/counter_event.dart';

import 'counter/counter_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (BuildContext context) => CounterBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Bloc Demo APP"),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (BuildContext context) => UserBloc(UserRepository()))
          ],
          child: Scaffold(
            appBar: AppBar(
              title: const Text('The Bloc App'),
            ),
            body: blocBody(),
          ),
        ));
  }

  Widget blocBody() {
    return BlocProvider(
      create: (context) => UserBloc(UserRepository())..add(LoadUserEvent()),
      child: BlocBuilder<UserBloc, UserStates>(
        builder: (context, state) {
          if (state is UserLoadingStates) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is UserErrorState) {
            return const Center(
              child: Text('Error'),
            );
          }

          if (state is UserLoadedStates) {
            List<UserModel> userList = state.users;
            return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Card(
                      color: Theme.of(context).primaryColor,
                      child: ListTile(
                        title: Text(
                          '${userList[index].firstName}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                });
          }
          return Container();
        },
      ),
    );
  }

  Widget _counter(BuildContext context, int counter) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            counter.toString(),
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(
            height: 50,
          ),
          MaterialButton(
              color: Colors.red,
              elevation: 0.0,
              height: 50,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: const Text(
                "-",
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              onPressed: () {
                context.read<CounterBloc>().add(NumberDecreaseEvent());
              }),
          const SizedBox(
            width: 50,
          ),
          MaterialButton(
            color: Colors.green,
            elevation: 0.0,
            height: 50,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: const Text(
              "+",
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            onPressed: () {
              context.read<CounterBloc>().add(NumberIncreaseEvent());
            },
          ),
        ],
      ),
    );
  }
}
