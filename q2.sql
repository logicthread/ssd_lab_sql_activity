CREATE OR REPLACE PROCEDURE ssd_tut.GetWatchHistoryBySubscriber(
    IN sub_id INT,
    OUT ref refcursor
)
LANGUAGE plpgsql
AS $$
BEGIN
    OPEN ref FOR
        SELECT s.Title, w.WatchTime
        FROM ssd_tut.WatchHistory w
        JOIN ssd_tut.Shows s ON w.ShowID = s.ShowID
        WHERE w.SubscriberID = sub_id;
END;
$$;

--DO $$
--DECLARE
--    watch_cur refcursor;
--    rec RECORD;
--BEGIN
--    CALL ssd_tut.GetWatchHistoryBySubscriber(1, watch_cur);
--    LOOP
--        FETCH watch_cur INTO rec;
--        EXIT WHEN NOT FOUND;
--        RAISE NOTICE 'Title: %, WatchTime: %', rec.Title, rec.WatchTime;
--    END LOOP;
--    CLOSE watch_cur;
--END$$;
