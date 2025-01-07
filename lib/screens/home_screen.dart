import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:medex/services/api_services.dart';
import 'package:medex/screens/medicine_detailpage.dart';
import 'package:medex/utils/app_images.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();

  var result = [];
  var filteredResults = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = true; // Add a loading state

  Future<void> getMedicines() async {
    result = await apiService.getMedicines();
    filteredResults = List.from(result);
    setState(() {
      isLoading = false; // Set loading to false after fetching data
    });
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      filteredResults = List.from(result);
    } else {
      filteredResults = result.where((medicine) {
        String genericName = medicine["openfda"]["generic_name"]?[0] ?? "";
        return genericName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    setState(() {});
  }

  @override
  void initState() {
    getMedicines();
    super.initState();
  }

  Widget buildShimmer() {
    return ListView.builder(
      itemCount: 6, // Number of shimmer placeholders
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Medex',
          style: TextStyle(
            fontFamily: 'font2',
            fontSize: 20,
            fontWeight: FontWeight.w100,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CarouselSlider(
                items: [
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: Image(
                      image: NetworkImage(AppImages.carouselImage1),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Image(image: NetworkImage(AppImages.carouselImage2)),
                  ),
                  Container(
                    width: double.infinity,
                    child: Image(image: NetworkImage(AppImages.carouselImage3)),
                  ),
                  Container(
                    width: double.infinity,
                    child: Image(image: NetworkImage(AppImages.carouselImage4)),
                  ),
                  Container(
                    width: double.infinity,
                    child: Image(image: NetworkImage(AppImages.carouselImage5)),
                  )
                ],
                options: CarouselOptions(
                  height: 200.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 600),
                  viewportFraction: 0.8,
                )),
          ),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Available Medicines",
                style: TextStyle(
                  fontFamily: 'Font2',
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: filterSearchResults,
              decoration: InputDecoration(
                hintText: "Search for medicines",
                hintStyle: const TextStyle(
                  fontFamily: 'Font2',
                  color: Colors.grey,
                  fontSize: 15,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 174, 208, 191), width: 2),
                  borderRadius: BorderRadius.circular(13),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(13),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
              ),
              style: const TextStyle(
                fontFamily: 'font2',
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? buildShimmer() // Show shimmer effect while loading
                : ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MedicineDetailPage(
                                    product_data: filteredResults[index])));
                          },
                          child: Container(
                            height: 100,
                            width: double.infinity,
                            color: Colors.green[50],
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Container(
                                    width: 150,
                                    margin: const EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Image(
                                      image: NetworkImage(
                                          "https://t4.ftcdn.net/jpg/05/77/84/27/240_F_577842756_DWiS65lNLDG5DPaozrJk3c9TgkGGBwCb.jpg"),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          (filteredResults[index]["openfda"]
                                                  ["generic_name"][0])
                                              .toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontFamily: "Font2",
                                            fontSize: 15,
                                          ),
                                          maxLines: 3,
                                          softWrap: true,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          (filteredResults[index]["openfda"]
                                                      ["product_type"]?[0] ??
                                                  "N/A")
                                              .toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'font2',
                                            fontSize: 10,
                                          ),
                                        ),
                                        Text(
                                          (filteredResults[index]["openfda"]
                                                      ["substance_name"]?[0] ??
                                                  "N?A")
                                              .toString(),
                                          style: const TextStyle(
                                            fontFamily: "font2",
                                            fontSize: 8,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: filteredResults.length,
                  ),
          ),
        ],
      ),
    );
  }
}
