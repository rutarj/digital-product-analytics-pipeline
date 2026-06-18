# Digital Product Analytics & Clickstream Pipeline

## Project Overview
This repository contains an end-to-end simulation of a user-behavior event data pipeline, reverse-engineered from enterprise tracking frameworks like **Snowplow Analytics** and **dbt (data build tool)**. The goal is to ingest raw event logs from a mobile health app, map anonymous browsing sessions to authenticated user profiles, and generate conversion funnel insights.

## Architecture & Workflow
1. **Data Ingestion (`mock_data.py`)**: Uses Python to generate raw, un-scrubbed web and mobile app event rows mimicking real-time tracking behavior.
2. **Data Modeling & Analytics (`analytics_queries.sql`)**: Implements advanced SQL window functions to handle user session-stitching and compute behavioral funnel drop-off statistics.

## Key Metrics Evaluated
* **Session Stitching Resolution Rate:** Merging disparate web identity tokens into uniform user accounts.
* **Conversion Funnel Conversion/Drop-off Multi-stages:** Tracking specific conversion steps from a platform landing page to an completed application action.
