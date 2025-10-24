FROM --platform=linux/arm7 alpine:latest

# Install Python and pip
RUN apk add --no-cache python3 py3-pip

# Set working directory
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Build the documentation site
RUN mkdocs build

# Create non-root user for security
RUN adduser -D -s /bin/sh mkdocs
USER mkdocs

# Expose port 8000 (mkdocs default)
EXPOSE 8000

# Command to run the server
CMD ["mkdocs", "serve", "--dev-addr=0.0.0.0:8000"]
