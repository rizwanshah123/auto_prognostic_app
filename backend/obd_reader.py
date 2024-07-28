import obd
import random
import threading

class OBDReader:
    def __init__(self, ports=[ 'COM3', 'COM4']):
        self.connection = None
        self.connection_established = threading.Event()

        for port in ports:
            print(f"Trying to connect to {port}")
            thread = threading.Thread(target=self.try_connect, args=(port,))
            thread.start()
            thread.join(2)  # Wait for 2 seconds

            if self.connection and self.connection.is_connected():
                print(f"Connected to {port}")
                self.connection_established.set()
                break
        
        if not self.connection_established.is_set():
            print("No connection could be established on any port.")
            self.supported_commands = set()
        else:
            self.supported_commands = self.connection.supported_commands

    def try_connect(self, port):
        try:
            connection = obd.OBD(port)
            if connection.is_connected():
                self.connection = connection
                self.connection_established.set()
        except Exception as e:
            print(f"Exception while connecting to {port}: {e}")

    def read_data(self):
        data = {}
        commands = {
            'Engine RPM': obd.commands.RPM,
            'Lub Oil Pressure': obd.commands.OIL_TEMP,
            'Fuel Pressure': obd.commands.FUEL_PRESSURE,
            'Coolant Pressure': obd.commands.COOLANT_TEMP,
            'Lub Oil Temp': obd.commands.OIL_TEMP,
            'Coolant Temp': obd.commands.COOLANT_TEMP
        }
        random_ranges = {
            'Engine RPM': (61, 2239.00),
            'Lub Oil Pressure': (0.003384, 7.265566),
            'Fuel Pressure': (0.012640, 21.138326),
            'Coolant Pressure': (0.015665, 7.478505),
            'Lub Oil Temp': (71.321974, 89.580796),
            'Coolant Temp': (61.673325, 195.527912)
        }

        if self.connection and self.connection.is_connected():
            for name, command in commands.items():
                if command in self.supported_commands:
                    response = self.connection.query(command)
                    if response and response.value is not None:
                        data[name] = round(response.value.magnitude, 2)
                    else:
                        min_val, max_val = random_ranges[name]
                        data[name] = round(random.uniform(min_val, max_val), 2)
                else:
                    min_val, max_val = random_ranges[name]
                    data[name] = round(random.uniform(min_val, max_val), 2)
        else:
            for name, command in commands.items():
                min_val, max_val = random_ranges[name]
                data[name] = round(random.uniform(min_val, max_val), 2)

        return data
