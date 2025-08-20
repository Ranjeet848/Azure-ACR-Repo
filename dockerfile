FROM python:3.11-slim

# System deps often required by FastAPI/ITK/NumPy/OpenCV stacks
RUN apt-get update && apt-get install -y --no-install-recommends \
    git wget build-essential \
    libglib2.0-0 libsm6 libxext6 libxrender1 \
    && rm -rf /var/lib/apt/lists/*

# Python deps
RUN pip install --no-cache-dir --upgrade pip \
 && pip install --no-cache-dir torch --index-url https://download.pytorch.org/whl/cpu

RUN pip install --no-cache-dir \
    "totalsegmentator>=2.0.0" \
    fastapi uvicorn \
    SimpleITK nibabel numpy scipy nnunetv2 \
    opencv-python-headless

ENV TOTALSEG_CACHE_DIR=/root/.totalsegmentator
ENV nnUNet_results=/root/.totalsegmentator/nnunet_results
ENV NUMBA_CACHE_DIR=/tmp/numba_cache

WORKDIR /app
COPY app.py /app/app.py
EXPOSE 8000
CMD ["uvicorn","app:app","--host","0.0.0.0","--port","8000"]
