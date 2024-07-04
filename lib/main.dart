import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';  // Importa esta librería para las funciones de llamada, ruta y compartir

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Flutter layout demo';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              LocationSection(
                name: 'Quito',
                description: 'Quito es la capital de Ecuador.',
                image: 'assets/quito.jpg',
              ),
              LocationSection(
                name: 'La Basilica',
                description: 'La Basílica del Voto Nacional es un monumento religioso en Quito, Ecuador.',
                image: 'assets/basilica.jpg',
              ),
              LocationSection(
                name: 'El Panecillo',
                description: 'El Panecillo es una colina en el centro de Quito, con una estatua de la Virgen de Quito en la cima.',
                image: 'assets/panecillo.jpg', // Ruta de la imagen para El Panecillo
              ),
              LocationSection(
                name: 'Guayaquil',
                description: 'Guayaquil es la ciudad más grande y poblada de Ecuador, situada en la costa del Pacífico.',
                image: 'assets/guayaquil.jpg', // Ruta de la imagen para Guayaquil
              ),
              LocationSection(
                name: 'La Ronda',
                description: 'La Ronda es un barrio histórico y cultural en el centro de Quito, conocido por sus calles empedradas y arquitectura colonial.',
                image: 'assets/ronda.jpg', // Ruta de la imagen para La Ronda
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LocationSection extends StatelessWidget {
  final String name;
  final String description;
  final String image;

  const LocationSection({
    Key? key,
    required this.name,
    required this.description,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleSection(name: name, location: description),
        ImageSection(image: image),
        ButtonSection(),
        TextSection(description: description),
        const SizedBox(height: 20), // Espacio adicional entre secciones
      ],
    );
  }
}

class TitleSection extends StatelessWidget {
  final String name;
  final String location;

  const TitleSection({
    Key? key,
    required this.name,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  location,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.star,
            color: Colors.red,
          ),
          const Text('41'),
        ],
      ),
    );
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({Key? key}) : super(key: key);

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _routeToLocation(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _shareContent(String content) async {
    if (await canLaunch(content)) {
      await launch(content);
    } else {
      throw 'Could not share $content';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.call, color: color),
            onPressed: () {
              _makePhoneCall('tel:+123456789');
            },
          ),
          IconButton(
            icon: Icon(Icons.near_me, color: color),
            onPressed: () {
              _routeToLocation('https://www.google.com/maps');
            },
          ),
          IconButton(
            icon: Icon(Icons.share, color: color),
            onPressed: () {
              _shareContent('Check out this location!');
            },
          ),
        ],
      ),
    );
  }
}


class ImageSection extends StatelessWidget {
  final String image;

  const ImageSection({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      width: 600,
      height: 240,
      fit: BoxFit.cover,
    );
  }
}

class TextSection extends StatelessWidget {
  final String description;

  const TextSection({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Text(
        description,
        softWrap: true,
      ),
    );
  }
}
