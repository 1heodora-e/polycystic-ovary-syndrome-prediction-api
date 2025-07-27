import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final double prediction;
  final String riskLevel;

  ResultScreen({required this.prediction, required this.riskLevel});

  @override
  Widget build(BuildContext context) {
    Color riskColor;
    String riskMessage;
    String riskDescription;
    IconData riskIcon;

    switch (riskLevel.toLowerCase()) {
      case 'low':
        riskColor = Color(0xFF4CAF50);
        riskMessage = 'Low Risk';
        riskDescription = 'Your symptoms suggest a low likelihood of PCOS. Continue monitoring your health and maintain a healthy lifestyle.';
        riskIcon = Icons.check_circle;
        break;
      case 'medium':
        riskColor = Color(0xFFFF9800);
        riskMessage = 'Medium Risk';
        riskDescription = 'You show some symptoms that may indicate PCOS. Consider consulting a healthcare provider for further evaluation.';
        riskIcon = Icons.warning;
        break;
      case 'high':
        riskColor = Color(0xFFF44336);
        riskMessage = 'High Risk';
        riskDescription = 'Your symptoms strongly suggest PCOS. Please consult a healthcare provider for proper diagnosis and treatment.';
        riskIcon = Icons.error;
        break;
      default:
        riskColor = Colors.grey;
        riskMessage = 'Unknown Risk';
        riskDescription = 'Unable to determine risk level. Please try again or consult a healthcare provider.';
        riskIcon = Icons.help;
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              riskColor.withOpacity(0.1),
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Header with back button
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.purple),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Your Results',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),

                // Main result card
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: riskColor.withOpacity(0.2),
                        blurRadius: 20,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        // Risk level indicator
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: riskColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            riskIcon,
                            size: 60,
                            color: riskColor,
                          ),
                        ),
                        SizedBox(height: 24),

                        // Risk level text
                        Text(
                          riskMessage,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: riskColor,
                          ),
                        ),
                        SizedBox(height: 8),

                        // Percentage display
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: riskColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: riskColor.withOpacity(0.3)),
                          ),
                          child: Text(
                            '${(prediction * 100).toStringAsFixed(1)}%',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: riskColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 24),

                        // Progress bar
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: prediction,
                            child: Container(
                              decoration: BoxDecoration(
                                color: riskColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),

                        // Description
                        Text(
                          riskDescription,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),

                // Action buttons
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.refresh, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'New Assessment',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Medical disclaimer
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.medical_services,
                        color: Colors.blue,
                        size: 24,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'This is a screening tool only. Always consult a healthcare provider for proper diagnosis.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}