from python3 import datetime
from flask import Flask 
app = Flask(__name__)

@app.route('/')
def hello():
    return '__This is a simple Flask app and it tells my local time__'  + str(datetime.now())   
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)  
    