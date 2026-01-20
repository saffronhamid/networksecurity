---
title: Network
emoji: 🚢
colorFrom: purple
colorTo: yellow
sdk: docker
pinned: false
---

# Network Security: Phishing URL Detection System

![Python](https://img.shields.io/badge/Python-3.8%2B-blue)
![FastAPI](https://img.shields.io/badge/FastAPI-0.68%2B-green)
![scikit-learn](https://img.shields.io/badge/scikit--learn-Latest-orange)
![Docker](https://img.shields.io/badge/Docker-Enabled-blue)
![License](https://img.shields.io/badge/License-MIT-lightgrey)

## Overview
An end-to-end ML system to detect phishing URLs. Includes data ingestion, validation, transformation, model training, experiment tracking, and a FastAPI app for predictions.

## Key Features
- Modular components: ingestion, validation, transformation, training.
- Automated pipeline: split, validate, transform, train, evaluate, save artifacts.
- Models: RandomForest, DecisionTree, GradientBoosting, LogisticRegression, AdaBoost with grid search.
- MLOps: MLflow/Dagshub tracking (via env vars), Dockerized deployment.
- Web interface: FastAPI + Jinja2 for CSV upload and table output.

## System Architecture
High-level flow:
1) Data ingestion from MongoDB → train/test splits saved to artifacts.
2) Data validation against `data_schema/schema.yaml`.
3) Data transformation (KNNImputer, preprocessing) → numpy arrays + `preprocessor.pkl`.
4) Model training/tuning → best model saved as `final_model/model.pkl`.
5) FastAPI app loads preprocessor+model for `/predict`.

## Installation & Setup
Prereqs: Python 3.8+, MongoDB URI.

```bash
git clone https://github.com/yourusername/networksecurity.git
cd networksecurity
python -m venv venv
venv\Scripts\activate  # or source venv/bin/activate
pip install -r requirements.txt
```

Env vars (in `.env`, not committed):
```
MONGODB_URL_KEY="mongodb+srv://..."
MONGO_DB_URL="mongodb+srv://..."   # needed for /train
MLFLOW_TRACKING_URI="https://dagshub.com/<user>/<repo>.mlflow"
MLFLOW_TRACKING_USERNAME="..."
MLFLOW_TRACKING_PASSWORD="..."
```

## Usage
- Run API locally: `uvicorn app:app --host 0.0.0.0 --port 8000`
- Training pipeline: `python main.py` or hit `/train`
- Predict: go to `/docs` or `/predict`, upload CSV; results saved to `prediction_output/output.csv`

## Project Structure (simplified)
```
networksecurity/
|- networksecurity/        # source code
|  |- components/          # ingestion, validation, transformation, trainer
|  |- utils/               # helpers
|  |- cloud/               # S3 sync helper
|- final_model/            # model.pkl, preprocessor.pkl
|- templates/              # table.html
|- app.py                  # FastAPI entrypoint
|- Dockerfile
|- requirements.txt
```

## Docker
Build: `docker build -t networksecurity .`  
Run: `docker run -p 8000:8000 networksecurity`

## Contributing
PRs welcome—use branches and describe your changes.

## License
MIT
