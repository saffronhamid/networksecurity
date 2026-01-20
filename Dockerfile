FROM python:3.10-slim-bookworm
WORKDIR /app
COPY . /app

# Install dependencies (awscli via pip; no apt needed)
RUN pip install --no-cache-dir awscli && \
    pip install --no-cache-dir -r requirements.txt
# Run FastAPI with uvicorn on the platform port (HF Spaces defaults to 7860, or use $PORT if provided)
CMD ["sh", "-c", "uvicorn app:app --host 0.0.0.0 --port ${PORT:-7860}"]
