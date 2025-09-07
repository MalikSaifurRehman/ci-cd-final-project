# Use official Python 3.9 slim image
FROM python:3.9-slim

# Establish a working folder
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN python -m pip install -U pip wheel && \
    pip install -r requirements.txt

# Copy source files (service folder)
COPY service ./service

# Create a non-root user and give permissions
RUN useradd -m -r service && \
    chown -R service:service /app
USER service

# Set environment variable and expose port
ENV PORT 8000
EXPOSE $PORT

# Run the service using Gunicorn
CMD ["gunicorn", "service:app", "--bind", "0.0.0.0:8000"]
