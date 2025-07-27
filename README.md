## Bus Wait Time Prediction using Machine Learning (Rwanda)


This project predicts the expected **bus wait time (in minutes)** at different bus stations in Rwanda based on time of day, location, and passenger conditions. The model is built using **Linear Regression**, **Decision Tree**, and **Random Forest**, and the best model is deployed via a **FastAPI** API.

##  Project Structure
   ML_Summative/
   ├── linear_regression/
   │ ├── bus_wait_prediction.ipynb <= Jupyter notebook with EDA + modeling
   ├── API/
   │ ├── prediction.py <= FastAPI 
   ├── scaler.pkl <= Trained scaler
   │ ├── random_forest_model.pkl <= Best-performing model
   ├── requirements.txt
   └── bus_wait_time <= flutter app  
   ├── README.md
   └── .gitignore



## Model Building (Notebook)
1. Loaded and explored the data
2. Visualized patterns 
3. Trained 3 models:
   - **Linear Regression**
   - **Decision Tree Regressor**
   - **Random Forest Regressor**
4. Evaluated performance using **RMSE (Root Mean Squared Error)**

## Model Results:
| Model                | RMSE   |
|----------------------|--------|
| Linear Regression    | 2.71   |
| Decision Tree        | 1.88   |
| Random Forest        | 1.71   |
**Conclusion**: Random Forest performed the best and was saved as the final model for deployment.

## API Deployment (FastAPI)
The prediction API is built with **FastAPI** and can be used to predict wait time based on 32 input features and it's hosted on render.
- Render Response screenshot (render-response.PNG)
- Live API URL: https://bus-wait-time-api.onrender.com/docs

- Sample input: {
  "features": [0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 2.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 2.3, 0.0, 1.0, 0.0]
}
- Swagger Prediction successful response Screenshot (swagger_response.PNG)


## How to Run the App

- **Requirements** : Flutter SDK and VS code or Android Studio
- Clone the repo
- Open the terminal and navigate to the flutter project folder (bus_wait_time)
- Get dependencies and launch the emulator
- Start the app by running: **flutter run** in your terminal (This will build and launch the app on the emulator)

## Demo link
- https://youtu.be/g_CbDmSZuOA

## Tools/Libraries Used
- Vs code
- Checkout: (API/requirements.txt) for a full list of all libraries used in the project.

## Mission Statement

This project aims to address the unpredictability of bus wait times in Rwanda's public transport system. As a regular commuter, I identified long, uncertain wait times at bus stations as a recurring problem. Using machine learning, I built a model that predicts expected wait times based on various station and time-related factors. The solution is context-specific and tailored to reflect realistic transport conditions in Rwanda. My mission is to apply data-driven methods to improve daily commuting experiences in local communities.


## Dataset Acknowledgement
  
  The dataset was **simulated based on personal experience** using public transport in Rwanda.  
As a commuter, I noticed long, unpredictable wait times at bus stations — which inspired this idea for my **capstone project**.
The **simulated dataset** includes:

- Time of day (hour:minute)
- Weather and station conditions
- City/station name (e.g. Nyanza, Gatenga, Nyamirambo, Kagugu)
- Number of people at station
- Day of week
- Target: `expected_wait_time_min`

This dataset was tailored to reflect realistic bus station conditions in Rwanda, based of my experience.
