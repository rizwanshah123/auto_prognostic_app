from flask import Flask, render_template, jsonify
from obd_reader import OBDReader
from model import PredictiveModel
import numpy as np
import pandas as pd
app = Flask(__name__)
app.config['SECRET_KEY'] = 'your_secret_key'
obd_reader = OBDReader()
dataset = pd.read_csv('engine_data_filtered.csv')
background_data = dataset.iloc[:, :-1].sample(n=100, random_state=42).values
predictive_model = PredictiveModel('logistic_regression.joblib', background_data)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api/data', methods=['GET'])
def get_data():
    data = obd_reader.read_data()
    if data:
        prediction = predictive_model.predict(data)
        explanation = predictive_model.explain(data)
        prediction = prediction.item()
        explanation = explanation.tolist()

        return jsonify({
            'data': data,
            'prediction': prediction,
            'explanation': explanation
        })
    else:
        return jsonify({'error': 'Unable to read data from OBDII device'}), 500

@app.route('/api/obd/data', methods=['GET'])
def get_obd_data():
    data = obd_reader.read_data()
    print(data)
    if data:
        return jsonify({
            'data': data
        })
    else:
        return jsonify({'error': 'Unable to read data from OBDII device'}), 500
    

if __name__ == '__main__':
    app.run(host='0.0.0.0',debug=True)


