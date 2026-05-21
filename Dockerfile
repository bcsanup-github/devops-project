FROM python:3.11-slim


WORKDIR /app


COPY app/requirements.txt .


RUN pip install --no-cache-dir -r requirements.txt


RUN useradd -m appuser


COPY app/ .


RUN chown -R appuser:appuser /app


USER appuser


ENV ENVIRONMENT=production

EXPOSE 5000


CMD ["python", "app.py"]