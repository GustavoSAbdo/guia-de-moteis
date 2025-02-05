import 'package:flutter/material.dart';
import 'package:guia_de_moteis/widgets/suite_grid.dart';
import '../models/motel_model.dart';
import '../utils/size_config.dart';

class MotelDetailsScreen extends StatelessWidget {
  final MotelModel motel;

  const MotelDetailsScreen({
    Key? key,
    required this.motel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.widthPercentage(4)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildLogo(),
                SizedBox(height: SizeConfig.heightPercentage(2)),
                _buildFantasia(),
                SizedBox(height: SizeConfig.heightPercentage(1)),
                _buildLocationInfo(),
                SizedBox(height: SizeConfig.heightPercentage(2)),
                _buildFavoritosEAvaliacoes(),
                SizedBox(height: SizeConfig.heightPercentage(2)),
                _buildSuitesGrid(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: SizeConfig.widthPercentage(72),
        ),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.network(
            motel.logo,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.error,
                size: SizeConfig.widthPercentage(10),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFantasia() {
    return Text(
      motel.fantasia,
      style: TextStyle(
        fontSize: SizeConfig.fontSize(30),
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLocationInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            motel.bairro,
            style: TextStyle(
              fontSize: SizeConfig.fontSize(16),
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: SizeConfig.widthPercentage(2)),
        Text(
          '${motel.distancia.toStringAsFixed(1)} km',
          style: TextStyle(
            fontSize: SizeConfig.fontSize(16),
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildFavoritosEAvaliacoes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildInfoCard(
          icon: Icons.favorite,
          value: motel.qtdFavoritos.toString(),
          label: 'Favoritos',
        ),
        SizedBox(width: SizeConfig.widthPercentage(4)),
        _buildInfoCard(
          icon: Icons.star,
          value: motel.media.toString(),
          label: '${motel.qtdAvaliacoes} avaliações',
        ),
      ],
    );
  }

  Widget _buildSuitesGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightPercentage(2),
          ),
          child: Text(
            'Suítes Disponíveis',
            style: TextStyle(
              fontSize: SizeConfig.fontSize(20),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SuiteGrid(suites: motel.suites),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.widthPercentage(2)),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.red,
              size: SizeConfig.widthPercentage(6),
            ),
            SizedBox(height: SizeConfig.heightPercentage(0.5)),
            Text(
              value,
              style: TextStyle(
                fontSize: SizeConfig.fontSize(16),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: SizeConfig.fontSize(12),
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
