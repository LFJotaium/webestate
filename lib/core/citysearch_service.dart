import 'package:flutter/cupertino.dart';
import 'package:string_similarity/string_similarity.dart';
enum AppLanguage { arabic, hebrew, english }
List<Map<String, String>> cities = [
  {"arabic": "تل أبيب", "hebrew": "תל אביב", "english": "Tel Aviv"},
  {"arabic": "حيفا", "hebrew": "חיפה", "english": "Haifa"},
  {"arabic": "ريشون لتسيون", "hebrew": "ראשון לציון", "english": "Rishon LeZiyyon"},
  {"arabic": "نتانيا", "hebrew": "נתניה", "english": "Netanya"},
  {"arabic": "أشدود", "hebrew": "אשדוד", "english": "Ashdod"},
  {"arabic": "بتاح تكفا", "hebrew": "פתח תקווה", "english": "Petah Tikva"},
  {"arabic": "بئر السبع", "hebrew": "באר שבע", "english": "Beersheba"},
  {"arabic": "الرملة", "hebrew": "רמלה", "english": "Ramla"},
  {"arabic": "الناصرة", "hebrew": "נצרת", "english": "Nazareth"},
  {"arabic": "بني براك", "hebrew": "בני ברק", "english": "Bnei Brak"},
  {"arabic": "رمات غان", "hebrew": "רמת גן", "english": "Ramat Gan"},
  {"arabic": "حولون", "hebrew": "חולון", "english": "Holon"},
  {"arabic": "إيلات", "hebrew": "אילת", "english": "Eilat"},
  {"arabic": "بات يام", "hebrew": "בת ים", "english": "Bat Yam"},
  {"arabic": "عسقلان", "hebrew": "אשקלון", "english": "Ashqelon"},
  {"arabic": "طبريا", "hebrew": "טבריה", "english": "Tiberias"},
  {"arabic": "رحوفوت", "hebrew": "רחובות", "english": "Rehovot"},
  {"arabic": "اللد", "hebrew": "לוד", "english": "Lod"},
  {"arabic": "كفار سابا", "hebrew": "כפר סבא", "english": "Kfar Saba"},
  {"arabic": "هرتسليا", "hebrew": "הרצליה", "english": "Herzliya"},
  {"arabic": "الخضيرة", "hebrew": "חדרה", "english": "Hadera"},
  {"arabic": "جفعاتايم", "hebrew": "גבעתיים", "english": "Giv'atayim"},
  {"arabic": "الطيبة", "hebrew": "טייבה", "english": "Eṭ Ṭaiyiba"},
  {"arabic": "ديمونا", "hebrew": "דימונה", "english": "Dimona"},
  {"arabic": "عكا", "hebrew": "עכו", "english": "Acre"},
  {"arabic": "يافني", "hebrew": "יבנה", "english": "Yavné"},
  {"arabic": "أم الفحم", "hebrew": "אום אל-פחם", "english": "Umm el Faḥm"},
  {"arabic": "رمات هاشارون", "hebrew": "רמת השרון", "english": "Ramat HaSharon"},
  {"arabic": "رعنانا", "hebrew": "רעננה", "english": "Raanana"},
  {"arabic": "كريات جات", "hebrew": "קריית גת", "english": "Kiryat Gat"},
  {"arabic": "كريات آتا", "hebrew": "קריית אתא", "english": "Kiryat Ata"},
  {"arabic": "أور يهودا", "hebrew": "אור יהודה", "english": "Or Yehuda"},
  {"arabic": "نس تسيونا", "hebrew": "נס ציונה", "english": "Ness Ziona"},
  {"arabic": "نهارييا", "hebrew": "נהריה", "english": "Nahariya"},
  {"arabic": "هود هشارون", "hebrew": "הוד השרון", "english": "Hod HaSharon"},
  {"arabic": "رهط", "hebrew": "רהט", "english": "Rahat"},
  {"arabic": "زخرون يعقوف", "hebrew": "זכרון יעקב", "english": "Zikhron Ya'aqov"},
  {"arabic": "يركا", "hebrew": "ירכא", "english": "Yirkā"},
  {"arabic": "يهود", "hebrew": "יהוד", "english": "Yehud"},
  {"arabic": "طيرة", "hebrew": "טירה", "english": "Tirah"},
  {"arabic": "الفريديس", "hebrew": "פוריידיס", "english": "El Fureidīs"},
  {"arabic": "دالية الكرمل", "hebrew": "דלית אל-כרמל", "english": "Daliyat al Karmel"},
  {"arabic": "بنيامينا", "hebrew": "בנימינה", "english": "Binyamina"},
  {"arabic": "بيت شان", "hebrew": "בית שאן", "english": "Bet Shean"},
  {"arabic": "باقة الغربية", "hebrew": "באקה אל-גרבייה", "english": "Baqa al-Gharbiyye"},
  {"arabic": "عراد", "hebrew": "ערד", "english": "Arad"},
  {"arabic": "العفولة", "hebrew": "עפולה", "english": "Afula"},
  {"arabic": "أبو غوش", "hebrew": "אבו גוש", "english": "Abu Ghosh"},
  {"arabic": "طيرة الكرمل", "hebrew": "טירת כרמל", "english": "Tirat Carmel"},
  {"arabic": "معالوت ترشيحا", "hebrew": "מעלות-תרשיחא", "english": "Ma'alot-Tarshiha"},
  {"arabic": "طمرة", "hebrew": "טמרה", "english": "Tamra"},
  {"arabic": "شفا عمرو", "hebrew": "שפרעם", "english": "Shefa-'Amr"},
  {"arabic": "سديروت", "hebrew": "שדרות", "english": "Sderot"},
  {"arabic": "سخنين", "hebrew": "סחנין", "english": "Sakhnin"},
  {"arabic": "روش هعاين", "hebrew": "ראש העין", "english": "Rosh HaAyin"},
  {"arabic": "كريات يام", "hebrew": "קריית ים", "english": "Qiryat Yam"},
  {"arabic": "كريات شمونة", "hebrew": "קריית שמונה", "english": "Kiryat Shmona"},
  {"arabic": "كريات موتسكين", "hebrew": "קריית מוצקין", "english": "Kiryat Motzkin"},
  {"arabic": "كريات ملاخي", "hebrew": "קריית מלאכי", "english": "Qiryat Mal'akhi"},
  {"arabic": "كريات بياليك", "hebrew": "קריית ביאליק", "english": "Kiryat Bialik"},
  {"arabic": "أوفاكيم", "hebrew": "אופקים", "english": "Ofakim"},
  {"arabic": "نتيفوت", "hebrew": "נתיבות", "english": "Netivot"},
  {"arabic": "نشر", "hebrew": "נשר", "english": "Nesher"},
  {"arabic": "مجدال هعيمق", "hebrew": "מגדל העמק", "english": "Migdal HaEmeq"},
  {"arabic": "مجد الكروم", "hebrew": "מג'ד אל-כרום", "english": "Majd el Kurūm"},
  {"arabic": "مغار", "hebrew": "מג'אר", "english": "Maghār"},
  {"arabic": "كرميئيل", "hebrew": "כרמיאל", "english": "Karmiel"},
  {"arabic": "كفر قاسم", "hebrew": "כפר קאסם", "english": "Kafr Qāsim"},
  {"arabic": "جلجولية", "hebrew": "גלג'וליה", "english": "Jaljulia"},
  {"arabic": "عسفيا", "hebrew": "עספיא", "english": "'Isfiyā"},
  {"arabic": "جفعات شموئيل", "hebrew": "גבעת שמואל", "english": "Giv'at Shmuel"},
  {"arabic": "يوقنعام عيليت", "hebrew": "יקנעם עילית", "english": "Yokneam Illit"},
  {"arabic": "جان يفني", "hebrew": "גן יבנה", "english": "Gan Yavne"},
  {"arabic": "جاني تيكفا", "hebrew": "גני תקווה", "english": "Ganei Tikva"},
  {"arabic": "إيفن يهودا", "hebrew": "אבן יהודה", "english": "Even Yehuda"},
  {"arabic": "الطيبة", "hebrew": "טייבה", "english": "Taiyiba"},
  {"arabic": "الرينة", "hebrew": "ריינא", "english": "Er Reina"},
  {"arabic": "عين ماهل", "hebrew": "עין מאהל", "english": "'Ein Māhil"},
  {"arabic": "عيلبون", "hebrew": "עילבון", "english": "'Eilabun"},
  {"arabic": "دير حنا", "hebrew": "דיר חנא", "english": "Deir Ḥannā"},
  {"arabic": "دير الأسد", "hebrew": "דיר אל-אסד", "english": "Deir el Asad"},
  {"arabic": "دبورية", "hebrew": "דבוריה", "english": "Daburiyya"},
  {"arabic": "بعنة", "hebrew": "ביעינה", "english": "Bi'na"},
  {"arabic": "بيت جن", "hebrew": "בית ג'ן", "english": "Beit Jann"},
  {"arabic": "بئر يعقوب", "hebrew": "באר יעקב", "english": "Be'er Ya'aqov"},
  {"arabic": "أزور", "hebrew": "אזור", "english": "Azor"},
  {"arabic": "عتليت", "hebrew": "עתלית", "english": "Atlit"},
  {"arabic": "أبو سنان", "hebrew": "אבו סנאן", "english": "Abu Snan"},
  {"arabic": "تل موند", "hebrew": "תל מונד", "english": "Tel Mond"},
  {"arabic": "رخاسيم", "hebrew": "רכסים", "english": "Rekhasim"},
  {"arabic": "رمات يشاي", "hebrew": "רמת ישי", "english": "Ramat Yishai"},
  {"arabic": "قلنسوة", "hebrew": "קלנסווה", "english": "Qalansawe"},
  {"arabic": "برديس حنا", "hebrew": "פרדס חנה-כרכור", "english": "Pardesiyya"},
  {"arabic": "أور عكيفا", "hebrew": "אור עקיבא", "english": "Or Akiva"},
  {"arabic": "عومر", "hebrew": "עומר", "english": "'Omer"},
  {"arabic": "متسبيه رامون", "hebrew": "מצפה רמון", "english": "Mitzpe Ramon"},
  {"arabic": "مفسيرت صهيون", "hebrew": "מבשרת ציון", "english": "Mevaseret Zion"},
  {"arabic": "مطولة", "hebrew": "מטולה", "english": "Metula"},
  {"arabic": "مزكيرت باتيا", "hebrew": "מזכרת בתיה", "english": "Mazkeret Batya"},
  {"arabic": "كفار يونا", "hebrew": "כפר יונה", "english": "Kfar Yona"},
  {"arabic": "كريات عكرون", "hebrew": "קריית עקרון", "english": "Kiryat Ekron"},
  {"arabic": "كفر قرع", "hebrew": "כפר קרע", "english": "Kafr Qara"},
  {"arabic": "كفر مندا", "hebrew": "כפר מנדא", "english": "Kafr Mandā"},
  {"arabic": "كفر كنا", "hebrew": "כפר כנא", "english": "Kafr Kannā"},
  {"arabic": "كفر كما", "hebrew": "כפר כמא", "english": "Kafr Kammā"},
  {"arabic": "كفر برا", "hebrew": "כפר ברא", "english": "Kafr Bara"},
  {"arabic": "كابول", "hebrew": "כבול", "english": "Kabul"},
  {"arabic": "الجديدة-مكر", "hebrew": "ג'דיידה-מכר", "english": "Judeida Makr"},
  {"arabic": "جسر الزرقاء", "hebrew": "ג'סר א-זרקא", "english": "Jisr ez Zarqā"},
  {"arabic": "جت", "hebrew": "ג'ת", "english": "Jatt"},
  {"arabic": "عيلوط", "hebrew": "עילוט", "english": "'Ilūṭ"},
  {"arabic": "إكسال", "hebrew": "אכסאל", "english": "Iksāl"},
  {"arabic": "إعبلين", "hebrew": "אעבלין", "english": "I'billīn"},
  {"arabic": "حرفيش", "hebrew": "חורפיש", "english": "Ḥurfeish"},
  {"arabic": "هاتسور هجليل", "hebrew": "חצור הגלילית", "english": "Hatzor HaGlilit"},
  {"arabic": "زرزير", "hebrew": "זרזיר", "english": "Zarzir"},
  {"arabic": "يهود-مونوسون", "hebrew": "יהוד-מונוסון", "english": "Yehud-Monosson"},
  {"arabic": "شوهام", "hebrew": "שוהם", "english": "Shoham"},
  {"arabic": "العد", "hebrew": "אלעד", "english": "El'ad"},
  {"arabic": "عرعرة النقب", "hebrew": "ערערה בנגב", "english": "'Ar'ara BaNegev"},
  {"arabic": "حورة", "hebrew": "חורה", "english": "H̱ura"},
  {"arabic": "كوسيفا", "hebrew": "כסיפה", "english": "Kuseifa"},
  {"arabic": "كوكاف يعير", "hebrew": "כוכב יאיר", "english": "Kokhav Ya'ir"},
  {"arabic": "تل السبع", "hebrew": "תל שבע", "english": "Tel Sheva'"},
  {"arabic": "بنيامينا-جفعات عدا", "hebrew": "בנימינה-גבעת עדה", "english": "Binyamina-Giv'at Ada"},
  {"arabic": "كريات أونو", "hebrew": "קריית אונו", "english": "Kiryat Ono"},
  {"arabic": "معاليه عيرون", "hebrew": "מעלה עירון", "english": "Maale Iron"},
  {"arabic": "كاديما-زوران", "hebrew": "קדימה-צורן", "english": "Kadima Zoran"},
  {"arabic": "ميتار", "hebrew": "מיתר", "english": "Meitar"},
  {"arabic": "كفار فراديم", "hebrew": "כפר ורדים", "english": "Kfar Vradim"},
  {"arabic": "لحفيم", "hebrew": "להבים", "english": "Lehavim"},
  {"arabic": "شبل-أم الغنم", "hebrew": "שבלי-אום אל-גנם", "english": "Shibli–Umm al-Ghanam"},
  {"arabic": "ينوح-جات", "hebrew": "ינוח-ג'ת", "english": "Yanuh-Jat"},
  {"arabic": "بعينة-نجيدات", "hebrew": "בועיינה-נוג'ידאת", "english": "Bu'ayna-Nujaydat"},
  {"arabic": "يوكنعام", "hebrew": "יקנעם", "english": "Yoqneam"},
  {"arabic": "كسرى-سميع", "hebrew": "כסרא-סמיע", "english": "Kisra - Sume'a"},
  {"arabic": "القدس", "hebrew": "ירושלים", "english": "jerusalem"},
];





