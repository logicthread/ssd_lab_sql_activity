CREATE OR REPLACE PROCEDURE ssd_tut.ListAllSubscribers()
LANGUAGE plpgsql
AS $$
DECLARE
    cur CURSOR FOR SELECT SubscriberName FROM ssd_tut.Subscribers;
    sub_name VARCHAR(100);
BEGIN
    OPEN cur;
    LOOP
        FETCH cur INTO sub_name;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE '%', sub_name;
    END LOOP;
    CLOSE cur;
END;
$$;

--CALL ssd_tut.ListAllSubscribers();