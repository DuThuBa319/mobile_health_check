import 'package:common_project/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:flutter/material.dart';

import '../../theme/theme_color.dart';
import 'package:badges/badges.dart' as badges;

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

int soluongitem = 0;

class _ShoppingScreenState extends State<ShoppingScreen> {
  bool vien1 = false;
  bool vien2 = false;
  bool vien3 = false;

  bool cart = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CustomScreenForm(
        title: 'Shopping Cart',
        appBarColor: AppColor.appBarColor,
        backgroundColor: AppColor.appBarColor,
        isShowLeadingButton: true,
        isShowAppBar: true,
        isShowRightButon: true,
        selectedIndex: 1,
        isShowBottomNayvigationBar: true,
        isScrollable: true,
        rightButton: Row(
          children: [
            const IconButton(
                onPressed: null, icon: Icon(Icons.search, color: Colors.white)),
            const SizedBox(width: 15),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Row(
                children: [
                  badges.Badge(
                    showBadge: cart,
                    child: const Icon(Icons.shopping_cart, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
        child: Stack(children: [
          Container(
            margin: const EdgeInsets.only(left: 15),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Aristoratic HandBag ",
                        style: TextStyle(color: Colors.white, fontSize: 15)),
                  ],
                ),
                Text("Office Code ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold)),
                Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: Text("Price ",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
                Text("\$${234}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          //CONTAINER NỀN TRẮNG
          Container(
            margin: EdgeInsets.only(top: size.height * 0.32),
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            ),
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 60, 10, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Row đầu tiên chỉ có "color" và "size"
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 25, 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Color",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54)),
                          Text(
                            "Size",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          )
                        ]),
                  ),
                  //ROW  CÓ BUTTON VÀ "12CM"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              backgroundColor:
                                  const Color.fromARGB(255, 34, 100, 186),
                            ),
                            onPressed: () {
                              setState(() {
                                vien1 = !vien1;
                                vien3 = false;
                                vien2 = false;
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: vien1
                                    ? Border.all(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        width: 2)
                                    : null,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              backgroundColor: Colors.yellow,
                            ),
                            onPressed: () {
                              setState(() {
                                vien2 = !vien2;
                                vien1 = false;
                                vien3 = false;
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: vien2
                                    ? Border.all(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        width: 2)
                                    : null,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              backgroundColor:
                                  const Color.fromARGB(255, 46, 46, 46),
                            ),
                            onPressed: () {
                              setState(() {
                                vien3 = !vien3;
                                vien1 = false;
                                vien2 = false;
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: vien3
                                    ? Border.all(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        width: 2)
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),

                      //12CM
                      const Text(
                        "12cm",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  // STRING
                  const Text(
                    " Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the insdustry's standard dummy text ever since. When an unknown printer took a galley.",
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: "Roboto",
                      color: Color.fromARGB(255, 82, 74, 74),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      height: 2,
                    ),
                  ),
                  // REMOVE OR ADD TO CART
                  RemoveOrAdd(),
                  // ADDING TO CART (display an icon cart_shopping)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 25, 0, 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 108, 172, 224)),
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        )),
                                    onPressed: () {
                                      if (soluongitem >= 1) {
                                        setState(() {
                                          cart = true;
                                          print(cart);
                                        });
                                      }

                                      if (soluongitem == 0) {
                                        setState(() {
                                          cart = false;
                                          print(cart);
                                        });
                                      }
                                    },
                                    child: const Icon(
                                      Icons.add_shopping_cart,
                                      color: Color(0xFF3D82AE),
                                      size: 35,
                                    ),
                                  )),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      backgroundColor: const Color(0xFF3D82AE),
                                      fixedSize: const Size(250, 60)),
                                  onPressed: () {},
                                  child: const Text(
                                    "BUY NOW",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ]),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Image.asset("lib/assets/images/bag_1.png")
              // )
            ]),
          )
        ]));
  }

  Widget RemoveOrAdd() {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 25, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //ICON REMOVE
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                  height: 60,
                  width: 60,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                          width: 2, color: Color.fromARGB(255, 108, 172, 224)),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      if (soluongitem >= 1) {
                        setState(() {
                          soluongitem--;
                          if (soluongitem == 0) {
                            cart = false;
                          }
                        });
                      }
                    },
                    child: const Icon(
                      Icons.remove,
                      color: Colors.black,
                      size: 35,
                    ),
                  )),
              // ĐẾM ITEM ĐƯỢC BỎ VÀO CART
              Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(shape: BoxShape.rectangle),
                  child: Center(
                    child: Text(
                      "$soluongitem",
                      style: const TextStyle(fontSize: 30),
                    ),
                  )),
              // ICON ADD
              SizedBox(
                  height: 60,
                  width: 60,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 108, 172, 224)),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        )),
                    onPressed: () {
                      if (soluongitem >= 0) {
                        setState(() {
                          soluongitem++;
                          cart = true;
                        });
                      }
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 35,
                    ),
                  )),
            ],
          ),
          // ICON HEART
          Row(
            children: [
              Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 35,
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
