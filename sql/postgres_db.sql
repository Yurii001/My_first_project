CREATE TABLE IF NOT EXISTS cameras (
    id SERIAL PRIMARY KEY,              -- ключ подкл. к другой таблице    
    name VARCHAR(255) NOT NULL,         -- имя камеры, значение не может быть пустым  
    ip_address INET NOT NULL,           -- Inet лучше всего для обозначений IP
    added_date TIMESTAMP DEFAULT NOW(), -- дата добавл. камеры, если вдруг не подтянулось время, то по дефолту выставляется время на сейчас
    coordinates POINT                   -- координаты лучше всего использовать с Point
);

CREATE TABLE IF NOT EXISTS plate_events (
    id SERIAL PRIMARY KEY,              
    plate_number VARCHAR(12) NOT NULL,  
    recognition_time TIMESTAMP NOT NULL, -- время распознание номера авто. (без инфо по Гринвичу/without..) year-mm-dd hh:mm:ss 
    car_make VARCHAR(50),                -- производитель
    car_color VARCHAR(30),             
    camera_id INT NOT NULL,            
    FOREIGN KEY (camera_id) REFERENCES cameras(id) -- внешнее подкл. camera_id ссылается на таблицу cameras, на поле id
);

INSERT INTO cameras (name, ip_address, added_date, coordinates)
VALUES
	('Камера_1', '192.168.0.2', '2024-05-05 10:00:00', '51.52274, 31.32435'),
	('Камера_2', '192.168.0.3', '2024-06-06 11:00:00', '51.52220, 31.32420'),
	('Камера_3', '192.168.0.4', '2024-07-07 12:00:00', '51.52440, 31.32560'),
	('Камера_4', '192.168.0.5', '2024-08-08 13:00:00', '51.52200, 31.32400'),
	('Камера_5', '192.168.0.6', '2024-09-09 14:00:00', '51.52333, 31.32333'),
	('Камера_6', '192.168.0.7', '2024-10-10 15:00:00', '51.52222, 31.32222'),
	('Камера_7', '192.168.0.8', '2024-11-11 16:00:00', '51.52444, 31.32444'),
	('Камера_8', '192.168.0.9', '2024-12-12 17:00:00', '51.52555, 31.32555'),
	('Камера_9', '192.168.0.10', '2024-01-01 18:00:00', '51.52666, 31.32666'),
	('Камера_10', '192.168.0.11', '2024-02-02 09:00:00', '51.52777, 31.32777');

INSERT INTO plate_events (plate_number, recognition_time, car_make, car_color, camera_id)
VALUES
('CB9197EM', '2025-01-01 14:00:00', 'Skoda', 'gray', 1),
('CB9197EM', '2025-01-01 13:30:00', 'Skoda', 'gray', 2),
('CB9197EM', '2025-01-01 13:00:00', 'Skoda', 'gray', 3),
('CB9197EM', '2025-01-01 12:30:00', 'Skoda', 'gray', 1),
('CB9197EM', '2025-01-01 12:00:00', 'Skoda', 'gray', 2),
('CB9197EM', '2025-01-01 11:30:00', 'Skoda', 'gray', 2),
('CB9197EM', '2025-01-01 11:00:00', 'Skoda', 'gray', 3),
('CB9197EM', '2025-01-01 10:30:00', 'Skoda', 'gray', 3),
('CB9197EM', '2025-01-01 10:00:00', 'Skoda', 'gray', 3),
('CB1234AA', '2025-01-01 10:00:00', 'Mercedes', 'white', 1),
('CB1234AA', '2025-01-01 09:00:00', 'Mercedes', 'white', 6),
('CB1234AA', '2024-12-31 20:00:00', 'Mercedes', 'white', 6),
('CB1234AA', '2024-12-31 12:00:00', 'Mercedes', 'white', 6),
('CB1234AA', '2024-12-31 16:00:00', 'Mercedes', 'white', 6);

SELECT DISTINCT 				-- DISTINCT убирает дубль при нескольких запусках
	p.plate_number, 			-- p - псевдоним таблицы plate.events 
	p.recognition_time,
	p.car_make,
	p.car_color,
	c.name AS camera_name		-- c - псевдоним таблицы cameras. AS - переименовать в...
FROM 
	plate_events p
JOIN 
	cameras c ON p.camera_id = c.id
WHERE 
	p.recognition_time BETWEEN '2025-01-01 00:01:00' AND '2025-01-01 23:59:00,'
AND
	c.name = 'Камера_1' 

	





	







	

	