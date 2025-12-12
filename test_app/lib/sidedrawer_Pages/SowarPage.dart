import 'package:flutter/material.dart';

class SowarPage extends StatefulWidget {
  const SowarPage({super.key});

  @override
  State<SowarPage> createState() => _SowarPageState();
}

class _SowarPageState extends State<SowarPage> {
  // List of all 114 Quranic surahs in order
  final List<String> _surahNames = [
    'الفاتحة',
    'البقرة',
    'آل عمران',
    'النساء',
    'المائدة',
    'الأنعام',
    'الأعراف',
    'الأنفال',
    'التوبة',
    'يونس',
    'هود',
    'يوسف',
    'الرعد',
    'إبراهيم',
    'الحجر',
    'النحل',
    'الإسراء',
    'الكهف',
    'مريم',
    'طه',
    'الأنبياء',
    'الحج',
    'المؤمنون',
    'النور',
    'الفرقان',
    'الشعراء',
    'النمل',
    'القصص',
    'العنكبوت',
    'الروم',
    'لقمان',
    'السجدة',
    'الأحزاب',
    'سبأ',
    'فاطر',
    'يس',
    'الصافات',
    'ص',
    'الزمر',
    'غافر',
    'فصلت',
    'الشورى',
    'الزخرف',
    'الدخان',
    'الجاثية',
    'الأحقاف',
    'محمد',
    'الفتح',
    'الحجرات',
    'ق',
    'الذاريات',
    'الطور',
    'النجم',
    'القمر',
    'الرحمن',
    'الواقعة',
    'الحديد',
    'المجادلة',
    'الحشر',
    'الممتحنة',
    'الصف',
    'الجمعة',
    'المنافقون',
    'التغابن',
    'الطلاق',
    'التحريم',
    'الملك',
    'القلم',
    'الحاقة',
    'المعارج',
    'نوح',
    'الجن',
    'المزمل',
    'المدثر',
    'القيامة',
    'الإنسان',
    'المرسلات',
    'النبأ',
    'النازعات',
    'عبس',
    'التكوير',
    'الانفطار',
    'المطففين',
    'الانشقاق',
    'البروج',
    'الطارق',
    'الأعلى',
    'الغاشية',
    'الفجر',
    'البلد',
    'الشمس',
    'الليل',
    'الضحى',
    'الشرح',
    'التين',
    'العلق',
    'القدر',
    'البينة',
    'الزلزلة',
    'العاديات',
    'القارعة',
    'التكاثر',
    'العصر',
    'الهمزة',
    'الفيل',
    'قريش',
    'الماعون',
    'الكوثر',
    'الكافرون',
    'النصر',
    'المسد',
    'الإخلاص',
    'الفلق',
    'الناس',
  ];

  // Search functionality
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredSurahs = [];

  @override
  void initState() {
    super.initState();
    _filteredSurahs = List.from(_surahNames);
  }

  void _filterSurahs(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredSurahs = List.from(_surahNames);
      } else {
        _filteredSurahs =
            _surahNames.where((surah) => surah.contains(query)).toList();
      }
    });
  }

  void _navigateToSurahDetails(String surahName) {
    // You can navigate to a surah details page
    // Navigator.push(context, MaterialPageRoute(
    //   builder: (context) => SurahDetailsPage(surahName: surahName),
    // ));

    // For now, show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('سورة $surahName'),
        duration: const Duration(seconds: 1),
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
            "سور القرآن الكريم",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {
              showSearch(
                context: context,
                delegate:
                    SurahSearchDelegate(_surahNames, _navigateToSurahDetails),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Enhanced Arabic Search Bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterSurahs,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl, // Force RTL for Arabic
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              style: const TextStyle(
                fontSize: 18,
                height: 1.5, // Better line height for Arabic
              ),
              decoration: InputDecoration(
                hintText: 'ابحث عن سورة...',
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
                          _filterSurahs('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 237, 246, 237), width: 2),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              cursorColor: const Color.fromARGB(255, 219, 226, 219),
              autofocus: false,
              // Enable Arabic text suggestions
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
                  'عدد السور: ${_filteredSurahs.length}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  'السورة',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          // Surah List
          Expanded(
            child: ListView.builder(
              itemCount: _filteredSurahs.length,
              itemBuilder: (context, index) {
                final surahName = _filteredSurahs[index];
                final surahNumber = _surahNames.indexOf(surahName) + 1;

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 249, 251, 249),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color.fromARGB(255, 126, 140, 126),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '$surahNumber',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 126, 140, 126),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      surahName,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.grey.shade400,
                      size: 16,
                      textDirection: TextDirection.ltr,
                    ),
                    onTap: () => _navigateToSurahDetails(surahName),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // Bottom Navigation Info
      bottomNavigationBar: Container(
        height: 40,
        color: Colors.grey.shade100,
        child: const Center(
          child: Text(
            '١١٤ سورة', // Fixed number from 144 to 114
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Search Delegate for better search experience
class SurahSearchDelegate extends SearchDelegate<String> {
  final List<String> surahs;
  final Function(String) onSurahSelected;

  SurahSearchDelegate(this.surahs, this.onSurahSelected);

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
    final results = surahs.where((surah) => surah.contains(query)).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final surahName = results[index];
        return ListTile(
          title: Text(
            surahName,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 18),
          ),
          onTap: () {
            onSurahSelected(surahName);
            close(context, surahName);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? surahs.take(10).toList()
        : surahs.where((surah) => surah.contains(query)).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final surahName = suggestions[index];
        return ListTile(
          title: Text(
            surahName,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 18),
          ),
          onTap: () {
            onSurahSelected(surahName);
            close(context, surahName);
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
