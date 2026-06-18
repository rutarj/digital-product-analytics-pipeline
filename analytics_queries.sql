-- Step 1: Session Stitching (Mapping anonymous cookies to the true authenticated user ID)
WITH stitched_users AS (
    SELECT 
        domain_userid,
        -- Grab the absolute first non-null user_id associated with this cookie session
        FIRST_VALUE(user_id) OVER(
            PARTITION BY domain_userid 
            ORDER BY timestamp 
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ) AS stitched_user_id,
        event_name,
        timestamp
    FROM raw_clickstream_events
),

-- Step 2: Funnel Step Identification (Flagging milestones in the prescription refill loop)
funnel_stages AS (
    SELECT 
        stitched_user_id,
        CASE WHEN event_name = 'page_view' THEN 1 ELSE 0 END AS step_1_view,
        CASE WHEN event_name = 'click_refill_button' THEN 1 ELSE 0 END AS step_2_click,
        CASE WHEN event_name = 'input_prescription_info' THEN 1 ELSE 0 END AS step_3_input,
        CASE WHEN event_name = 'confirm_order' THEN 1 ELSE 0 END AS step_4_conversion
    FROM stitched_users
    WHERE stitched_user_id IS NOT NULL
)

-- Step 3: Aggregate Funnel Drop-off Metrics for Product Strategy teams
SELECT 
    COUNT(DISTINCT stitched_user_id) AS total_unique_users,
    SUM(step_1_view) AS landing_page_views,
    SUM(step_2_click) AS refill_button_clicks,
    SUM(step_3_input) AS prescription_details_entered,
    SUM(step_4_conversion) AS final_completed_refills
FROM funnel_stages;
