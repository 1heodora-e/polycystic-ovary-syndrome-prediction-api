# PCOS Prediction System

## Mission and Problem

**Our mission is to democratize PCOS screening through accessible machine learning tools.** Polycystic Ovary Syndrome (PCOS) affects 1 in 10 women worldwide, often going undiagnosed due to complex symptoms and limited healthcare access. This project develops a machine learning model that analyzes health indicators and lifestyle factors to predict PCOS risk, providing both a RESTful API for healthcare applications and a mobile app for personal health monitoring to make early detection more accessible and reduce diagnostic delays.

## API Endpoint


### Public API URL
**Base URL:** `https://polycystic-ovary-syndrome-prediction-api.onrender.com`

### Swagger UI Documentation
**Interactive API Documentation:** `https://polycystic-ovary-syndrome-prediction-api.onrender.com/docs`

### Prediction Endpoint
**POST** `/predict`

**Request Body:**
```json
{
  "age": 25.0,
  "weight": 65.0,
  "height": 165.0,
  "bmi": 23.8,
  "weight_gain": 1,
  "hair_growth": 0,
  "skin_darkening": 1,
  "hair_loss": 0,
  "pimples": 1,
  "fast_food": 0,
  "regular_exercise": 1
}
```

**Response:**
```json
{
  "prediction": 0.45,
  "risk_level": "Medium"
}
```

### Test the API
1. Visit the Swagger UI at `https://polycystic-ovary-syndrome-prediction-api.onrender.com/docs`
2. Click on the `/predict` endpoint
3. Click "Try it out"
4. Enter your test data
5. Click "Execute"

**Note:** The API is deployed on Render's free plan and may take up to 45 seconds to wake up from sleep mode on the first request.

## Demo Video

**YouTube Demo Link:** [PCOS Prediction System Demo](https://youtube.com/watch?v=YOUR_VIDEO_ID)



## Mobile App Instructions

### Prerequisites
- Flutter SDK (version 3.0 or higher)
- Android Studio / VS Code
- Android Emulator or Physical Device
- Git

### Installation Steps

1. **Clone the Repository**
   ```bash
   git clone https://github.com/1heodora-e/polycystic-ovary-syndrome-prediction-api.git
   cd pcos-prediction-system
   ```

2. **Navigate to Flutter App**
   ```bash
   cd Flutter_app/pcos_prediction_app
   ```

3. **Install Dependencies**
   ```bash
   flutter pub get
   ```

4. **Run the App**
   ```bash
   # For Android Emulator
   flutter run -d emulator-5554
   
   # For Physical Device
   flutter run
   
   # For iOS Simulator (Mac only)
   flutter run -d ios
   ```

### App Features
- **Health Data Input:** Enter age, weight, height, and symptoms
- **Risk Assessment:** Get instant PCOS risk prediction
- **Health Tracking:** Monitor symptoms over time
- **Educational Content:** Learn about PCOS symptoms and management

### Troubleshooting

**If the app doesn't start:**
```bash
flutter clean
flutter pub get
flutter run
```

**If emulator issues:**
1. Open Android Studio
2. Go to AVD Manager
3. Cold boot your emulator
4. Try running again

**If API connection fails:**
1. Check your internet connection
2. Verify the API endpoint URL in the app
3. Ensure the API server is running

## Project Structure

```
PCOS projects/
├── API/                    # Backend API (FastAPI)
│   ├── main.py            # FastAPI application
│   ├── prediction.py      # ML prediction logic
│   ├── requirements.txt   # Python dependencies
│   └── *.pkl             # Trained ML models
├── Flutter_app/           # Mobile application
│   └── pcos_prediction_app/
└── Linear Regression/     # ML development notebooks
    └── pcos_analysis.ipynb
```

## Technology Stack

- **Backend:** FastAPI, Python, scikit-learn
- **Frontend:** Flutter, Dart
- **ML:** Linear Regression, Feature Scaling
- **Deployment:** [Your deployment platform]

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

