import 'package:flutter/material.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CineApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

class Movie {
  final String title;
  final String director;
  final double rating;
  final String duration;
  final String imageUrl;

  Movie({
    required this.title,
    required this.director,
    required this.rating,
    required this.duration,
    required this.imageUrl,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _controller = PageController(viewportFraction: 0.75);
  int _currentIndex = 0;

  final List<Movie> movies = [
    Movie(
      title: 'CUAHTLI SUP',
      director: 'Todd Phillips',
      rating: 5.0,
      duration: '2h 42m',
      imageUrl: 'https://github.com/SebassRM128/imagenes/blob/main/relojj2.png?raw=true', // PON AQUÍ TU URL
    ),
    Movie(
      title: 'Avengo',
      director: 'Anthony Russo',
      rating: 4.8,
      duration: '3h 1m',
      imageUrl: 'https://github.com/SebassRM128/imagenes/blob/main/relojj1.png?raw=true', // PON AQUÍ TU URL
    ),
    Movie(
      title: 'CARTIER',
      director: 'Christopher Nolan',
      rating: 4.9,
      duration: '2h 28m',
      imageUrl: 'https://github.com/SebassRM128/imagenes/blob/main/relojjj1.png?raw=true', // PON AQUÍ TU URL
    ),
    Movie(
      title: 'Natman',
      director: 'Matt Reeves',
      rating: 4.7,
      duration: '2h 56m',
      imageUrl: 'https://github.com/SebassRM128/imagenes/blob/main/imagenn333.png?raw=true', // PON AQUÍ TU URL
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentMovie = movies[_currentIndex];

    return Scaffold(
      body: Stack(
        children: [
          // Fondo dinámico
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Container(
              key: ValueKey(currentMovie.imageUrl),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(currentMovie.imageUrl.isEmpty
                      ? 'https://github.com/SebassRM128/imagenes/blob/main/relojjj1.png?raw=true'
                      : currentMovie.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          // Contenido
          Column(
            children: [
              const SizedBox(height: 60),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: movies.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration: const Duration(milliseconds: 600),
                              pageBuilder: (_, __, ___) =>
                                  MovieDetailScreen(movie: movie),
                              transitionsBuilder: (_, animation, __, child) {
                                return FadeTransition(opacity: animation, child: child);
                              },
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  movie.imageUrl.isEmpty
                                      ? 'https://via.placeholder.com/300x450?text=Movie+Poster'
                                      : movie.imageUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              movie.title,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text("Direct by ${movie.director}",
                                style: const TextStyle(fontSize: 14, color: Colors.white70)),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 18),
                                const SizedBox(width: 4),
                                Text("${movie.rating}",
                                    style: const TextStyle(fontSize: 14)),
                                const SizedBox(width: 12),
                                const Icon(Icons.timer, size: 18),
                                const SizedBox(width: 4),
                                Text(movie.duration, style: const TextStyle(fontSize: 14)),
                                const SizedBox(width: 12),
                                const Icon(Icons.play_circle, size: 18),
                                const SizedBox(width: 4),
                                const Text("Watch", style: TextStyle(fontSize: 14)),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.network(
            movie.imageUrl.isEmpty
                ? 'https://via.placeholder.com/500x800?text=Movie+Details'
                : movie.imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(color: Colors.black.withOpacity(0.6)),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: kToolbarHeight + 20),
                Text(movie.title,
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text("Directed by ${movie.director}",
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 6),
                    Text("${movie.rating}", style: const TextStyle(fontSize: 16)),
                    const SizedBox(width: 20),
                    const Icon(Icons.timer, size: 20),
                    const SizedBox(width: 6),
                    Text(movie.duration, style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  "Description:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Aquí puedes agregar la sinopsis detallada de la película. "
                  "Este es un texto de ejemplo para mostrar cómo quedaría una descripción.",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
