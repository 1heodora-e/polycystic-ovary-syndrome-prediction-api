import joblib
import numpy as np

# Load the trained model and scaler
model = joblib.load('best_pcos_model_simple.pkl')
scaler = joblib.load('scaler_simple.pkl')

def predict_pcos_simple(input_features):
    """
    Predict PCOS using simplified model (for mobile app)
    
    input_features: list of 11 values in order:
    [Age, Weight, Height, BMI, Weight_gain, Hair_growth, Skin_darkening, 
     Hair_loss, Pimples, Fast_food, Regular_exercise]
    
    Returns: predicted value (float, between 0 and 1)
    """
    # Ensure input is a 2D array
    input_scaled = scaler.transform([input_features])
    prediction = model.predict(input_scaled)[0]
    return prediction

# Example usage and testing
if __name__ == "__main__":
    # Example input (replace with real values from your dataset)
    sample_input = [28, 44.6, 152.0, 19.3, 0, 0, 0, 0, 0, 1, 0]  # Example values
    result = predict_pcos_simple(sample_input)
    print("Predicted PCOS (Y/N):", result)