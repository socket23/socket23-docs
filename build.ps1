# Socket23 MkDocs Docker Build Script
# PowerShell version

param(
    [string]$ImageName = "socket23/mkdocs",
    [string]$Version = "latest",
    [string]$Platforms = "linux/arm/v7,linux/arm64,linux/amd64",
    [switch]$Push = $false
)

$ErrorActionPreference = "Stop"

# Configuration
Write-Host "=== Socket23 MkDocs Docker Build ===" -ForegroundColor Green
Write-Host "Image: $ImageName`:$Version"
Write-Host "Platforms: $Platforms"
Write-Host "Push: $Push"
Write-Host ""

# Check if Docker is installed
try {
    $null = docker --version
} catch {
    Write-Host "Error: Docker is not installed" -ForegroundColor Red
    exit 1
}

# Check if buildx is available
try {
    $null = docker buildx version
} catch {
    Write-Host "Error: Docker buildx is not available" -ForegroundColor Red
    Write-Host "Please install Docker buildx or use a newer version of Docker"
    exit 1
}

# Create buildx builder if it doesn't exist
$builderExists = docker buildx inspect socket23-builder 2>$null
if (-not $builderExists) {
    Write-Host "Creating buildx builder 'socket23-builder'..." -ForegroundColor Yellow
    docker buildx create --name socket23-builder --use
} else {
    Write-Host "Using existing buildx builder 'socket23-builder'" -ForegroundColor Yellow
    docker buildx use socket23-builder
}

# Bootstrap the builder
Write-Host "Bootstrapping builder..." -ForegroundColor Yellow
docker buildx inspect --bootstrap

# Build arguments
$buildArgs = @(
    "build",
    "--platform", $Platforms,
    "-t", "$ImageName`:$Version",
    "-t", "$ImageName`:latest",
    "-f", "Dockerfile",
    "."
)

# Add push flag if enabled
if ($Push) {
    $buildArgs += "--push"
    Write-Host "Building and pushing Docker image..." -ForegroundColor Yellow
} else {
    $buildArgs += "--load"
    Write-Host "Building Docker image (local only)..." -ForegroundColor Yellow
}

# Build the image
try {
    docker buildx @buildArgs
    Write-Host ""
    Write-Host "✓ Docker image built successfully!" -ForegroundColor Green
    Write-Host "Image: $ImageName`:$Version"

    if ($Push) {
        Write-Host "✓ Image pushed to registry" -ForegroundColor Green
    } else {
        Write-Host "Note: Image built locally. Use -Push flag to push to registry" -ForegroundColor Yellow
    }
} catch {
    Write-Host "✗ Build failed" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "=== Build Complete ===" -ForegroundColor Green
Write-Host ""
Write-Host "Usage examples:"
Write-Host "  docker run -p 8000:8000 $ImageName`:$Version"
Write-Host "  docker stack deploy -c docker-compose.yml socket23-docs"
