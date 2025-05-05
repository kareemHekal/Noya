import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noya_app/core/resuable_comp/toast_message.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:noya_app/data/models/WorkerModel.dart';
import 'package:noya_app/presentation/workers/view_model/workers_cubit.dart';
import 'package:noya_app/presentation/workers/widgets/worker_card.dart';
import 'package:shimmer/shimmer.dart';
import 'package:animation_list/animation_list.dart';

class WorkersScreen extends StatefulWidget {
  const WorkersScreen({Key? key}) : super(key: key);

  @override
  State<WorkersScreen> createState() => _WorkersScreenState();
}

class _WorkersScreenState extends State<WorkersScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<WorkerModel> filteredWorkers = [];
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();

    final cubit = WorkersCubit.get(context);
    cubit.getWorkers();

    _searchController.addListener(() {
      final query = _searchController.text.toLowerCase();
      final cubit = WorkersCubit.get(context);
      setState(() {
        _showClearButton = query.isNotEmpty;
        filteredWorkers = cubit.workers
            .where(
              (worker) => (worker.name?.toLowerCase().contains(query) ?? false) ||
              (worker.specialization?.toLowerCase().contains(query) ?? false),
        )
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkersCubit, WorkersStates>(
      listener: (context, state) {
        if (state is GetWorkersErrorState) {
          toastMessage(
            message: state.message.toString(),
            tybeMessage: TybeMessage.negative,
          );
        }
        if (state is GetWorkersSuccessState) {
          setState(() {
            filteredWorkers = state.workers;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          forceMaterialTransparency: true,
          title: Text(AppStrings.contractorsLabel),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              _buildSearchBar(),
              const SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<WorkersCubit, WorkersStates>(
                  builder: (context, state) {
                    if (state is GetWorkersLoadingState) {
                      return buildShimmerLoading();
                    } else if (filteredWorkers.isEmpty) {
                      return Center(child: Text(AppStrings.noWorkersFound));
                    }

                    return AnimationList(
                      duration: 2000,
                      reBounceDepth: 10.0,
                      children: List.generate(
                        filteredWorkers.length,
                            (index) =>
                            WorkerCard(workerModel: filteredWorkers[index]),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextFormField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: AppStrings.searchWorkers,
        hintStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: const Icon(Icons.search, color: Colors.black87),
        suffixIcon: _showClearButton
            ? IconButton(
          icon: const Icon(Icons.clear, color: Colors.black87),
          onPressed: () {
            _searchController.clear();
            FocusScope.of(context).unfocus();
          },
        )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.black87, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.black87, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.black, width: 2.0),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 20.0,
        ),
      ),
      style: const TextStyle(color: Colors.black87),
    );
  }

  Widget buildShimmerLoading() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}

