# Build and push Docker image for ARM7 architecture
Write-Host "Building Docker image for ARM7 architecture..."

# Build the image with platform specified
docker buildx build --platform linux/arm7 -t socket23/mkdocs:latest -f Dockerfile . --push

Write-Host "Docker image built and pushed successfully!"
