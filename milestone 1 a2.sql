
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100),
    user_email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15)
);


CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    movie_name VARCHAR(100),
    language VARCHAR(50),
    duration INT,
    genre VARCHAR(50),
    release_date DATE,
    rating DECIMAL(3,1)
);


CREATE TABLE Theatres (
    theatre_id INT PRIMARY KEY,
    theatre_name VARCHAR(100),
    theatre_location VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE Screens (
    screen_id INT PRIMARY KEY,
    theatre_id INT,
    screen_number INT,
    total_seats INT,
    screen_type VARCHAR(20),
    FOREIGN KEY (theatre_id) REFERENCES Theatres(theatre_id)
);


CREATE TABLE Shows (
    show_id INT PRIMARY KEY,
    movie_id INT,
    screen_id INT,
    show_time TIME,
    show_date DATE,
    ticket_price DECIMAL(8,2),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (screen_id) REFERENCES Screens(screen_id)
);

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    user_id INT,
    show_id INT,
    booking_date DATE,
    total_price DECIMAL(8,2),
    payment_status VARCHAR(20),
    booking_status VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (show_id) REFERENCES Shows(show_id)
);

CREATE TABLE Booking_Seats (
    booking_id INT,
    seat_number VARCHAR(10),
    PRIMARY KEY (booking_id, seat_number),
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);