import joblib
import numpy as np
import shap

class PredictiveModel:
    def __init__(self, model_path, background_data):
        self.model = joblib.load(model_path)
        self.background_data = background_data
        self.explainer = shap.Explainer(self.model.predict, self.background_data)

    def predict(self, data):
        input_data = np.array([data['Engine RPM'], data['Lub Oil Pressure'], data['Fuel Pressure'], 
                               data['Coolant Pressure'], data['Lub Oil Temp'], data['Coolant Temp']]).reshape(1, -1)
        prediction = self.model.predict(input_data)
        return prediction[0]

    def explain(self, data):
        input_data = np.array([data['Engine RPM'], data['Lub Oil Pressure'], data['Fuel Pressure'], 
                               data['Coolant Pressure'], data['Lub Oil Temp'], data['Coolant Temp']]).reshape(1, -1)
        shap_values = self.explainer(input_data)
        formatted_values = [f"{value:.8f}" for value in shap_values.values[0]]
        print("Formatted SHAP Values:", formatted_values)
        return shap_values.values[0]