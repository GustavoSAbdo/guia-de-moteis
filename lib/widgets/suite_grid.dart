import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/suite_model.dart';
import '../utils/size_config.dart';
import '../widgets/suite_details_dialog.dart';

class SuiteGrid extends StatelessWidget {
  final List<SuiteModel> suites;

  const SuiteGrid({Key? key, required this.suites}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(SizeConfig.widthPercentage(2)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: SizeConfig.widthPercentage(2),
        mainAxisSpacing: SizeConfig.heightPercentage(2),
      ),
      itemCount: suites.length,
      itemBuilder: (context, index) => SuiteCard(suite: suites[index]),
    );
  }
}

class SuiteCard extends StatefulWidget {
  final SuiteModel suite;

  const SuiteCard({Key? key, required this.suite}) : super(key: key);

  @override
  State<SuiteCard> createState() => _SuiteCardState();
}

class _SuiteCardState extends State<SuiteCard> {
  CarouselSliderController buttonCarouselController = CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => SuiteDetailsDialog(suite: widget.suite),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeConfig.widthPercentage(3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16/9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(SizeConfig.widthPercentage(3))
                    ),
                    child: Stack(
                      children: [
                        CarouselSlider(
                          carouselController: buttonCarouselController,
                          options: CarouselOptions(
                            aspectRatio: 16/9,
                            viewportFraction: 1,
                            enableInfiniteScroll: widget.suite.fotos.length > 1,
                            autoPlay: false,
                            initialPage: _currentIndex,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                          ),
                          items: widget.suite.fotos.map((foto) {
                            return Image.network(
                              foto,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(child: Icon(Icons.error));
                              },
                            );
                          }).toList(),
                        ),
                        if (widget.suite.fotos.length > 1) ...[
                          Positioned.fill(
                            child: Row(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Colors.black54,
                                        Colors.black12,
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                                    onPressed: () => buttonCarouselController.previousPage(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.linear,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerRight,
                                      end: Alignment.centerLeft,
                                      colors: [
                                        Colors.black54,
                                        Colors.black12,
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                                    onPressed: () => buttonCarouselController.nextPage(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.linear,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        if (widget.suite.exibirQtdDisponiveis && widget.suite.qtd > 0)
                          Positioned(
                            top: SizeConfig.heightPercentage(1),
                            right: SizeConfig.widthPercentage(2),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.widthPercentage(2),
                                vertical: SizeConfig.heightPercentage(0.5),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(SizeConfig.widthPercentage(1)),
                              ),
                              child: Text(
                                '${widget.suite.qtd} disponível${widget.suite.qtd > 1 ? 'is' : ''}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.fontSize(12),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (widget.suite.fotos.length > 1)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.heightPercentage(0.5)
                      ),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black45,
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: widget.suite.fotos.asMap().entries.map((entry) {
                          return Container(
                            width: SizeConfig.widthPercentage(1),
                            height: SizeConfig.widthPercentage(1),
                            margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.widthPercentage(0.5)
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(
                                _currentIndex == entry.key ? 0.9 : 0.4,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(SizeConfig.widthPercentage(3)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.suite.nome,
                    style: TextStyle(
                      fontSize: SizeConfig.fontSize(14),
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: SizeConfig.heightPercentage(1)),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: widget.suite.categoriaItens.map((item) {
                        return Padding(
                          padding: EdgeInsets.only(
                            right: SizeConfig.widthPercentage(2)
                          ),
                          child: Tooltip(
                            message: item.nome,
                            child: Image.network(
                              item.icone,
                              height: SizeConfig.heightPercentage(2.5),
                              width: SizeConfig.widthPercentage(5),
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.error, 
                                  size: SizeConfig.widthPercentage(5)
                                );
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightPercentage(1)),
                  Text(
                    'A partir de R\$ ${widget.suite.periodos.first.valor.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: SizeConfig.fontSize(12),
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 