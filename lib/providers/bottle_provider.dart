import 'package:flutter/material.dart';
import '../models/bottle.dart';

class BottleProvider with ChangeNotifier {
  final List<Bottle> _allBottles = List.generate(50, (index) {
    final volumes = ['500ml', '1L', '1.5L', '2L'];
    final brands = ['Aqua', 'FreshCo', 'Hydro', 'Crystal'];

    // Cycle through available images (1.jpg to 10.jpg)
    final imageIndex = (index % 5) + 1;

    return Bottle(
      id: 'b${index + 1}',
      name: 'Bottle ${index + 1}',
      price: 1.0 + (index % 5) * 0.5,
      imagePath: 'assets/images/img$imageIndex.jpg', // <-- Corrected path with slash
      volume: volumes[index % volumes.length],
      brand: brands[index % brands.length],
    );
  });

  List<Bottle> _filteredBottles = [];
  Set<String> _selectedVolumes = {};
  Set<String> _selectedBrands = {};

  BottleProvider() {
    _filteredBottles = List.from(_allBottles);
  }

  List<Bottle> get bottles => _filteredBottles;
  List<String> get allVolumes => _allBottles.map((b) => b.volume).toSet().toList();
  List<String> get allBrands => _allBottles.map((b) => b.brand).toSet().toList();
  List<String> get selectedVolumes => _selectedVolumes.toList();
  List<String> get selectedBrands => _selectedBrands.toList();

  void setVolumeFilters(List<String> volumes) {
    _selectedVolumes = volumes.toSet();
    _applyFilters();
  }

  void setBrandFilters(List<String> brands) {
    _selectedBrands = brands.toSet();
    _applyFilters();
  }

  void clearFilters() {
    _selectedVolumes.clear();
    _selectedBrands.clear();
    _filteredBottles = List.from(_allBottles);
    notifyListeners();
  }

  void _applyFilters() {
    _filteredBottles = _allBottles.where((bottle) {
      final volumeMatch = _selectedVolumes.isEmpty || _selectedVolumes.contains(bottle.volume);
      final brandMatch = _selectedBrands.isEmpty || _selectedBrands.contains(bottle.brand);
      return volumeMatch && brandMatch;
    }).toList();
    notifyListeners();
  }
}
