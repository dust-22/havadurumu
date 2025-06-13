from flask import Flask, request
import subprocess

app = Flask(__name__)

@app.route('/streamdeck/command', methods=['POST'])
def streamdeck_command():
    command = request.form['command']
    try:
        subprocess.Popen(command, shell=True)
        print("Komut çalıştırıldı:", command)
        return 'OK', 200
    except Exception as e:
        print("Komut Hatası:", e)
        return 'Error', 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)