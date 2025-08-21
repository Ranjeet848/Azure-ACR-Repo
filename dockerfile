FROM wasserth/totalsegmentator:2.10.0

# Add FastAPI, Uvicorn, and python-multipart for file uploads
RUN pip install --no-cache-dir fastapi uvicorn[standard] python-multipart

WORKDIR /app
COPY app.py /app/app.py

EXPOSE 8000
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]

