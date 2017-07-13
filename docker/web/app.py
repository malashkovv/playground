from flask import Flask
import socket

app = Flask(__name__)

@app.route('/')
def hello():
  return "Hi, I'm {}".format(socket.gethostname())

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)