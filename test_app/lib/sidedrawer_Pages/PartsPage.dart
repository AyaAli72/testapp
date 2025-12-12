import 'package:flutter/material.dart';

class PartsPage extends StatefulWidget {
  const PartsPage({super.key});

  @override
  State<PartsPage> createState() => _PartsPageState();
}

class _PartsPageState extends State<PartsPage> {
  // Quran parts data with their surah ranges
  final List<Map<String, dynamic>> _quranParts = [
    {
      'id': 1,
      'name': 'الجزء الأول',
      'startSurah': 'الفاتحة',
      'endSurah': 'البقرة',
      'versesRange': 'من الآية 1 إلى الآية 141',
    },
    {
      'id': 2,
      'name': 'الجزء الثاني',
      'startSurah': 'البقرة',
      'endSurah': 'البقرة',
      'versesRange': 'من الآية 142 إلى الآية 252',
    },
    {
      'id': 3,
      'name': 'الجزء الثالث',
      'startSurah': 'البقرة',
      'endSurah': 'آل عمران',
      'versesRange': 'من الآية 253 إلى الآية 92',
    },
    {
      'id': 4,
      'name': 'الجزء الرابع',
      'startSurah': 'آل عمران',
      'endSurah': 'النساء',
      'versesRange': 'من الآية 93 إلى الآية 23',
    },
    {
      'id': 5,
      'name': 'الجزء الخامس',
      'startSurah': 'النساء',
      'endSurah': 'النساء',
      'versesRange': 'من الآية 24 إلى الآية 147',
    },
    {
      'id': 6,
      'name': 'الجزء السادس',
      'startSurah': 'النساء',
      'endSurah': 'المائدة',
      'versesRange': 'من الآية 148 إلى الآية 81',
    },
    {
      'id': 7,
      'name': 'الجزء السابع',
      'startSurah': 'المائدة',
      'endSurah': 'الأنعام',
      'versesRange': 'من الآية 82 إلى الآية 110',
    },
    {
      'id': 8,
      'name': 'الجزء الثامن',
      'startSurah': 'الأنعام',
      'endSurah': 'الأعراف',
      'versesRange': 'من الآية 111 إلى الآية 87',
    },
    {
      'id': 9,
      'name': 'الجزء التاسع',
      'startSurah': 'الأعراف',
      'endSurah': 'الأنفال',
      'versesRange': 'من الآية 88 إلى الآية 40',
    },
    {
      'id': 10,
      'name': 'الجزء العاشر',
      'startSurah': 'الأنفال',
      'endSurah': 'التوبة',
      'versesRange': 'من الآية 41 إلى الآية 92',
    },
    {
      'id': 11,
      'name': 'الجزء الحادي عشر',
      'startSurah': 'التوبة',
      'endSurah': 'هود',
      'versesRange': 'من الآية 93 إلى الآية 5',
    },
    {
      'id': 12,
      'name': 'الجزء الثاني عشر',
      'startSurah': 'هود',
      'endSurah': 'يوسف',
      'versesRange': 'من الآية 6 إلى الآية 52',
    },
    {
      'id': 13,
      'name': 'الجزء الثالث عشر',
      'startSurah': 'يوسف',
      'endSurah': 'إبراهيم',
      'versesRange': 'من الآية 53 إلى الآية 52',
    },
    {
      'id': 14,
      'name': 'الجزء الرابع عشر',
      'startSurah': 'الحجر',
      'endSurah': 'النحل',
      'versesRange': 'من الآية 1 إلى الآية 128',
    },
    {
      'id': 15,
      'name': 'الجزء الخامس عشر',
      'startSurah': 'الإسراء',
      'endSurah': 'الكهف',
      'versesRange': 'من الآية 1 إلى الآية 74',
    },
    {
      'id': 16,
      'name': 'الجزء السادس عشر',
      'startSurah': 'الكهف',
      'endSurah': 'طه',
      'versesRange': 'من الآية 75 إلى الآية 135',
    },
    {
      'id': 17,
      'name': 'الجزء السابع عشر',
      'startSurah': 'الأنبياء',
      'endSurah': 'الحج',
      'versesRange': 'من الآية 1 إلى الآية 78',
    },
    {
      'id': 18,
      'name': 'الجزء الثامن عشر',
      'startSurah': 'المؤمنون',
      'endSurah': 'الفرقان',
      'versesRange': 'من الآية 1 إلى الآية 20',
    },
    {
      'id': 19,
      'name': 'الجزء التاسع عشر',
      'startSurah': 'الفرقان',
      'endSurah': 'النمل',
      'versesRange': 'من الآية 21 إلى الآية 55',
    },
    {
      'id': 20,
      'name': 'الجزء العشرون',
      'startSurah': 'النمل',
      'endSurah': 'العنكبوت',
      'versesRange': 'من الآية 56 إلى الآية 45',
    },
    {
      'id': 21,
      'name': 'الجزء الحادي والعشرون',
      'startSurah': 'العنكبوت',
      'endSurah': 'الأحزاب',
      'versesRange': 'من الآية 46 إلى الآية 30',
    },
    {
      'id': 22,
      'name': 'الجزء الثاني والعشرون',
      'startSurah': 'الأحزاب',
      'endSurah': 'يس',
      'versesRange': 'من الآية 31 إلى الآية 27',
    },
    {
      'id': 23,
      'name': 'الجزء الثالث والعشرون',
      'startSurah': 'يس',
      'endSurah': 'الزمر',
      'versesRange': 'من الآية 28 إلى الآية 31',
    },
    {
      'id': 24,
      'name': 'الجزء الرابع والعشرون',
      'startSurah': 'الزمر',
      'endSurah': 'فصلت',
      'versesRange': 'من الآية 32 إلى الآية 46',
    },
    {
      'id': 25,
      'name': 'الجزء الخامس والعشرون',
      'startSurah': 'فصلت',
      'endSurah': 'الجاثية',
      'versesRange': 'من الآية 47 إلى الآية 37',
    },
    {
      'id': 26,
      'name': 'الجزء السادس والعشرون',
      'startSurah': 'الأحقاف',
      'endSurah': 'الذاريات',
      'versesRange': 'من الآية 1 إلى الآية 30',
    },
    {
      'id': 27,
      'name': 'الجزء السابع والعشرون',
      'startSurah': 'الذاريات',
      'endSurah': 'الحديد',
      'versesRange': 'من الآية 31 إلى الآية 29',
    },
    {
      'id': 28,
      'name': 'الجزء الثامن والعشرون',
      'startSurah': 'المجادلة',
      'endSurah': 'التحريم',
      'versesRange': 'من الآية 1 إلى الآية 12',
    },
    {
      'id': 29,
      'name': 'الجزء التاسع والعشرون',
      'startSurah': 'الملك',
      'endSurah': 'المرسلات',
      'versesRange': 'من الآية 1 إلى الآية 50',
    },
    {
      'id': 30,
      'name': 'الجزء الثلاثون',
      'startSurah': 'النبأ',
      'endSurah': 'الناس',
      'versesRange': 'من الآية 1 إلى الآية 6',
    },
  ];

