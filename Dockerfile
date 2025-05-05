# Use Python base image
FROM python:3.10

# Set work directory inside the container
WORKDIR /app

# Copy requirements first for better caching
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire Django project
COPY . .

# Set environment variables for Django
ENV PYTHONUNBUFFERED=1

# Collect static files
RUN python manage.py collectstatic --noinput

# Expose port 8000
EXPOSE 8000

# Use Gunicorn for production (recommended over runserver)
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "your_project.wsgi:application"]
