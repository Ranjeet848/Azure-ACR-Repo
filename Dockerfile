FROM python:3.11-slim

WORKDIR /app

# Install system dependencies for TotalSegmentator
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app.py .

# Set environment variables
ENV TOTALSEG_CACHE_DIR=/root/.totalsegmentator

# Create cache directory
RUN mkdir -p /root/.totalsegmentator

# Expose port
EXPOSE 8000

# Command to run the application
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
