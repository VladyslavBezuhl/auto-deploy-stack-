FROM python:3.9-slim AS builder

WORKDIR /install

RUN apt-get update && apt-get install -y build-essential && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --upgrade pip && \
    pip wheel --no-cache-dir --wheel-dir /install/wheels -r requirements.txt




FROM python:3.12-slim

WORKDIR /app

COPY --from=builder /install/wheels /wheels
COPY --from=builder /install/requirements.txt .

RUN pip install --no-cache-dir --no-index --find-links=/wheels -r requirements.txt

COPY . .

CMD ["python", "app.py"]
FROM python:3.9-slim AS builder

WORKDIR /install

RUN apt-get update && apt-get install -y build-essential && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --upgrade pip && \
    pip wheel --no-cache-dir --wheel-dir /install/wheels -r requirements.txt

FROM python:3.12-slim

WORKDIR /app

COPY --from=builder /install/wheels /wheels
COPY --from=builder /install/requirements.txt .

RUN pip install --no-cache-dir --find-links=/wheels -r requirements.txt

COPY . .

CMD ["python", "app.py"]
