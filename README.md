# Socket23 Cybersecurity Documentation

This is a lightweight, secure documentation site for cybersecurity infrastructure projects and research findings, built with MkDocs and deployed via Docker Swarm on ARM architecture.

## Features

- Modern, responsive design using Material theme
- Lightweight static site generation
- Secure container deployment
- Docker Swarm compatible
- Load balancing ready
- ARM architecture support (ARMv7/ARM64)
- Automated CI/CD ready
- SEO optimized

## Architecture

The documentation site is built using:
- **MkDocs** for static site generation
- **Material for MkDocs** theme for modern UI
- **Alpine Linux** base image for security and minimal size
- **Python 3** for build process
- **Docker Swarm** for orchestration
- **Traefik** for reverse proxy and SSL termination

## Quick Start

### Local Development

1. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

2. Start development server:
   ```bash
   mkdocs serve
   ```

3. Open http://localhost:8000 in your browser

### Building Locally

```bash
mkdocs build
```

This generates static files in the `site/` directory.

## Deployment

### Prerequisites
- Docker Swarm cluster with ARM nodes
- Traefik or compatible load balancer configured
- External network named `traefik-network`

### Building Docker Image

For ARM architecture (Raspberry Pi, etc.):
```bash
./build.sh
```

For Windows:
```powershell
./build.ps1
```

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

4. Verify deployment:
   ```bash
   docker service ls
   docker service logs socket23-docs_mkdocs
   ```

### Updating the Deployment

```bash
docker service update --force socket23-docs_mkdocs
```

## Security Considerations

- ✅ Non-root user inside containers
- ✅ Minimal base image (Alpine Linux)
- ✅ Read-only file system where possible
- ✅ HTTPS enforced via Traefik with Let's Encrypt
- ✅ Resource limits to prevent resource exhaustion
- ✅ No unnecessary packages or dependencies
- ✅ Regular security updates via base image updates

## Adding New Content

To add new pages:

1. Create a new markdown file in the `docs/` directory
2. Add the page to the navigation in `mkdocs.yml`
3. Test locally with `mkdocs serve`
4. Commit and redeploy the stack

## Project Structure

```
socket23-docs/
├── docs/               # Documentation content
│   ├── index.md       # Homepage
│   ├── projects.md    # Projects page
│   ├── research.md    # Research findings
│   ├── tools.md       # Tools documentation
│   └── about.md       # About page
├── Dockerfile         # Container definition
├── docker-compose.yml # Swarm deployment config
├── mkdocs.yml        # MkDocs configuration
├── requirements.txt  # Python dependencies
├── build.sh          # Build script (Linux/Mac)
└── build.ps1         # Build script (Windows)
```

## Troubleshooting

### Container won't start
Check logs: `docker service logs socket23-docs_mkdocs`

### Port already in use
Modify the port mapping in `docker-compose.yml`

### Build fails
Ensure Docker buildx is installed and configured for multi-platform builds

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test locally
5. Submit a pull request

## License

This project is maintained by Socket23 for cybersecurity research and documentation purposes.

## Contact

- Email: research@socket23.com
- Website: https://socket23.com
