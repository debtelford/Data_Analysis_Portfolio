# R projects
This folder contains a sample R script which I developed as part of a research project examining 24-h movement behaviours (physical activity, sedentary behaviour, sleep) in adolescents.

The script imports handwritten diary data and activPAL accelerometry files (15-second epochs), processes them, and produces a participant-level summary dataset:  
**`participant_complete.csv`**

The processing steps include:

- Importing and cleaning diary files
- Importing and structuring raw activPAL files
- Intensity estimation (MVPA, VPA)
- Hourly and daily summaries
- Identification of valid measurement days
- Aggregation by participant and day type
