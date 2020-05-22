FROM python:3.7-slim as base
WORKDIR / .
ENV PYTHONUNBUFFERED True
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY / .

FROM base as test
COPY data_visualization/settings.py data_visualization/settings.py

FROM base

