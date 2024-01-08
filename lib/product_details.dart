import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  List<String> images = [
    'assets/images/omarr.jpg',
    'assets/images/omar.jpg',
  ];
  Map<String, bool> selection = {
    'M': true,
    'L': false,
    'XL': false,
  };

  void toggleSelection(String size) {
    setState(() {
      selection.forEach((key, value) {
        selection[key] = key == size;
      });
    });
  }

  List<Color> circleColors = [const Color.fromARGB(255, 215, 128, 34), Colors.green, Colors.blue];

  // this widget to built a circles for L , M , XL
  Widget buildCircle(String size) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 5),
      child: GestureDetector(
        onTap: () {
          toggleSelection(size);
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selection[size]!
                ? const Color.fromARGB(255, 215, 128, 34)
                : const Color.fromARGB(255, 255, 255, 255),
          ),
          child: Center(
            child: Text(
              size,
              style: TextStyle(
                color: selection[size]! ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  int selectedCircleIndex = 0;

  void _handleCircleTap(int index) {
    setState(() {
      selectedCircleIndex = selectedCircleIndex == index ? -1 : index;
    });
  }

  // This Widget To Build a selector for ColorsS
  List<Widget> _buildCircles() {
    return List.generate(circleColors.length, (index) {
      return GestureDetector(
        onTap: () => _handleCircleTap(index),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(3.6),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: circleColors[index],
              ),
            ),
            if (selectedCircleIndex == index) _buildSmallCircle(),
          ],
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentIndex = _pageController.page!.round();
      });
    });
  }

// to build a small white circle
  Widget _buildSmallCircle() {
    return Container(
      width: 15,
      height: 15,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }

  Widget _buildDots(int pageCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == index ? const Color.fromARGB(255, 215, 128, 34) : Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: images.length,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(242, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 244, 242, 242),
          leading: CupertinoButton(
            onPressed: (){},
            padding: EdgeInsets.zero,
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          title: const Text(
            'Product Details',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Stack(
              children: [
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shopping_bag,
                    color: Colors.black,
                  ),
                ),
                const Positioned(
                  top: 3,
                  right: 9,
                  child: Text(
                    '0',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  color: const Color.fromARGB(255, 242, 242, 242),
                  child: Stack(
                    children: [
                      PageView.builder(
                        onPageChanged: (value) {
                          currentIndex = value;
                        },
                        controller: _pageController,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 70, right: 70),
                              child: Image.asset(
                                images[index],
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        height: 360,
                        width: 350,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildDots(2),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text(
                        'Shoes, Brand new Dabka, It\'s Beautiful',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      CupertinoButton(
                        minSize: double.minPositive,
                        padding: EdgeInsets.zero,
                        child: const Icon(
                          Icons.compare_arrows,
                          color: Colors.grey,
                        ),
                        onPressed: () {},
                      ),
                      CupertinoButton(
                        minSize: double.minPositive,
                        padding: const EdgeInsets.all(6),
                        child: const Icon(
                          Icons.favorite_border,
                          color: Colors.grey,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Text(
                        '\$300.0',
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          '\$320.0',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Text(
                        '3,5',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 15,
                      ),
                      Text(
                        '[350 Orders]',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Text(
                        'Size',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                //selector of sizes L , M , XL *****************
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    buildCircle('M'),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 2.0,
                        right: 2.0,
                      ),
                      child: buildCircle('L'),
                    ),
                    buildCircle('XL'),
                  ],
                ),

                //Color word*************************************

                const Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 8),
                  child: Row(
                    children: [
                      Text(
                        'Color',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                // Selector of colors ******************
                Padding(
                  padding: const EdgeInsets.only(left: 7.0, top: 10),
                  child: Row(
                    children: _buildCircles(),
                  ),
                ),
                const SizedBox(height: 10),
                //Added to card button******************
                SizedBox(
                  width: 330,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      backgroundColor: const Color.fromARGB(255, 215, 128, 34),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Added to cart',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                //**************Descriptipn*********** */
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 5),
                  child: Row(
                    children: [
                      Text(
                        'Descriptipn',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                //***********This is new product,******** */
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 5),
                  child: Row(
                    children: [
                      Text(
                        'This is new product, it\'s amazing product for ever. this is a valuable product',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color.fromARGB(255, 139, 139, 139),
                        ),
                      ),
                    ],
                  ),
                ),
                //*********Review Products and See All********
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      const Text(
                        'Review Products(4)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'See All',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 236, 145, 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //****************3.5 [4 review]*************
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Text(
                        '3,5',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 15,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        '[4 Reviews]',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
