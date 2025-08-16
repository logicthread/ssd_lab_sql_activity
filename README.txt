SSD Lab 2 Execution Steps

1. Create Schema ssd_tut
2. Create required tables as defined at the end of this file 	1. ssd_tut.Shows 	2. ssd_tut.Subscribers 	3. ssd_tut.WatchHistory
3. Insert data into the tables
4. Run the procedure creation scripts
5. Use procedures as described below

Q1 : ListAllSubscribers() – Stored procedure that uses a cursor to iterate through all
Subscribers and prints their names  Usage : 

CALL ssd_tut.ListAllSubscribers();


Q2 : Write a procedure GetWatchHistoryBySubscriber(IN sub_id INT) that returns all
shows watched by the subscriber along with watch time
 Usage : 

DO $$
DECLARE
    watch_cur refcursor;
    rec RECORD;
BEGIN
    CALL ssd_tut.GetWatchHistoryBySubscriber(1, watch_cur);
    LOOP
        FETCH watch_cur INTO rec;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'Title: %, WatchTime: %', rec.Title, rec.WatchTime;
    END LOOP;
    CLOSE watch_cur;
END$$;

//NOTE : The procedure returns a cursor instead of a table


Q3 : AddSubscriberIfNotExists(IN subName VARCHAR(100)) – Adds a new subscriber
into the Subscribers table, checking if the subscriber name already exists.
 Usage : 

CALL ssd_tut.AddSubscriberIfNotExists('Test User');


Q4 : Make a procedure SendWatchTimeReport() which internally calls
GetWatchHistoryBySubscriber() for all subscribers, but only if they have watched
something.
 Usage : 

CALL ssd_tut.SendWatchTimeReport();


Q5 : Write a procedure with a cursor that loops through each subscriber and for each
subscriber GetWatchHistoryBySubscriber() to print their watch history
 Usage : 

CALL ssd_tut.LoopSubscribersWithHistory();




————————————————————— SCHEMA DEFINITION ———————————————————————

create schema ssd_tut;

CREATE TABLE ssd_tut.Shows (
ShowID SERIAL PRIMARY KEY,
Title VARCHAR(100),
Genre VARCHAR(50),
ReleaseYear INT
);

CREATE TABLE ssd_tut.Subscribers (
SubscriberID SERIAL PRIMARY KEY,
SubscriberName VARCHAR(100),
SubscriptionDate DATE
);

CREATE TABLE ssd_tut.WatchHistory (
HistoryID SERIAL PRIMARY KEY,
ShowID INT,
SubscriberID INT,
WatchTime INT, -- Duration in minutes
FOREIGN KEY (ShowID) REFERENCES ssd_tut.Shows(ShowID),
FOREIGN KEY (SubscriberID) REFERENCES
ssd_tut.Subscribers(SubscriberID)
);

-- Insert Sample Data
INSERT INTO ssd_tut.Shows (Title, Genre, ReleaseYear) VALUES
('Stranger Things', 'Sci-Fi', 2016),
('The Crown', 'Drama', 2016),
('The Witcher', 'Fantasy', 2019);

INSERT INTO ssd_tut.Subscribers (SubscriberName,
SubscriptionDate) VALUES
('Emily Clark', '2023-01-10'),
('Chris Adams', '2023-02-15'),
('Jordan Smith', '2023-03-05');

INSERT INTO ssd_tut.WatchHistory (SubscriberID, ShowID,
WatchTime) VALUES
(1, 1, 100),
(1, 2, 10),
(2, 1, 20),
(2, 2, 40),
(2, 3, 10),
(3, 2, 10),
(3, 1, 10);