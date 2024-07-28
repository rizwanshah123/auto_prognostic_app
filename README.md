<h1>Automotive Prognostic Application</h1>
<p>This project is an automotive prognostic application designed to monitor and predict vehicle conditions in real time. It leverages an OBDII interface to gather data from the vehicle, processes the data through a Flask backend, and provides both real-time monitoring and predictive analysis to a mobile app.</p>

<h2>Features</h2>

<h3>Real-time Data Collection</h3>
<ul>
    <li><strong>OBDII Interface:</strong> Connects to the vehicle's OBDII port (using COM4) to collect real-time data.</li>
    <li><strong>Flask Backend:</strong> Processes the data using the OBD library to retrieve various metrics such as engine RPM, fuel pressure, coolant pressure, coolant temperature, and lubricating oil temperature.</li>
    <li><strong>API for Real-time Data:</strong> Sends all collected data directly to the mobile app for real-time display when the app is launched.</li>
</ul>

<h3>Predictive Analysis</h3>
<ul>
    <li><strong>Trained Prognostic Model:</strong> Utilizes a machine learning model trained to predict the condition of the vehicle.</li>
    <li><strong>API for Predictions:</strong> Analyzes the collected data to predict whether the car's condition is okay or not and sends this information to the mobile app.</li>
    <li><strong>Explainable AI:</strong> Provides explainable values indicating which features most impacted the model's decision, enhancing transparency and trust in the predictions.</li>
</ul>

<h2>Installation</h2>
<p><strong>Clone the Repository:</strong></p>
<pre><code>
git clone https://github.com/yourusername/automotive-prognostic-application.git
cd automotive-prognostic-application
</code></pre>

<p><strong>Set up the Flask Backend:</strong></p>
<pre><code>
pip install -r requirements.txt
</code></pre>

<p><strong>Configure the OBDII Interface:</strong></p>
<ul>
    <li>Ensure the OBDII device is connected to the vehicle and the computer through the COM4 port.</li>
</ul>

<h2>Usage</h2>
<p><strong>Start the Flask Server:</strong></p>
<pre><code>
python app.py
</code></pre>

<p><strong>Launch the Mobile App:</strong></p>
<ul>
    <li>Navigate to the <code>auto_prognostic_app</code> folder:</li>
    <pre><code>
    cd auto_prognostic_app
    </code></pre>
    <li>Install the necessary Flutter packages:</li>
    <pre><code>
    flutter pub get
    </code></pre>
    <li>Run the Flutter app on your connected device or emulator:</li>
    <pre><code>
    flutter run
    </code></pre>
</ul>

<h2>API Endpoints</h2>

<h3>Real-time Data Endpoint</h3>
<p><strong>Endpoint:</strong> /api/realtime-data</p>
<p><strong>Method:</strong> GET</p>
<p><strong>Description:</strong> Fetches real-time vehicle data including engine RPM, fuel pressure, coolant pressure, coolant temperature, and lubricating oil temperature.</p>

<h3>Predictive Analysis Endpoint</h3>
<p><strong>Endpoint:</strong> /api/predict-condition</p>
<p><strong>Method:</strong> POST</p>
<p><strong>Description:</strong> Analyzes the collected data and predicts the car's condition. Also provides explainable values to highlight the features impacting the model's decision.</p>

<h2>Project Structure</h2>
<ul>
    <li><strong>app.py:</strong> Main Flask application file.</li>
    <li><strong>model.py:</strong> Contains the code for the trained prognostic model.</li>
    <li><strong>requirements.txt:</strong> List of dependencies required for the project.</li>
    <li><strong>static/:</strong> Static files for the application.</li>
    <li><strong>templates/:</strong> HTML templates for the Flask application.</li>
    <li><strong>auto_prognostic_app/:</strong> Folder containing the Flutter mobile app.</li>
</ul>

<h2>Contributing</h2>
<p>Contributions are welcome! Please fork the repository and submit a pull request for any enhancements or bug fixes.</p>

<h2>License</h2>
<p>This project is licensed under the MIT License. See the LICENSE file for more details.</p>

<h2>Contact</h2>
<p>For any questions or issues, please open an issue in this repository or contact me at <a href="mailto:shahrizwan403@gmail.com">shahrizwan403@gmail.com</a>.</p>
