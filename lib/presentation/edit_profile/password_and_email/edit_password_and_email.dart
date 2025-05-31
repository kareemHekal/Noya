import 'package:flutter/material.dart';
import 'package:noya_app/core/utils/colors_manager.dart';

import 'email_tab.dart';
import 'password_tab.dart';

class EditPasswordAndEmail extends StatefulWidget {
  const EditPasswordAndEmail({super.key});

  @override
  State<EditPasswordAndEmail> createState() => _EditPasswordAndEmailState();
}

class _EditPasswordAndEmailState extends State<EditPasswordAndEmail>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Email & Password"),
        bottom: TabBar(
          dividerHeight: 0,
          labelColor: ColorManager.mutedSageGreen,
          indicatorColor: ColorManager.mutedSageGreen,
          controller: _tabController,
          tabs: const [Tab(text: "Change Password"), Tab(text: "Change Email")],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [ChangePasswordTab(), ChangeEmailTab()],
      ),
    );
  }
}
