from flask import Flask, request, render_template, redirect, url_for, abort, flash

app = Flask(__name__)
app.secret_key = 'une cle(token) : grin de sel(any random string)'

import pymsql.cursors
mydb = pymsql.connect(
    host="localhost",
    user="amajoure",
    password="0903",
    database="SAE4",
    charset='utf8mb4',
    cursorclass=pymsql.cursors.DictCursor
)
mycursor = mydb.cursor()
