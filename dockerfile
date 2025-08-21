FROM wasserth/totalsegmentator:2.10.0

# Add a tiny API layer
RUN pip install --no-cache-dir fastapi uvicorn[standard]

WORKDIR /app
COPY app.py /app/app.py

EXPOSE 8000
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
