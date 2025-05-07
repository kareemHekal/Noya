import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noya_app/core/utils/colors_manager.dart';
import 'package:noya_app/presentation/materials/mertials_card.dart';
import 'package:noya_app/core/resuable_comp/toast_message.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:noya_app/data/models/material_model.dart';
import 'package:noya_app/presentation/materials/view_model/materials_cubit.dart';
import 'package:shimmer/shimmer.dart';

class MaterialsScreen extends StatefulWidget {
  const MaterialsScreen({Key? key}) : super(key: key);

  @override
  State<MaterialsScreen> createState() => _MaterialsScreenState();
}

class _MaterialsScreenState extends State<MaterialsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<MaterialModel> filteredMaterials = [];
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();

    final cubit = MaterialsCubit.get(context);
    cubit.getMaterials();
    _searchController.addListener(() {
      final query = _searchController.text.toLowerCase();
      final cubit = MaterialsCubit.get(context);
      setState(() {
        _showClearButton = query.isNotEmpty;
        filteredMaterials =
            cubit.materials
                .where(
                  (material) =>
                      material.name?.toLowerCase().contains(query) ?? false,
                )
                .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MaterialsCubit, MaterialsStates>(
      listener: (context, state) {
        if (state is GetMaterialsErrorState) {
          return toastMessage(
            message: state.message.toString(),
            tybeMessage: TybeMessage.negative,
          );
        }
        if (state is GetMaterialsSuccessState) {
          setState(() {
            filteredMaterials = state.materials;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: Text(AppStrings.materialsLabel),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              _buildSearchBar(),
              const SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<MaterialsCubit, MaterialsStates>(
                  builder: (context, state) {
                    if (state is GetMaterialsLoadingState) {
                      return  buildShimmerLoading();
                    }
                    else if (filteredMaterials.isEmpty) {
                      return Center(child: Text(AppStrings.noMaterialsFound));
                    }

                    return AnimationList(
                      duration: 2000,
                      reBounceDepth: 10.0,
                      children: List.generate(
                        filteredMaterials.length,
                        (index) =>
                            MaterialCard(material: filteredMaterials[index]),
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
        hintText: AppStrings.searchMaterials,
        hintStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: const Icon(Icons.search, color: Colors.black87),
        suffixIcon:
            _showClearButton
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
        fillColor: ColorManager.softBeige,
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
