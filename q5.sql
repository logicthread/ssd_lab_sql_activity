CREATE OR REPLACE PROCEDURE ssd_tut.LoopSubscribersWithHistory()
LANGUAGE plpgsql
AS $$
DECLARE
    cur CURSOR FOR SELECT SubscriberID, SubscriberName FROM ssd_tut.Subscribers;
    sub_id   INT;
    sub_name VARCHAR(100);

    watch_cur refcursor;   -- cursor returned by GetWatchHistoryBySubscriber
    rec RECORD;
BEGIN
    OPEN cur;
    LOOP
        FETCH cur INTO sub_id, sub_name;
        EXIT WHEN NOT FOUND;

        RAISE NOTICE '--- Watch History for Subscriber: % ---', sub_name;

        -- open cursor with watch history for this subscriber
        watch_cur := 'watch_cur_' || sub_id;
        CALL ssd_tut.GetWatchHistoryBySubscriber(sub_id, watch_cur);

        -- iterate through the watch history rows
        LOOP
            FETCH watch_cur INTO rec;
            EXIT WHEN NOT FOUND;
            RAISE NOTICE 'Title: %, WatchTime: %', rec.Title, rec.WatchTime;
        END LOOP;

        CLOSE watch_cur;
    END LOOP;
    CLOSE cur;
END;
$$;

--CALL ssd_tut.LoopSubscribersWithHistory();
