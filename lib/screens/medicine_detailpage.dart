import 'package:flutter/material.dart';

class MedicineDetailPage extends StatelessWidget {
  final Map<String, dynamic> product_data;
  const MedicineDetailPage({super.key, required this.product_data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 300,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(60.0),
                        bottomLeft: Radius.circular(60.0),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://t4.ftcdn.net/jpg/05/77/84/27/240_F_577842756_DWiS65lNLDG5DPaozrJk3c9TgkGGBwCb.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 10,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.greenAccent,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (product_data["openfda"]?["generic_name"] != null)
                      _buildSectionTitle("Generic Name"),
                    if (product_data["openfda"]?["generic_name"] != null)
                      _buildSectionContent(
                          product_data["openfda"]["generic_name"]?.join(", ")),
                    if (product_data["purpose"] != null)
                      _buildSectionTitle("Purpose"),
                    if (product_data["purpose"] != null)
                      _buildSectionContent(product_data["purpose"]?[0]),
                    if (product_data["warnings"] != null)
                      _buildSectionTitle("Warnings"),
                    if (product_data["warnings"] != null)
                      _buildSectionContent(product_data["warnings"]?[0]),
                    if (product_data["storage_and_handling"] != null)
                      _buildSectionTitle("Storage and Handling"),
                    if (product_data["storage_and_handling"] != null)
                      _buildSectionContent(
                          product_data["storage_and_handling"]?[0]),
                    if (product_data["openfda"]?["manufacturer_name"] != null)
                      _buildSectionTitle("Manufacturer"),
                    if (product_data["openfda"]?["manufacturer_name"] != null)
                      _buildSectionContent(
                          product_data["openfda"]["manufacturer_name"]?[0]),
                    if (product_data["active_ingredient"] != null)
                      _buildSectionTitle("Active Ingredients"),
                    if (product_data["active_ingredient"] != null)
                      _buildSectionContent(
                          product_data["active_ingredient"]?.join(", ")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Font2',
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        content,
        style: const TextStyle(
          fontFamily: 'font2',
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    );
  }
}
