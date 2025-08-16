CREATE OR REPLACE PROCEDURE ssd_tut.AddSubscriberIfNotExists(IN subName VARCHAR(100))
LANGUAGE plpgsql
AS $$
DECLARE
    cnt INT;
BEGIN
    SELECT COUNT(*) INTO cnt FROM ssd_tut.Subscribers WHERE SubscriberName = subName;
    IF cnt = 0 THEN
        INSERT INTO ssd_tut.Subscribers(SubscriberName, SubscriptionDate)
        VALUES (subName, CURRENT_DATE);
        RAISE NOTICE 'Subscriber % added successfully', subName;
    ELSE
        RAISE NOTICE 'Subscriber % already exists, skipping insert.', subName;
    END IF;
END;
$$;

--CALL ssd_tut.AddSubscriberIfNotExists('Test User');
