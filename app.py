# Імпорт бібліотек
from flask import Flask, render_template, request  # Flask - головний модуль, render_template - для HTML, request - для роботи з формами
import psycopg2  # Для з'єднання з PostgreSQL

# Ініціалізуємо додаток Flask
app = Flask(__name__)

# з'єднання з базою даних PostgreSQL
DB_HOST = "localhost"  # Локальний сервер бази даних
DB_NAME = "plates"     # Назва вашої бази даних
DB_USER = "cctv"       # Користувач бази даних
DB_PASS = "qwerty123456"  # Пароль до бази даних

# Головна сторінка для пошуку номерів
@app.route("/", methods=["GET", "POST"])  # / - головна сторінка. Гет - отримання/перегляд. Пост - відправка
def index():
    results = []  # Список для збереження результатів пошуку
    if request.method == "POST":  # Якщо форма була відправлена
        # Отримання даних з форм
        start_date = request.form.get("start_date")  # Дата початку пошуку
        end_date = request.form.get("end_date")      # Дата кінця пошуку
        camera_name = request.form.get("camera_name")  # Назва камери

        try:
            # Підключаємося до бази даних
            conn = psycopg2.connect(
                host=DB_HOST,
                database=DB_NAME,
                user=DB_USER,
                password=DB_PASS
            )
            cursor = conn.cursor()  # Створюємо курсор для виконання SQL-запитів

            # Виконуємо SQL-запит
            query = """
                SELECT DISTINCT
                    p.plate_number,
                    p.recognition_time,
                    p.car_make,
                    p.car_color,
                    c.name AS camera_name
                FROM 
                    plate_events p
                JOIN 
                    cameras c ON p.camera_id = c.id
                WHERE 
                    p.recognition_time BETWEEN %s AND %s
                AND 
                    c.name = %s
            """
            cursor.execute(query, (start_date, end_date, camera_name))  # Виконуємо запит із параметрами
            results = cursor.fetchall()  # Отримуємо всі результати

            cursor.close()  # Закриваємо курсор
            conn.close()  # Закриваємо підключення

        except Exception as e:
            print(f"Error: {e}")  # Виводимо помилку, якщо виникла

    # Відображаємо сторінку search.html і передаємо результати
    return render_template("search.html", results=results)

# Запускаємо сервер
if __name__ == "__main__":
    app.run(debug=True)  # debug=True дозволяє автоматично оновлювати сервер при зміні коду
