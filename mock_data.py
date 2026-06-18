import pandas as pd
import numpy as np
from datetime import datetime, timedelta

# Create a sample of messy, cross-platform clickstream records
np.random.seed(42)
rows = 1000

data = {
    "event_id": [f"evt_{i}" for i in range(rows)],
    # Simulate anonymous cookies that later map to a real user ID upon login
    "domain_userid": [f"cookie_{np.random.randint(100, 200)}" for _ in range(rows)],
    "user_id": [f"user_{np.random.randint(1, 50)}" if np.random.rand() > 0.4 else None for _ in range(rows)],
    "device_type": np.random.choice(["mobile_app", "web_browser"], rows, p=[0.7, 0.3]),
    "event_name": np.random.choice(
        ["page_view", "click_refill_button", "input_prescription_info", "confirm_order"], 
        rows, 
        p=[0.4, 0.3, 0.2, 0.1]
    ),
    "timestamp": [datetime(2026, 6, 1) + timedelta(minutes=int(i * np.random.randint(1, 10))) for i in range(rows)]
}

df = pd.DataFrame(data)
# Export to a clean CSV to simulate a flat-file database landing zone
df.to_csv("raw_clickstream_events.csv", index=False)
print("Successfully generated raw_clickstream_events.csv!")
