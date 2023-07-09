from flask import Flask, render_template, request, redirect, url_for, flash

app = Flask(__name__)


@app.route("/")
def index():
    # return render_template('index.html')
    # return redirect(url_for('login'))
    return "Hello!\n"


# app.run(debug=True)
