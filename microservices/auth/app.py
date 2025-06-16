from flask import Flask, jsonify, request

app = Flask(__name__)

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    if data.get('username') == 'admin' and data.get('password') == 'admin':
        return jsonify({'message': 'Login successful'}), 200
    return jsonify({'message': 'Unauthorized'}), 401

@app.route('/')
def home():
    return jsonify({'message': 'Auth Service Running'})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

