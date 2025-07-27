from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field
from typing import List
import joblib
import numpy as np

# Load the model and scaler
model = joblib.load('best_pcos_model_simple.pkl')
scaler = joblib.load('scaler_simple.pkl')

# Create FastAPI app
app = FastAPI(title="PCOS Prediction API", description="API for Polycystic Ovary Syndrome (PCOS) prediction using machine learning")

# Define the input model with validation
class PCOSInput(BaseModel):
    age: float = Field(..., ge=10, le=80, description="Age in years")
    weight: float = Field(..., ge=20, le=200, description="Weight in kg")
    height: float = Field(..., ge=100, le=250, description="Height in cm")
    bmi: float = Field(..., ge=10, le=50, description="BMI")
    weight_gain: int = Field(..., ge=0, le=1, description="Weight gain (0=No, 1=Yes)")
    hair_growth: int = Field(..., ge=0, le=1, description="Hair growth (0=No, 1=Yes)")
    skin_darkening: int = Field(..., ge=0, le=1, description="Skin darkening (0=No, 1=Yes)")
    hair_loss: int = Field(..., ge=0, le=1, description="Hair loss (0=No, 1=Yes)")
    pimples: int = Field(..., ge=0, le=1, description="Pimples (0=No, 1=Yes)")
    fast_food: int = Field(..., ge=0, le=1, description="Fast food consumption (0=No, 1=Yes)")
    regular_exercise: int = Field(..., ge=0, le=1, description="Regular exercise (0=No, 1=Yes)")

# Define the response model
class PCOSResponse(BaseModel):
    prediction: float
    risk_level: str

@app.get("/")
def read_root():
    return {"message": "PCOS Prediction API is running!"}

@app.post("/predict", response_model=PCOSResponse)
def predict_pcos(input_data: PCOSInput):
    try:
        # Convert input to list in the correct order
        features = [
            input_data.age,
            input_data.weight,
            input_data.height,
            input_data.bmi,
            input_data.weight_gain,
            input_data.hair_growth,
            input_data.skin_darkening,
            input_data.hair_loss,
            input_data.pimples,
            input_data.fast_food,
            input_data.regular_exercise
        ]
        
        # Make prediction
        input_scaled = scaler.transform([features])
        prediction = model.predict(input_scaled)[0]
        
        # Determine risk level
        if prediction < 0.3:
            risk_level = "Low"
        elif prediction < 0.7:
            risk_level = "Medium"
        else:
            risk_level = "High"
        
        return PCOSResponse(prediction=prediction, risk_level=risk_level)
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Prediction error: {str(e)}")

# Add CORS middleware
from fastapi.middleware.cors import CORSMiddleware

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows all origins
    allow_credentials=True,
    allow_methods=["*"],  # Allows all methods
    allow_headers=["*"],  # Allows all headers
)