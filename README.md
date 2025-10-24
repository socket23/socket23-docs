# Socket23 Cybersecurity Documentation

This is a lightweight, secure documentation site for cybersecurity infrastructure projects and research findings, built with MkDocs and deployed via Docker Swarm on ARM7 architecture.

## Features

- Modern, responsive design using Material theme
- Lightweight static site generation
- Secure container deployment
- Docker Swarm compatible
- Load balancing ready
- ARM7 architecture support

## Architecture

The documentation site is built using:
- MkDocs for static site generation
- Material theme for modern UI
- Alpine Linux base image for security and size
- Python 3 for build process

## Deployment

### Prerequisites
- Docker Swarm cluster with ARM7 nodes
- Traefik or compatible load balancer configured
- External network named `traefik-network`

### Deploying to Docker Swarm

1. Initialize swarm (if not already done):
   ```bash
   docker swarm init
   ```

2. Create the external network:
   ```bash
   docker network create --driver overlay traefik-network
   ```

3. Deploy the stack:
   ```bash
   docker stack deploy -c docker-compose.yml socket23-docs
   ```

## Security Considerations

- Uses non-root user inside containers
- Minimal base image (Alpine Linux)
- Read-only file system where possible
- HTTPS enforced via Traefik with Let's Encrypt
- Resource limits to prevent resource exhaustion

## Adding New Content

To add new pages:
1. Create a new markdown file in the `docs/` directory
2. Add the page to the navigation in `mkdocs.yml`
3. Redeploy the stack

## Development

For local development:
```bash
mkdocs serve
```

This will start a development server at http://localhost:8000
>>>>>>> master
# Socket23 Cybersecurity Documentation

This is a lightweight, secure documentation site for cybersecurity infrastructure projects and research findings, built with MkDocs and deployed via Docker Swarm on ARM7 architecture.

## Features

- Modern, responsive design using Material theme
- Lightweight static site generation
- Secure container deployment
- Docker Swarm compatible
- Load balancing ready
- ARM7 architecture support

## Architecture

The documentation site is built using:
- MkDocs for static site generation
- Material theme for modern UI
- Alpine Linux base image for security and size
- Python 3 for build process

## Deployment

### Prerequisites
- Docker Swarm cluster with ARM7 nodes
- Traefik or compatible load balancer configured
- External network named `traefik-network`

### Deploying to Docker Swarm

1. Initialize swarm (if not already done):
   ```bash
   docker swarm init
   ```

2. Create the external network:
   ```bash
   docker network create --driver overlay traefik-network
   ```

3. Deploy the stack:
   ```bash
   docker stack deploy -c docker-compose.yml socket23-docs
   ```

## Security Considerations

- Uses non-root user inside containers
- Minimal base image (Alpine Linux)
- Read-only file system where possible
- HTTPS enforced via Traefik with Let's Encrypt
- Resource limits to prevent resource exhaustion

## Adding New Content

To add new pages:
1. Create a new markdown file in the `docs/` directory
2. Add the page to the navigation in `mkdocs.yml`
3. Redeploy the stack

## Development

For local development:
```bash
mkdocs serve
```

This will start a development server at http://localhost:8000
=======
# Socket23 Cybersecurity Documentation

This is a lightweight, secure documentation site for cybersecurity infrastructure projects and research findings, built with MkDocs and deployed via Docker Swarm on ARM7 architecture.

## Features

- Modern, responsive design using Material theme
- Lightweight static site generation
- Secure container deployment
- Docker Swarm compatible
- Load balancing ready
- ARM7 architecture support

## Architecture

The documentation site is built using:
- MkDocs for static site generation
- Material theme for modern UI
- Alpine Linux base image for security and size
- Python 3 for build process

## Deployment

### Prerequisites
- Docker Swarm cluster with ARM7 nodes
- Traefik or compatible load balancer configured
- External network named `traefik-network`

### Deploying to Docker Swarm

1. Initialize swarm (if not already done):
   ```bash
   docker swarm init
   ```

2. Create the external network:
   ```bash
   docker network create --driver overlay traefik-network
   ```

3. Deploy the stack:
   ```bash
   docker stack deploy -c docker-compose.yml socket23-docs
   ```

## Security Considerations

- Uses non-root user inside containers
- Minimal base image (Alpine Linux)
- Read-only file system where possible
- HTTPS enforced via Traefik with Let's Encrypt
- Resource limits to prevent resource exhaustion

## Adding New Content

To add new pages:
1. Create a new markdown file in the `docs/` directory
2. Add the page to the navigation in `mkdocs.yml`
3. Redeploy the stack

## Development

For local development:
```bash
mkdocs serve
```

This will start a development server at http://localhost:8000
>>>>>>> master
