from flask import Flask, request

app = Flask(__name__)

@app.route('/ets2/command', methods=['POST'])
def ets2_command():
    command = request.form['command']
    print("Komut alındı:", command)
    # Burada ETS2'ye istediğin işlemi yaptırabilirsin
    return 'OK', 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)