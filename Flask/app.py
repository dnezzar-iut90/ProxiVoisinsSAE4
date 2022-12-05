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

@app.route('/')
def show_accueil():
    return render_template('layout.html')

@app.route('/trajet/show')
def show_trajet():
    sql = "SELECT * FROM TRAJET"
    mycursor.execute(sql)
    trajet = mycursor.fetchall()
    
    sql = "SELECT * FROM UTILISATEUR"
    mycursor.execute(sql)
    utilisateur = mycursor.fetchall()

    sql = "SELECT * FROM COMMUNE"
    mycursor.execute(sql)
    commune = mycursor.fetchall()

    return render_template('trajet/show_trajet.html', trajet=trajet, utilisateur=utilisateur, commune=commune)

@app.route('/trajet/add', methods=['GET'])
def add_trajet():
    sql = "SELECT * FROM UTILISATEUR"
    mycursor.execute(sql)
    utilisateur = mycursor.fetchall()

    sql = "SELECT * FROM COMMUNE"
    mycursor.execute(sql)
    commune = mycursor.fetchall()

    return render_template('trajet/add_trajet.html', utilisateur=utilisateur, commune=commune)

@app.route('/trajet/add', methods=['POST'])
def valid_add_trajet():
    date_heure_de_depart = request.form.get('date_heure_de_depart','')
    date_heure_d_arrivee = request.form.get('date_heure_d_arrivee','')
    distance_parcourue = request.form.get('distance_parcourue','')
    nombre_de_place_s = request.form.get('nombre_de_place_s','')
    lieu_destinationoudepart = request.form.get('lieu_destinationoudepart','')
    id_utilisateur = request.form.get('id_utilisateur','')
    id_commune = request.form.get('id_commune','')

    tuple_insert=(date_heure_de_depart, date_heure_d_arrivee, distance_parcourue, nombre_de_place_s, lieu_destinationoudepart, id_utilisateur, id_commune)
    sql = '''INSERT INTO trajet(date_heure_de_depart, date_heure_d_arrivee, distance_parcourue, nombre_de_place_s, lieu_destinationoudepart, id_utilisateur, id_commune)'''
    mycursor.execute(sql, tuple_insert)
    mydb.commit()

    return redirect(url_for('show_trajet'))

@app.route('/trajet/edit/<int:id>', methods=['GET'])
def edit_trajet(id):
    sql = "SELECT id, date_heure_de_depart, date_heure_d_arrivee, distance_parcourue, nombre_de_place_s, lieu_destinationoudepart, id_utilisateur, id_commune FROM TRAJET,= WHERE id = %s"
    mycusor.execute(sql, (id,))
    trajet = mycursor.fetchone()
    sql = "SELECT * FROM UTILISATEUR"
    mycursor.execute(sql)
    utilisateur = mycursor.fetchall()
    sql = "SELECT * FROM COMMUNE"
    mycursor.execute(sql)
    commune = mycursor.fetchall()

    return render_template('trajet/edit_trajet.html', trjet=trajet, utilisateur=utilisateur, commune=commune)

@app.route('/trajet/edit', methods=['POST'])
def valid_edit_trajet():
    id = request.form.get('id','')
    date_heure_de_depart = request.form.get('date_heure_de_depart', '')
    date_heure_d_arrivee = request.form.get('date_heure_d_arrivee','')
    distance_parcourue = request.form.get('distance_parcourue','')
    nombre_de_place_s = request.form.get('nombre_de_place_s','')
    lieu_destinationoudepart = request.form.get('lieu_destinationoudepart','')
    id_utilisateur = request.form.get('id_utilisateur','')
    id_commune = request.form.get('id_commune','')

    tuple_update = (date_heure_de_depart, date_heure_d_arrivee, distance_parcourue, nombre_de_place_s, lieu_destinationoudepart, id_utilisateur, id_commune)
    sql = '''UPDATE trajet SET date_heure_de_depart=%s, date_heure_d_arrivee=%s, distance_parcourue=%s, nombre_de_place_s=%s, lieu_destinationoudepart=%s, id_utilisateur=%s, id_commune=%s'''
    mycursor.execute(sql, tuple_update)
    mydb.commit()

    return redirect(url_for('show_trajet'))


@app.route('/trajet/delete', methods=['GET'])
def delete_trajet():
    id = request.args.get('id','')
    tuple_delete = (id,)
    sql='''DELETE FROM TRAJET WHERE id = %s'''
    mycursor.execute(sql, tuple_delete)
    mydb.commit()

    return redirect(url_for('show_trajet'))