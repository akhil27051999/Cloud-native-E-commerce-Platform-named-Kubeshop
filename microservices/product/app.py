from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def index():
    return jsonify({"message": "Welcome to the Product Service"})

@app.route("/health")
def health():
    return jsonify({"status": "product service is healthy"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)

