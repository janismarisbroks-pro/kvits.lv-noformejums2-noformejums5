# FROM python:3.11-slim

# WORKDIR /app

# # Install system dependencies
# RUN apt-get update && apt-get install -y \
#     postgresql-client \
#     libpq-dev \
#     gcc \
#     python3-dev \
#     libjpeg-dev \
#     zlib1g-dev \
#     && rm -rf /var/lib/apt/lists/*

# # Copy requirements first
# COPY requirements.txt .
# RUN pip install --no-cache-dir -r requirements.txt

# # Copy project files
# COPY . .

# # Create directory for static files
# RUN mkdir -p kvitsapp/static/images

# # Set permissions
# RUN chmod -R 755 kvitsapp/static/images

# # Run server
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

# .devcontainer/Dockerfile
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install minimal required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workspace

# Create vscode user with correct permissions
RUN useradd -m -s /bin/bash -u 1000 vscode && \
    chown -R vscode:vscode /workspace && \
    chmod -R 775 /workspace

# Switch to vscode user
USER vscode

# Copy requirements and install dependencies
COPY --chown=vscode:vscode requirements.txt .
RUN pip install --user --upgrade pip && pip install --user -r requirements.txt



# docker-compose down
# docker-compose up --build

#docker-compose restart

# # Stop everything
# docker-compose down -v

# # Clean Docker system
# docker system prune -a --volumes

# # Rebuild and start
# docker-compose up --build -d

# # Run migrations
# docker-compose exec web python manage.py migrate

# # Create superuser
# docker-compose exec web python manage.py createsuperuser

# # Import products
# docker-compose exec web python manage.py import_products