class CityService{
  static List<String> getCityNames(AppLanguage language) {
    return cities.map((city) {
      switch (language) {
        case AppLanguage.arabic:
          return city['arabic']!;
        case AppLanguage.hebrew:
          return city['hebrew']!;
        case AppLanguage.english:
          return city['english']!;
      }
    }).toList();
  }


  String getLocalizedCity(String cityName, String code) {
    var city = cities.firstWhere(
          (city) => city["english"] == cityName || city["hebrew"] == cityName || city["arabic"] == cityName,
      orElse: () => {"english": cityName}, // Fallback to cityName if not found
    );

    switch (code) {
      case 'ar':
        return city["arabic"] ?? cityName;
      case 'he':
        return city["hebrew"] ?? cityName;
      default:
        return city["english"] ?? cityName;
    }
  }




  static List<String> getCityNamesByLocale(Locale locale) {
    return getCityNames(_getLanguageFromLocale(locale));
  }

  static String getCityName(Map<String, String> city, AppLanguage language) {
    switch (language) {
      case AppLanguage.arabic:
        return city['arabic']!;
      case AppLanguage.hebrew:
        return city['hebrew']!;
      case AppLanguage.english:
        return city['english']!;
    }
  }

  static List<String> searchCityNames(String query, AppLanguage language) {
    final cityNames = getCityNames(language);
    final results = <Map<String, dynamic>>[];

    for (final city in cityNames) {
      final similarity = query.toLowerCase().similarityTo(city.toLowerCase());
      if (similarity > 0.3) {
        results.add({'name': city, 'score': similarity});
      }
    }

    results.sort((a, b) => b['score'].compareTo(a['score']));
    return results.map((r) => r['name'] as String).toList();
  }

