from flask import Flask, render_template, request, redirect, session
from flask_mysqldb import MySQL
import pandas as pd

app = Flask(__name__)
app.secret_key = 'your_secret_key'

# MySQL Configuration (for XAMPP)
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'quizdb'
app.config['MYSQL_PORT'] = 3307  # Change to 3306 if your XAMPP is on default

mysql = MySQL(app)

@app.route('/')
def home():
    return redirect('/login')

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO users (username, password) VALUES (%s, %s)", (username, password))
        mysql.connection.commit()
        cur.close()
        return redirect('/login')
    return render_template('register.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM users WHERE username=%s AND password=%s", (username, password))
        user = cur.fetchone()
        cur.close()
        if user:
            session['username'] = username
            return redirect('/quiz')
        else:
            return "Invalid Credentials"
    return render_template('login.html')

@app.route('/quiz')
def quiz():
    return render_template('quiz.html')

# ✅ Upload Excel file (GET+POST)
@app.route('/upload', methods=['GET', 'POST'])
def upload():
    if request.method == 'POST':
        file = request.files['file']
        if file.filename.endswith('.xlsx'):
            df = pd.read_excel(file)
            cur = mysql.connection.cursor()
            for i, row in df.iterrows():
                cur.execute("INSERT INTO questions (question, option1, option2, option3, option4, answer) VALUES (%s, %s, %s, %s, %s, %s)",
                            (row['question'], row['option1'], row['option2'], row['option3'], row['option4'], row['answer']))
            mysql.connection.commit()
            cur.close()
            return redirect('/quiz')
    return render_template('upload.html')

# ✅ Result with summary (manual answer key check)
@app.route('/result', methods=['POST'])
def result():
    correct_answers = [
        "Artificial Intelligence",
        "John McCarthy",
        "Face Recognition",
        "Python",
        "Reinforcement Learning",
        "Machine Learning",
        "Supervised Memory",
        "Gaming",
        "AI Intelligence",
        "AI Assistant"
    ]

    correct = 0
    wrong = 0
    user_answers = []

    for i in range(1, 11):
        selected = request.form.get(f'q{i}')
        correct_ans = correct_answers[i - 1]
        user_answers.append((f'Q{i}', selected, correct_ans))
        if selected == correct_ans:
            correct += 1
        else:
            wrong += 1

    score = correct
    total = 10

    return render_template('result.html', total=total, correct=correct, wrong=wrong, score=score, user_answers=user_answers)

if __name__ == '__main__':
    app.run(debug=True)
    app.run(host='0.0.0.0', port=5000)