# Multi-stage build for smaller final image
FROM --platform=${BUILDPLATFORM:-linux/arm/v7} python:3.11-alpine AS builder

# Install build dependencies
RUN apk add --no-cache \
    gcc \
    musl-dev \
    libffi-dev \
    openssl-dev \
    cargo

# Set working directory
WORKDIR /build

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

# Copy application code
COPY . .

# Build the documentation site
RUN /root/.local/bin/mkdocs build --strict

# Final stage - minimal runtime image
FROM --platform=${TARGETPLATFORM:-linux/arm/v7} python:3.11-alpine

# Install runtime dependencies only
RUN apk add --no-cache \
    wget \
    ca-certificates \
    && rm -rf /var/cache/apk/*

# Create non-root user for security
RUN addgroup -g 1000 mkdocs && \
    adduser -D -u 1000 -G mkdocs -s /bin/sh mkdocs

# Set working directory
WORKDIR /app

# Copy Python packages from builder
COPY --from=builder /root/.local /home/mkdocs/.local

# Copy application code and built site
COPY --chown=mkdocs:mkdocs . .
COPY --from=builder --chown=mkdocs:mkdocs /build/site ./site

# Update PATH for user-installed packages
ENV PATH=/home/mkdocs/.local/bin:$PATH

# Switch to non-root user
USER mkdocs

# Expose port 8000 (mkdocs default)
EXPOSE 8000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:8000 || exit 1

# Command to run the server
CMD ["mkdocs", "serve", "--dev-addr=0.0.0.0:8000", "--no-livereload"]