  // Search functionality
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredParts = [];

  @override
  void initState() {
    super.initState();
    _filteredParts = List.from(_quranParts);
  }

  void _filterParts(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredParts = List.from(_quranParts);
      } else {
        _filteredParts = _quranParts
            .where((part) =>
                part['name'].contains(query) ||
                part['startSurah'].contains(query) ||
                part['endSurah'].contains(query))
            .toList();
      }
    });
  }

  void _navigateToPartDetails(Map<String, dynamic> part) {
    // You can navigate to a part details page
    // Navigator.push(context, MaterialPageRoute(
    //   builder: (context) => PartDetailsPage(part: part),
    // ));

    // For now, show a dialog with details
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          part['name'],
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 186, 198, 186),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildDetailRow('بداية الجزء:', part['startSurah']),
            _buildDetailRow('نهاية الجزء:', part['endSurah']),
            _buildDetailRow('نطاق الآيات:', part['versesRange']),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 77, 83, 78),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigate to PDF/reading page
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 193, 207, 194),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'قراءة',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Text(
                    'الجزء ${part['id']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 190, 201, 190),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: const Color.fromARGB(255, 248, 237, 237),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey.shade300,
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 6),
          child: Text(
            "أجزاء القرآن الكريم",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search,
                color: Color.fromARGB(221, 133, 129, 129)),
            onPressed: () {
              showSearch(
                context: context,
                delegate:
                    PartsSearchDelegate(_quranParts, _navigateToPartDetails),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterParts,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              style: const TextStyle(
                fontSize: 18,
                height: 1.5,
              ),
              decoration: InputDecoration(
                hintText: 'ابحث عن جزء...',
                hintStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _searchController.clear();
                          _filterParts('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: const Color.fromARGB(255, 142, 135, 135)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 19, 19, 19), width: 2),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              cursorColor: Color.fromARGB(255, 217, 221, 217),
              autofocus: false,
              enableSuggestions: true,
              autocorrect: true,
            ),
          ),

          // Counter
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'عدد الأجزاء: ${_filteredParts.length}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  'الأجزاء',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          // Parts List
          Expanded(
            child: ListView.builder(
              itemCount: _filteredParts.length,
              itemBuilder: (context, index) {
                final part = _filteredParts[index];
                final partNumber = part['id'];

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 124, 128, 124),
                            Color.fromARGB(255, 212, 221, 212),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 10, 11, 10),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '$partNumber',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 218, 227, 219),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      part['name'],
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        '${part['startSurah']} - ${part['endSurah']}',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 82, 85, 82),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${part['versesRange'].split(' ').first} آيات',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 189, 196, 190),
                        ),
                      ),
                    ),
                    onTap: () => _navigateToPartDetails(part),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // Bottom Info
      bottomNavigationBar: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 2, 3, 2),
          border: Border(top: BorderSide(color: Colors.green.shade100)),
        ),
        child: Center(
          child: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: '٣٠ ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 193, 206, 194),
                  ),
                ),
                TextSpan(
                  text: 'جزءاً',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
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

// Custom Search Delegate for Parts
class PartsSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> parts;
  final Function(Map<String, dynamic>) onPartSelected;

  PartsSearchDelegate(this.parts, this.onPartSelected);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, '');
          } else {
            query = '';
          }
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = parts
        .where((part) =>
            part['name'].contains(query) ||
            part['startSurah'].contains(query) ||
            part['endSurah'].contains(query))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final part = results[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 5, 7, 5),
            child: Text(
              '${part['id']}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 195, 208, 196),
              ),
            ),
          ),
          title: Text(
            part['name'],
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 18),
          ),
          subtitle: Text(
            '${part['startSurah']} - ${part['endSurah']}',
            textAlign: TextAlign.right,
          ),
          trailing: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey.shade400,
            size: 16,
            textDirection: TextDirection.ltr,
          ),
          onTap: () {
            onPartSelected(part);
            close(context, part['name']);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? parts.take(10).toList()
        : parts
            .where((part) =>
                part['name'].contains(query) ||
                part['startSurah'].contains(query) ||
                part['endSurah'].contains(query))
            .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final part = suggestions[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            child: Text(
              '${part['id']}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 224, 236, 224),
              ),
            ),
          ),
          title: Text(
            part['name'],
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 18),
          ),
          subtitle: Text(
            '${part['startSurah']} - ${part['endSurah']}',
            textAlign: TextAlign.right,
          ),
          onTap: () {
            onPartSelected(part);
            close(context, part['name']);
          },
        );
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 2,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.grey.shade600),
      ),
    );
  }
}
