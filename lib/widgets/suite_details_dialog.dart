import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/suite_model.dart';
import '../utils/size_config.dart';

class SuiteDetailsDialog extends StatefulWidget {
  final SuiteModel suite;

  const SuiteDetailsDialog({Key? key, required this.suite}) : super(key: key);

  @override
  State<SuiteDetailsDialog> createState() => _SuiteDetailsDialogState();
}

class _SuiteDetailsDialogState extends State<SuiteDetailsDialog> {
  CarouselSliderController buttonCarouselController = CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConfig.widthPercentage(3)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
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
                    );
                  }).toList(),
                ),
                Positioned(
                  top: SizeConfig.heightPercentage(1),
                  right: SizeConfig.widthPercentage(1),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                if (widget.suite.fotos.length > 1)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.heightPercentage(1),
                      ),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black45, Colors.transparent],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: widget.suite.fotos.asMap().entries.map((entry) {
                          return Container(
                            width: SizeConfig.widthPercentage(2),
                            height: SizeConfig.widthPercentage(2),
                            margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.widthPercentage(0.5),
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
              padding: EdgeInsets.all(SizeConfig.widthPercentage(4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.suite.nome,
                    style: TextStyle(
                      fontSize: SizeConfig.fontSize(18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightPercentage(2)),
                  Text(
                    'Itens da Suíte',
                    style: TextStyle(
                      fontSize: SizeConfig.fontSize(16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightPercentage(1)),
                  Wrap(
                    spacing: SizeConfig.widthPercentage(2),
                    runSpacing: SizeConfig.heightPercentage(1),
                    children: widget.suite.itens.map((item) {
                      return Chip(
                        label: Text(
                          item.nome,
                          style: TextStyle(
                            fontSize: SizeConfig.fontSize(12),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: SizeConfig.heightPercentage(2)),
                  Text(
                    'Períodos',
                    style: TextStyle(
                      fontSize: SizeConfig.fontSize(16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightPercentage(1)),
                  ...widget.suite.periodos.map((periodo) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: SizeConfig.heightPercentage(1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            periodo.tempoFormatado,
                            style: TextStyle(
                              fontSize: SizeConfig.fontSize(14),
                            ),
                          ),
                          Text(
                            'R\$ ${periodo.valor.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: SizeConfig.fontSize(14),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 