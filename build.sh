#!/bin/bash
set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
IMAGE_NAME="${IMAGE_NAME:-socket23/mkdocs}"
VERSION="${VERSION:-latest}"
PLATFORMS="${PLATFORMS:-linux/arm/v7,linux/arm64,linux/amd64}"
PUSH="${PUSH:-false}"

echo -e "${GREEN}=== Socket23 MkDocs Docker Build ===${NC}"
echo "Image: ${IMAGE_NAME}:${VERSION}"
echo "Platforms: ${PLATFORMS}"
echo "Push: ${PUSH}"
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo -e "${RED}Error: Docker is not installed${NC}"
    exit 1
fi

# Check if buildx is available
if ! docker buildx version &> /dev/null; then
    echo -e "${RED}Error: Docker buildx is not available${NC}"
    echo "Please install Docker buildx or use a newer version of Docker"
    exit 1
fi

# Create buildx builder if it doesn't exist
if ! docker buildx inspect socket23-builder &> /dev/null; then
    echo -e "${YELLOW}Creating buildx builder 'socket23-builder'...${NC}"
    docker buildx create --name socket23-builder --use
else
    echo -e "${YELLOW}Using existing buildx builder 'socket23-builder'${NC}"
    docker buildx use socket23-builder
fi

# Bootstrap the builder
echo -e "${YELLOW}Bootstrapping builder...${NC}"
docker buildx inspect --bootstrap

# Build arguments
BUILD_ARGS=(
    --platform "${PLATFORMS}"
    -t "${IMAGE_NAME}:${VERSION}"
    -t "${IMAGE_NAME}:latest"
    -f Dockerfile
    .
)

# Add push flag if enabled
if [ "${PUSH}" = "true" ]; then
    BUILD_ARGS+=(--push)
    echo -e "${YELLOW}Building and pushing Docker image...${NC}"
else
    BUILD_ARGS+=(--load)
    echo -e "${YELLOW}Building Docker image (local only)...${NC}"
fi

# Build the image
if docker buildx build "${BUILD_ARGS[@]}"; then
    echo ""
    echo -e "${GREEN}✓ Docker image built successfully!${NC}"
    echo "Image: ${IMAGE_NAME}:${VERSION}"

    if [ "${PUSH}" = "true" ]; then
        echo -e "${GREEN}✓ Image pushed to registry${NC}"
    else
        echo -e "${YELLOW}Note: Image built locally. Set PUSH=true to push to registry${NC}"
    fi
else
    echo -e "${RED}✗ Build failed${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}=== Build Complete ===${NC}"
echo ""
echo "Usage examples:"
echo "  docker run -p 8000:8000 ${IMAGE_NAME}:${VERSION}"
echo "  docker stack deploy -c docker-compose.yml socket23-docs"
