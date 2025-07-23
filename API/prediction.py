from fastapi import FastAPI
from pydantic import BaseModel
import joblib
import numpy as np

app = FastAPI(title="Bus Wait Time Predictor", description="API to predict wait times at bus stations in Rwanda")
# Load saved model and scaler
try:
    model = joblib.load("../linear_regression/random_forest_model.pkl")
    scaler = joblib.load("../linear_regression/scaler.pkl")
except Exception as e:
    print("Failed to load model or scaler:", e)
    model = None
    scaler = None
## Define input structure
class InputData(BaseModel):
    features: list   # List of features for prediction

@app.post("/predict")
def predict(data: InputData):
    try:
        # Scale the input
        scaled_input = scaler.transform([data.features])
        prediction = model.predict(scaled_input)
        return {"predicted_wait_time_minutes": round(prediction[0], 2)}
    except Exception as e:
        return {"error": str(e)}
