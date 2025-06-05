import 'package:flutter/material.dart';
import 'package:flutter_animations/widgets/views/container_transform/container_transform_grid_view.dart';
import 'package:flutter_animations/widgets/views/container_transform/container_transform_list_view.dart';

class ContainerTransformScreen extends StatefulWidget {
  const ContainerTransformScreen({super.key});

  @override
  State<ContainerTransformScreen> createState() =>
      _ContainerTransformScreenState();
}

class _ContainerTransformScreenState extends State<ContainerTransformScreen> {
  bool _isGrid = false;

  void _toggleGrid() {
    setState(() {
      _isGrid = !_isGrid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Container transform'),
        actions: [
          IconButton(onPressed: _toggleGrid, icon: Icon(Icons.grid_4x4)),
        ],
      ),
      body:
          _isGrid ? ContainerTransformGridView() : ContainerTransformListView(),
    );
  }
}
