from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

# Временное хранилище данных
users = {}
notes = {}

@app.route('/register', methods=['POST'])
def register():
    data = request.json
    username = data.get('username')
    password = data.get('password')

    if username in users:
        return jsonify({'error': 'Пользователь уже существует'}), 400

    users[username] = {'password': password, 'notes': []}
    return jsonify({'message': 'Регистрация успешна'}), 201

@app.route('/login', methods=['POST'])
def login():
    data = request.json
    username = data.get('username')
    password = data.get('password')

    if username not in users or users[username]['password'] != password:
        return jsonify({'error': 'Неверные учетные данные'}), 401

    return jsonify({'message': 'Авторизация успешна'}), 200

@app.route('/sync', methods=['POST'])
def sync_notes():
    data = request.json
    username = data.get('username')
    notes_data = data.get('notes', [])

    if username not in users:
        return jsonify({'error': 'Пользователь не найден'}), 404

    # Синхронизация заметок
    users[username]['notes'] = notes_data
    return jsonify({'notes': users[username]['notes']}), 200

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
