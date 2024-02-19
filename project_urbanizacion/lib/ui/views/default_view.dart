import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_urbanizacion/style/custom_labels.dart';
import 'package:project_urbanizacion/ui/components/white_card.dart';

class DefaultView extends StatefulWidget {
  const DefaultView({Key? key}) : super(key: key);

  @override
  State<DefaultView> createState() => _DefaultViewState();
}

class _DefaultViewState extends State<DefaultView> {
  @override
  void initState() {
    //Provider.of<SideMenuProvider>(context, listen: false).updateModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final sideMenuProvider = Provider.of<SideMenuProvider>(context);
    //final idModulo = LocalStorage.prefs.getString('idModule');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          WhiteCard(
              listWidget: const [],
              child: Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'PANTALLA DE INICIO',
                        style: CustomLabels.h4.copyWith(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 1.5,
                          child: Lottie.asset('animate/home.json')),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

/* class MenuItem {
  final String text;
  final String url;
  final IconData icon;

  const MenuItem({required this.text, required this.icon, required this.url});
}

class MenuItems {
  MenuItems(this.opcion, this.menuResponse) {
    firstTesteo = menuResponse
        .where((element) => element.codPry.startsWith(opcion))
        .map((e) {
      return MenuItem(
          text: e.nomPry, icon: Icons.assistant_direction, url: e.urlPry);
    }).toList();
  }

  List<MenuResponse> menuResponse = [];
  List<MenuItem> firstTesteo = [];
  String opcion;

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 18),
        const SizedBox(width: 10),
        Text(
          item.text,
          maxLines: 2,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    );
  }
}

 */
/* 

 return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          WhiteCard(
            title: 'MENÚ',
            listWidget: const [],
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    for (var item in sideMenuProvider.menusubList.where(
                        (element) =>
                            element.codPry.substring(0, 2) == idModulo)) ...[
                      sideMenuProvider.item
                                  .where((element) =>
                                      element.codPry.startsWith(item.codPry))
                                  .length <=
                              1
                          ? Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: InkWell(
                                onTap: () =>
                                    NavigationService.replaceTo(item.urlPry),
                                child: Column(
                                  children: [
                                    Container(
                                      height: !ScreenQueries.instance
                                              .isMobile(context)
                                          ? 200
                                          : 150,
                                      width: !ScreenQueries.instance
                                              .isMobile(context)
                                          ? 200
                                          : 150,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: UtilView.convertColor(
                                              item.clxPry)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.block,
                                          size: !ScreenQueries.instance
                                                  .isMobile(context)
                                              ? 120
                                              : 80,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                        padding: const EdgeInsets.all(8.0),
                                        constraints:
                                            const BoxConstraints(maxWidth: 200),
                                        child: Text(
                                          item.nomPry,
                                          textAlign: TextAlign.center,
                                          maxLines: 3,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: !ScreenQueries.instance
                                                      .isMobile(context)
                                                  ? 16
                                                  : 12),
                                        ))
                                  ],
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<MenuItem>(
                                  isExpanded: true,
                                  customButton: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: !ScreenQueries.instance
                                                .isMobile(context)
                                            ? 200
                                            : 150,
                                        width: !ScreenQueries.instance
                                                .isMobile(context)
                                            ? 200
                                            : 150,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: UtilView.convertColor(
                                                item.clxPry)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(Icons.block,
                                              size: 120, color: Colors.white),
                                        ),
                                      ),
                                      Container(
                                          padding: const EdgeInsets.all(8.0),
                                          constraints: const BoxConstraints(
                                              maxWidth: 200),
                                          child: Text(
                                            item.nomPry,
                                            textAlign: TextAlign.center,
                                            maxLines: 3,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: !ScreenQueries
                                                        .instance
                                                        .isMobile(context)
                                                    ? 16
                                                    : 12),
                                          ))
                                    ],
                                  ),
                                  items: [
                                    ...MenuItems(
                                            item.codPry, sideMenuProvider.item)
                                        .firstTesteo
                                        .map(
                                          (item) => DropdownMenuItem<MenuItem>(
                                            value: item,
                                            child: MenuItems.buildItem(item),
                                          ),
                                        ),
                                  ],
                                  onChanged: (value) {
                                    MenuItem obj = value as MenuItem;
                                    NavigationService.replaceTo(obj.url);
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    height: 50,
                                    width: 160,
                                    padding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: Colors.black26,
                                      ),
                                      color: Colors.redAccent,
                                    ),
                                    elevation: 2,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                      maxHeight: 200,
                                      width: 200,
                                      padding: null,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: Colors.redAccent,
                                      ),
                                      elevation: 8,
                                      offset: const Offset(-20, 0),
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(40),
                                        thickness: MaterialStateProperty.all(6),
                                        thumbVisibility:
                                            MaterialStateProperty.all(true),
                                      )),
                                  iconStyleData: const IconStyleData(
                                      icon: Icon(
                                          Icons.arrow_forward_ios_outlined),
                                      iconSize: 8,
                                      iconEnabledColor: Colors.yellow,
                                      iconDisabledColor: Colors.grey,
                                      openMenuIcon: Icon(Icons.delete)),
                                  menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14)),
                                ),
                              ),
                            )
                    ],
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );


 */