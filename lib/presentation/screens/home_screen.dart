// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/deal_repository.dart';
import '../../logic/deal/deal_bloc.dart';
import 'deal_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Deals"),
          bottom: TabBar(
            // 1. TEXT COLORS
            labelColor:
                Colors.white, // Color of text when SELECTED (Bright White)
            unselectedLabelColor:
                Colors
                    .white70, // Color of text when UNSELECTED (Slightly dim white)
            // 2. THE "SHADED WHITE" BACKGROUND EFFECT
            // Makes the shade fill the whole tab

            // 3. REMOVE DEFAULT RIPPLE (Optional, for a cleaner look)
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            tabs: const [
              Tab(text: "TOP"),
              Tab(text: "POPULAR"),
              Tab(text: "FEATURED"),
            ],
          ),
        ),
        drawer: const Drawer(
          child: Center(
            child: Text("Navigation Drawer"),
          ), // Requirement [cite: 27]
        ),
        body: TabBarView(
          children: [
            _buildTab(DealType.top),
            _buildTab(DealType.popular),
            _buildTab(DealType.featured),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(DealType type) {
    return BlocProvider(
      create:
          (context) =>
              DealBloc(repository: DealRepository(), type: type)
                ..add(FetchDeals()),
      child: const DealListScreen(),
    );
  }
}
