# Quick Start Guide

Get up and running with Socket23 documentation in minutes!

## 🚀 For Local Development

### Prerequisites
- Python 3.11+
- Git

### Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/socket23/socket23-docs.git
   cd socket23-docs
   ```

2. **Install dependencies**
   ```bash
   make install
   # or: pip install -r requirements.txt
   ```

3. **Start development server**
   ```bash
   make serve
   # or: mkdocs serve
   ```

4. **Open in browser**
   - Navigate to http://localhost:8000
   - Changes auto-reload!

## 🐳 For Docker Development

### Prerequisites
- Docker
- Docker Buildx (for multi-platform builds)

### Steps

1. **Build the image**
   ```bash
   make docker-build
   # or: ./build.sh
   ```

2. **Run the container**
   ```bash
   make docker-run
   # or: docker run -p 8000:8000 socket23/mkdocs:latest
   ```

3. **Open in browser**
   - Navigate to http://localhost:8000

## ☁️ For Production Deployment

### Prerequisites
- Docker Swarm cluster
- Traefik configured
- External network `traefik-network`

### Steps

1. **Create external network** (if not exists)
   ```bash
   docker network create --driver overlay traefik-network
   ```

2. **Build and push image**
   ```bash
   PUSH=true ./build.sh
   ```

3. **Deploy to Swarm**
   ```bash
   make deploy-stack
   # or: docker stack deploy -c docker-compose.yml socket23-docs
   ```

4. **Check status**
   ```bash
   make deploy-status
   ```

## 📝 Common Tasks

### Add New Documentation Page

1. Create markdown file in `docs/`
   ```bash
   touch docs/my-new-page.md
   ```

2. Add to navigation in `mkdocs.yml`
   ```yaml
   nav:
     - Home: index.md
     - My New Page: my-new-page.md
   ```

3. Test locally
   ```bash
   make serve
   ```

### Update Dependencies

```bash
# Update requirements.txt with new versions
pip install --upgrade mkdocs mkdocs-material

# Freeze to requirements.txt
pip freeze > requirements.txt

# Test the build
make build
```

### Run Tests

```bash
make test
```

### Clean Build Artifacts

```bash
make clean
```

## 🔧 Useful Commands

| Command | Description |
|---------|-------------|
| `make help` | Show all available commands |
| `make install` | Install Python dependencies |
| `make build` | Build static site |
| `make serve` | Start dev server |
| `make clean` | Clean build artifacts |
| `make docker-build` | Build Docker image |
| `make deploy-stack` | Deploy to Swarm |
| `make deploy-logs` | View service logs |

## 🐛 Troubleshooting

### Port 8000 already in use
```bash
# Find and kill the process
lsof -ti:8000 | xargs kill -9

# Or use a different port
mkdocs serve -a localhost:8001
```

### Docker build fails
```bash
# Ensure buildx is installed
docker buildx version

# Create builder if needed
docker buildx create --name socket23-builder --use
```

### Dependencies not installing
```bash
# Upgrade pip first
python -m pip install --upgrade pip

# Then install requirements
pip install -r requirements.txt
```

### Changes not showing
```bash
# Hard refresh browser (Ctrl+Shift+R or Cmd+Shift+R)
# Or clear MkDocs cache
rm -rf site/
make build
```

## 📚 Next Steps

- Read [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines
- Check [IMPROVEMENTS.md](IMPROVEMENTS.md) for recent changes
- Review [README.md](README.md) for detailed documentation
- Explore the [Makefile](Makefile) for all available commands

## 💡 Tips

- Use `Ctrl+K` to quickly search documentation
- Enable dark mode with the theme toggle
- Code blocks have copy buttons - just hover and click
- External links open in new tabs automatically
- Scroll progress indicator shows reading progress

## 🆘 Need Help?

- Check existing [GitHub Issues](https://github.com/socket23/socket23-docs/issues)
- Read the [documentation](https://socket23.com)
- Email: research@socket23.com

---

Happy documenting! 🎉