  static AppLanguage _getLanguageFromLocale(Locale locale) {
    final langCode = locale.languageCode.toLowerCase();
    if (langCode == 'ar') return AppLanguage.arabic;
    if (langCode == 'he' || langCode == 'iw') return AppLanguage.hebrew;
    return AppLanguage.english;
  }

  List<Map<String, dynamic>> predictCities(String input) {
    List<Map<String, dynamic>> matches = [];

    for (var city in cities) {
      double similarity = _calculateScore(input.toLowerCase(), city);

      if (similarity > 0.5) {
        matches.add({
          "english": city['english'],
          "arabic": city['arabic'],
          "hebrew": city['hebrew'],
          "similarity": similarity,
        });
      }
    }

    // Sort by similarity in descending order
    matches.sort((a, b) => b['similarity'].compareTo(a['similarity']));

    return matches;
  }

  double _calculateScore(String query, Map<String, String> city) {
    double bestScore = 0.0;

    for (String? name in city.values) {
      if (name == null) continue;  // Skip null values

      String lowerName = name.toLowerCase();

      if (lowerName == query) {
        return 1.0;
      }
      if (lowerName.startsWith(query)) {
        return 0.9;
      }

      double similarity = query.similarityTo(lowerName);
      if (similarity > bestScore) {
        bestScore = similarity;
      }
    }

    return bestScore;
  }



}







