import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'result_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  
  // Controllers for text fields
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _bmiController = TextEditingController();
  
  // Dropdown values
  String _weightGain = '0';
  String _hairGrowth = '0';
  String _skinDarkening = '0';
  String _hairLoss = '0';
  String _pimples = '0';
  String _fastFood = '0';
  String _regularExercise = '0';
  
  bool _isLoading = false;
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple.withOpacity(0.1),
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.purple.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.health_and_safety,
                          color: Colors.purple,
                          size: 28,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PCOS Assessment',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                              ),
                            ),
                            Text(
                              'Complete the form below to get your risk assessment',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),

                  // Progress indicator
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Step ${_currentStep + 1} of 2',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.purple,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '${((_currentStep + 1) / 2 * 100).toInt()}%',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.purple,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: (_currentStep + 1) / 2,
                          backgroundColor: Colors.grey.withOpacity(0.2),
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),

                  // Form content based on current step
                  _currentStep == 0 ? _buildPersonalInfoStep() : _buildSymptomsStep(),
                  
                  SizedBox(height: 24),

                  // Navigation buttons
                  Row(
                    children: [
                      if (_currentStep > 0)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                _currentStep--;
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              side: BorderSide(color: Colors.purple),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_back, size: 20, color: Colors.purple),
                                SizedBox(width: 8),
                                Text(
                                  'Previous',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.purple,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (_currentStep > 0) SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleNextStep,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                          ),
                          child: _isLoading
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _currentStep == 0 ? 'Next' : 'Get Assessment',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(Icons.arrow_forward, size: 20),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoStep() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: Colors.purple, size: 24),
              SizedBox(width: 12),
              Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),

          // Age
          _buildInputField(
            controller: _ageController,
            label: 'Age',
            hint: 'Enter your age in years',
            icon: Icons.calendar_today,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your age';
              }
              double? age = double.tryParse(value);
              if (age == null || age < 10 || age > 80) {
                return 'Age must be between 10 and 80';
              }
              return null;
            },
          ),
          SizedBox(height: 16),

          // Weight
          _buildInputField(
            controller: _weightController,
            label: 'Weight',
            hint: 'Enter your weight in kg',
            icon: Icons.monitor_weight,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your weight';
              }
              double? weight = double.tryParse(value);
              if (weight == null || weight < 20 || weight > 200) {
                return 'Weight must be between 20 and 200 kg';
              }
              return null;
            },
          ),
          SizedBox(height: 16),

          // Height
          _buildInputField(
            controller: _heightController,
            label: 'Height',
            hint: 'Enter your height in cm',
            icon: Icons.height,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your height';
              }
              double? height = double.tryParse(value);
              if (height == null || height < 100 || height > 250) {
                return 'Height must be between 100 and 250 cm';
              }
              return null;
            },
          ),
          SizedBox(height: 16),

          // BMI
          _buildInputField(
            controller: _bmiController,
            label: 'BMI',
            hint: 'Enter your BMI',
            icon: Icons.calculate,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your BMI';
              }
              double? bmi = double.tryParse(value);
              if (bmi == null || bmi < 10 || bmi > 50) {
                return 'BMI must be between 10 and 50';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomsStep() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.medical_services, color: Colors.purple, size: 24),
              SizedBox(width: 12),
              Text(
                'Symptoms & Lifestyle',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),

          // Symptoms grid
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
            children: [
              _buildSymptomCard(
                title: 'Weight Gain',
                icon: Icons.trending_up,
                value: _weightGain,
                onChanged: (value) => setState(() => _weightGain = value!),
              ),
              _buildSymptomCard(
                title: 'Hair Growth',
                icon: Icons.content_cut,
                value: _hairGrowth,
                onChanged: (value) => setState(() => _hairGrowth = value!),
              ),
              _buildSymptomCard(
                title: 'Skin Darkening',
                icon: Icons.palette,
                value: _skinDarkening,
                onChanged: (value) => setState(() => _skinDarkening = value!),
              ),
              _buildSymptomCard(
                title: 'Hair Loss',
                icon: Icons.face,
                value: _hairLoss,
                onChanged: (value) => setState(() => _hairLoss = value!),
              ),
              _buildSymptomCard(
                title: 'Pimples',
                icon: Icons.circle,
                value: _pimples,
                onChanged: (value) => setState(() => _pimples = value!),
              ),
              _buildSymptomCard(
                title: 'Fast Food',
                icon: Icons.fastfood,
                value: _fastFood,
                onChanged: (value) => setState(() => _fastFood = value!),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Regular Exercise
          _buildDropdownField(
            title: 'Regular Exercise',
            icon: Icons.fitness_center,
            value: _regularExercise,
            onChanged: (value) => setState(() => _regularExercise = value!),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: Colors.purple.withOpacity(0.6)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.purple, width: 2),
            ),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.05),
          ),
          keyboardType: TextInputType.number,
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildSymptomCard({
    required String title,
    required IconData icon,
    required String value,
    required Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: value == '1' ? Colors.purple.withOpacity(0.1) : Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: value == '1' ? Colors.purple : Colors.grey.withOpacity(0.3),
          width: value == '1' ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: () => onChanged(value == '1' ? '0' : '1'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: value == '1' ? Colors.purple : Colors.grey,
                size: 32,
              ),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: value == '1' ? Colors.purple : Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: value == '1' ? Colors.purple : Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  value == '1' ? 'Yes' : 'No',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: value == '1' ? Colors.white : Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String title,
    required IconData icon,
    required String value,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.withOpacity(0.05),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.purple.withOpacity(0.6)),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            items: [
              DropdownMenuItem(value: '0', child: Text('No')),
              DropdownMenuItem(value: '1', child: Text('Yes')),
            ],
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  void _handleNextStep() {
    if (_currentStep == 0) {
      if (_formKey.currentState!.validate()) {
        setState(() {
          _currentStep++;
        });
      }
    } else {
      _predictPCOS();
    }
  }

  Future<void> _predictPCOS() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Show initial loading message
    _showLoadingMessage('Preparing your assessment...');

    try {
      // First, try to wake up the server with a simple GET request
      try {
        await http.get(
          Uri.parse('https://polycystic-ovary-syndrome-prediction-api.onrender.com/'),
          headers: {'Content-Type': 'application/json'},
        ).timeout(Duration(seconds: 10));
      } catch (e) {
        // Server might be sleeping, continue anyway
      }

      _showLoadingMessage('Analyzing your data...');

      final response = await http.post(
        Uri.parse('https://polycystic-ovary-syndrome-prediction-api.onrender.com/predict'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'age': double.parse(_ageController.text),
          'weight': double.parse(_weightController.text),
          'height': double.parse(_heightController.text),
          'bmi': double.parse(_bmiController.text),
          'weight_gain': int.parse(_weightGain),
          'hair_growth': int.parse(_hairGrowth),
          'skin_darkening': int.parse(_skinDarkening),
          'hair_loss': int.parse(_hairLoss),
          'pimples': int.parse(_pimples),
          'fast_food': int.parse(_fastFood),
          'regular_exercise': int.parse(_regularExercise),
        }),
      ).timeout(Duration(seconds: 60)); // Increased timeout for Render sleep

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              prediction: data['prediction'],
              riskLevel: data['risk_level'],
            ),
          ),
        );
      } else {
        _showError('Server error: ${response.statusCode}. Please try again in a moment.');
      }
    } catch (e) {
      if (e.toString().contains('timeout')) {
        _showError('Request timed out. The server is waking up. Please try again in 30 seconds.');
      } else {
        _showError('Connection error. Please check your internet and try again.');
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showLoadingMessage(String message) {
    if (_isLoading) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              SizedBox(width: 16),
              Expanded(child: Text(message)),
            ],
          ),
          backgroundColor: Colors.purple,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}