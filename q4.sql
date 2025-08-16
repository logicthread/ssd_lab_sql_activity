CREATE OR REPLACE PROCEDURE ssd_tut.SendWatchTimeReport()
LANGUAGE plpgsql
AS $$
DECLARE
    cur CURSOR FOR SELECT SubscriberID, SubscriberName FROM ssd_tut.Subscribers;
    sub_id   INT;
    sub_name VARCHAR(100);
    cnt      INT;
    watch_cur refcursor;
    rec RECORD;
BEGIN
    OPEN cur;
    LOOP
        FETCH cur INTO sub_id, sub_name;
        EXIT WHEN NOT FOUND;
        SELECT COUNT(*) INTO cnt 
        FROM ssd_tut.WatchHistory 
        WHERE SubscriberID = sub_id;
        IF cnt > 0 THEN
            RAISE NOTICE '--- Watch Report for Subscriber: % ---', sub_name;
            watch_cur := 'watch_cur_' || sub_id;
            CALL ssd_tut.GetWatchHistoryBySubscriber(sub_id, watch_cur);
            LOOP
                FETCH watch_cur INTO rec;
                EXIT WHEN NOT FOUND;
                RAISE NOTICE 'Title: %, WatchTime: %', rec.Title, rec.WatchTime;
            END LOOP;
            CLOSE watch_cur;
        ELSE
            RAISE NOTICE 'No watch history for Subscriber: %', sub_name;
        END IF;
    END LOOP;
    CLOSE cur;
END;
$$;

--CALL ssd_tut.SendWatchTimeReport();
