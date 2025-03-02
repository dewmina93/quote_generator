import 'package:flutter/material.dart';
import 'dart:math';
import 'quote_screen.dart'; // Importing the QuoteDetailsScreen
import '../models/quote.dart'; // Importing the Quote model

// HomeScreen is a StatefulWidget that allows users to generate and view quotes
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// State class for HomeScreen
class _HomeScreenState extends State<HomeScreen> {
  String dropdownValue = 'Inspiration'; // Default selected category
  int prevNum =
      0; // to stop the previous random number to prevent showing the same quote

  // List of available quote categories
  final List<String> categories = [
    'Inspiration',
  'Wisdom',
  'Love',
  'Courage',  
  ];

  // Map of quotes categorized by their type
  final Map<String, List<Quote>> quotes = {
    'Inspiration': [
    Quote(
      text: "The best way to predict the future is to invent it.",
      author: "Alan Kay",
      image: "images/alan_kay.jpg",
      details: "Alan Kay, a computer scientist, emphasizes the power of innovation and creativity in shaping the future.",
    ),
    Quote(
      text: "Do not wait to strike till the iron is hot; but make it hot by striking.",
      author: "William Butler Yeats",
      image: "images/yeats.jpg",
      details: "This quote by William Butler Yeats encourages proactive action and determination.",
    ),
  ],
  'Wisdom': [
    Quote(
      text: "The only true wisdom is in knowing you know nothing.",
      author: "Socrates",
      image: "images/socrates.jpg",
      details: "Socrates, a classical Greek philosopher, highlights the importance of humility and continuous learning.",
    ),
    Quote(
      text: "In the middle of difficulty lies opportunity.",
      author: "Albert Einstein",
      image: "images/einstein.jpg",
      details: "Albert Einstein suggests that challenges often present opportunities for growth and success.",
    ),
  ],
  'Love': [
    Quote(
      text: "Love all, trust a few, do wrong to none.",
      author: "William Shakespeare",
      image: "images/shakespeare.jpg",
      details: "William Shakespeare advises a balanced approach to love, trust, and integrity.",
    ),
    Quote(
      text: "The best thing to hold onto in life is each other.",
      author: "Audrey Hepburn",
      image: "images/hepburn.jpg",
      details: "Audrey Hepburn, an actress and humanitarian, emphasizes the importance of relationships and support.",
    ),
  ],
  'Courage': [
    Quote(
      text: "Courage is not the absence of fear, but the triumph over it.",
      author: "Nelson Mandela",
      image: "images/mandela.jpg",
      details: "Nelson Mandela, a South African leader, defines courage as overcoming fear.",
    ),
    Quote(
      text: "It takes courage to grow up and become who you really are.",
      author: "E.E. Cummings",
      image: "images/cummings.jpg",
      details: "E.E. Cummings, a poet, highlights the bravery required to embrace one's true self.",
    ),
  ],
  };

  Quote? displayedQuote; // Currently displayed quote

  // Function to generate a random quote
  void generateQuote() {
    final random = Random();
    final quoteList =
        quotes[dropdownValue] ?? []; // Get quotes for the selected category
    if (quoteList.isNotEmpty) {
      setState(() {
        int randNum;
        do {
          randNum = random.nextInt(quoteList.length);
        } while (quoteList.length > 1 &&
            randNum == prevNum); // Prevents repeat quotes

        prevNum = randNum; // Store previous quote index
        displayedQuote = quoteList[randNum]; // Select a random quote
      });
    }
  }

  // Function to navigate to the Quote screen
  void navigateToQuoteDetails() {
    if (displayedQuote != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuoteScreen(
              quote: displayedQuote!), // Pass the displayed quote to the screen
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (displayedQuote == null) {
      generateQuote();
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Quote Generator")), // AppBar with title
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Select a Category:",
                style: TextStyle(fontSize: 20)), // Category selection text
            const SizedBox(height: 10),

// Dropdown to select a category
            Center(
                child: SizedBox(
                    width: 500,
                    child: DropdownButtonFormField(
                      value: dropdownValue,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      items: categories.map((String category) {
                        return DropdownMenuItem(
                            value: category,
                            child: Text(category,
                                style: const TextStyle(fontSize: 18)));
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!; // Update selected category
                        });
                      },
                    ))),

            const SizedBox(height: 20),

            SizedBox(
              width: 500,
              child: GestureDetector(
                onTap: navigateToQuoteDetails, // Navigate to details on tap
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    displayedQuote!.text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Button to generate a new quote
            ElevatedButton(
              onPressed: generateQuote,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 18, color: Colors.black),
              ),
              child: const Text(
                "Generate",
                style: TextStyle(fontSize: 22, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
