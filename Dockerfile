FROM python:3.9 
WORKDIR /app 
COPY . /app 
RUN pip install --no-cache-dir -r requirements.txt 
ENV DJANGO_SETTINGS_MODULE=Gamble_Boss.settings 
ENV PYTHONUNBUFFERED=1 
CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"] 
