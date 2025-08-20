# Smaller, CPU-only build (fits on GitHub runners)
FROM python:3.11-slim

# Basic build deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    git wget build-essential && rm -rf /var/lib/apt/lists/*

# Faster pip & CPU Torch
RUN pip install --no-cache-dir --upgrade pip \
 && pip install --no-cache-dir torch --index-url https://download.pytorch.org/whl/cpu

# TotalSegmentator + deps
# (SimpleITK/nibabel/nnunetv2 are common deps; keep headless stack)
RUN pip install --no-cache-dir \
    "totalsegmentator>=2.0.0" \
    fastapi "uvicorn[standard]" \
    SimpleITK nibabel numpy scipy nnunetv2 \
    opencv-python-headless

# Cache locations (mounted to Azure Files in ACA)
ENV TOTALSEG_CACHE_DIR=/root/.totalsegmentator
ENV nnUNet_results=/root/.totalsegmentator/nnunet_results
ENV NUMBA_CACHE_DIR=/tmp/numba_cache

WORKDIR /app
COPY app.py /app/app.py

EXPOSE 8000
CMD ["uvicorn","app:app","--host","0.0.0.0","--port","8000"]
