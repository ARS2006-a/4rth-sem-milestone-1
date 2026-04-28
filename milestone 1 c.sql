

CREATE TABLE Users (
    user_id INTEGER PRIMARY KEY,
    user_name TEXT,
    user_email TEXT
);

CREATE TABLE Movies (
    movie_id INTEGER PRIMARY KEY,
    movie_name TEXT,
    language TEXT,
    genre TEXT,
    duration INTEGER
);

CREATE TABLE Theatres (
    theatre_id INTEGER PRIMARY KEY,
    theatre_name TEXT,
    theatre_location TEXT,
    City TEXT
);

CREATE TABLE Screens (
    screen_id INTEGER PRIMARY KEY,
    theatre_id INTEGER,
    screen_number INTEGER,
    Total_seats INTEGER
);

CREATE TABLE Shows (
    show_id INTEGER PRIMARY KEY,
    movie_id INTEGER,
    screen_id INTEGER,
    show_time TEXT,
    show_date TEXT,
    Ticket_price REAL
);

CREATE TABLE Bookings (
    booking_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    show_id INTEGER,
    booking_date TEXT,
    total_price REAL,
    Payment_status TEXT
);

CREATE TABLE Booking_Seats (
    booking_id INTEGER,
    seat_number TEXT,
    PRIMARY KEY (booking_id, seat_number)
);

SELECT * FROM Users;

SELECT * FROM Movies;

SELECT * FROM Theatres;

SELECT * FROM Screens;

SELECT * FROM Shows;

SELECT * FROM Bookings;
SELECT * FROM Booking_Seats;



INSERT INTO Users VALUES (1, 'Amit', 'amit@gmail.com');

INSERT INTO Movies VALUES (1, 'Avengers', 'English', 'Action', 120);

INSERT INTO Theatres VALUES (1, 'PVR', 'Mall Road', 'Delhi');

INSERT INTO Screens VALUES (1, 1, 1, 100);

INSERT INTO Shows VALUES (1, 1, 1, '10:00', '2024-05-01', 200);

INSERT INTO Bookings VALUES (1, 1, 1, '2024-05-01', 400, 'paid');

INSERT INTO Booking_Seats VALUES (1, 'A1');
INSERT INTO Booking_Seats VALUES (1, 'A2');



SELECT 
    u.user_name,
    m.movie_name,
    t.theatre_name,
    s.show_time,
    s.show_date,
    bs.seat_number
FROM Bookings b
JOIN Users u ON b.user_id = u.user_id
JOIN Shows s ON b.show_id = s.show_id
JOIN Movies m ON s.movie_id = m.movie_id
JOIN Screens sc ON s.screen_id = sc.screen_id
JOIN Theatres t ON sc.theatre_id = t.theatre_id
JOIN Booking_Seats bs ON b.booking_id = bs.booking_id
WHERE b.user_id = 1;



SELECT 
    m.movie_name,
    COUNT(b.booking_id) AS total_bookings
FROM Bookings b
JOIN Shows s ON b.show_id = s.show_id
JOIN Movies m ON s.movie_id = m.movie_id
GROUP BY m.movie_name
ORDER BY total_bookings DESC
LIMIT 1;


SELECT 
    t.theatre_name,
    s.show_date,
    s.show_time,
    COUNT(bs.seat_number) AS seats_booked,
    (sc.Total_seats - COUNT(bs.seat_number)) AS available_seats
FROM Shows s
JOIN Screens sc ON s.screen_id = sc.screen_id
JOIN Theatres t ON sc.theatre_id = t.theatre_id
LEFT JOIN Bookings b ON s.show_id = b.show_id
LEFT JOIN Booking_Seats bs ON b.booking_id = bs.booking_id
GROUP BY s.show_id;


BEGIN TRANSACTION;

INSERT INTO Bookings (booking_id, user_id, show_id, booking_date, total_price, Payment_status)
VALUES (3, 1, 1, '2024-05-01', 300, 'paid');



INSERT INTO Booking_Seats (booking_id, seat_number)
VALUES (3, 'A3');

COMMIT;