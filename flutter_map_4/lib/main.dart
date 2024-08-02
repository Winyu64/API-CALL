import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'แอปพยากรณ์อากาศ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CityListScreen(),
    );
  }
}

class CityListScreen extends StatefulWidget {
  const CityListScreen({super.key});

  @override
  _CityListScreenState createState() => _CityListScreenState();
}

class _CityListScreenState extends State<CityListScreen> {
  final List<String> cities = [
    'กระบี่', 'กาญจนบุรี', 'กาฬสินธุ์', 'กำแพงเพชร', 'ขอนแก่น',
      'จันทบุรี', 'ฉะเชิงเทรา', 'ชลบุรี', 'ชัยนาท', 'ชัยภูมิ',
      'ชุมพร', 'เชียงราย', 'เชียงใหม่', 'ตรัง', 'ตราด',
      'ตาก', 'นครนายก', 'นครปฐม', 'นครพนม', 'นครราชสีมา',
      'นครศรีธรรมราช', 'นครสวรรค์', 'นนทบุรี', 'นราธิวาส', 'น่าน',
      'บึงกาฬ', 'บุรีรัมย์', 'ปทุมธานี', 'ประจวบคีรีขันธ์', 'ปราจีนบุรี',
      'ปัตตานี', 'พระนครศรีอยุธยา', 'พังงา', 'พัทลุง', 'พิจิตร',
      'พิษณุโลก', 'เพชรบุรี', 'เพชรบูรณ์', 'แพร่', 'พะเยา',
      'ภูเก็ต', 'มหาสารคาม', 'มุกดาหาร', 'แม่ฮ่องสอน', 'ยโสธร',
      'ยะลา', 'ร้อยเอ็ด', 'ระนอง', 'ระยอง', 'ราชบุรี',
      'ลพบุรี', 'ลำปาง', 'ลำพูน', 'เลย', 'ศรีสะเกษ',
      'สกลนคร', 'สงขลา', 'สตูล', 'สมุทรปราการ', 'สมุทรสงคราม',
      'สมุทรสาคร', 'สระแก้ว', 'สระบุรี', 'สิงห์บุรี', 'สุโขทัย',
      'สุพรรณบุรี', 'สุราษฎร์ธานี', 'สุรินทร์', 'หนองคาย', 'หนองบัวลำภู',
      'อ่างทอง', 'อำนาจเจริญ', 'อุดรธานี', 'อุตรดิตถ์', 'อุทัยธานี', 'อุบลราชธานี'
  ];

  String? selectedCity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'แอปพยากรณ์อากาศ',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Cloud3D.gif'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ยินดีต้อนรับสู่แอปพยากรณ์อากาศ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'เลือกเมืองที่คุณต้องการดูสภาพอากาศจากรายการด้านล่าง:',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButton<String>(
                        value: selectedCity,
                        hint: Text('เลือกเมือง'),
                        isExpanded: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCity = newValue;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WeatherDetailScreen(city: selectedCity!),
                              ),
                            );
                          });
                        },
                        items: cities.map((city) {
                          return DropdownMenuItem<String>(
                            value: city,
                            child: Text(city),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherDetailScreen extends StatefulWidget {
  final String city;
  const WeatherDetailScreen({super.key, required this.city});

  @override
  State<WeatherDetailScreen> createState() => _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends State<WeatherDetailScreen> {
  Map<String, dynamic>? weatherData;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchWeatherData(widget.city);
  }

  Future<void> fetchWeatherData(String cityName) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=aee42cb84385ba435fe5715fd08b8aad'));

    if (response.statusCode == 200) {
      setState(() {
        weatherData = jsonDecode(response.body);
        errorMessage = null;
      });
    } else {
      setState(() {
        weatherData = null;
        errorMessage = 'ไม่สามารถดึงข้อมูลอากาศสำหรับ "$cityName"';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String? weatherImage;
    if (weatherData != null) {
      final weatherId = weatherData!['weather'][0]['id'];
      if (weatherId >= 200 && weatherId < 300) {
        weatherImage = 'assets/images/thunderstorm.gif';
      } else if (weatherId >= 300 && weatherId < 400) {
        weatherImage = 'assets/images/drizzle.gif';
      } else if (weatherId >= 500 && weatherId < 600) {
        weatherImage = 'assets/images/rain.gif';
      } else if (weatherId >= 600 && weatherId < 700) {
        weatherImage = 'assets/images/snow.gif';
      } else if (weatherId >= 700 && weatherId < 800) {
        weatherImage = 'assets/images/atmosphere.gif';
      } else if (weatherId == 800) {
        weatherImage = 'assets/images/clear.gif';
      } else if (weatherId > 800) {
        weatherImage = 'assets/images/clouds.gif';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.city,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: weatherData != null
          ? Stack(
              children: [
                // ใช้ภาพ GIF จาก assets เป็นพื้นหลัง
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/Cloud3D.gif',
                    fit: BoxFit.cover,
                  ),
                ),
                // เนื้อหาหลัก
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // รูปภาพสภาพอากาศ
                      Expanded(
                        flex: 1,
                        child: Image.asset(
                          weatherImage ?? 'assets/images/clear.gif',
                          fit: BoxFit.cover,
                        ),
                      ),
                      // ข้อมูลสภาพอากาศ
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'อุณหภูมิปัจจุบัน: ${(weatherData!['main']['temp'] - 273.15).toStringAsFixed(2)} °C',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'อุณหภูมิต่ำสุด: ${(weatherData!['main']['temp_min'] - 273.15).toStringAsFixed(2)} °C',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'อุณหภูมิสูงสุด: ${(weatherData!['main']['temp_max'] - 273.15).toStringAsFixed(2)} °C',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'ความกดอากาศ: ${weatherData!['main']['pressure']} hPa',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'ความชื้น: ${weatherData!['main']['humidity']}%',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'ระดับน้ำทะเล: ${weatherData!['main']['sea_level']} hPa',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'ร้อยละของเมฆ: ${weatherData!['clouds']['all']}%',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'ปริมาณฝน 1 ชั่วโมงล่าสุด: ${weatherData!['rain']?['1h'] ?? 'ไม่มีข้อมูล'} mm',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'เวลาพระอาทิตย์ตก: ${DateTime.fromMillisecondsSinceEpoch(weatherData!['sys']['sunset'] * 1000).toLocal().toString()}',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Center(
              child: errorMessage != null
                  ? Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    )
                  : const CircularProgressIndicator(),
            ),
    );
  }
}
