# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Comprehensive CI/CD pipeline with GitHub Actions
- Multi-platform Docker build support (ARM v7, ARM64, AMD64)
- Security scanning workflows (Trivy, CodeQL, TruffleHog, Hadolint)
- Dependabot configuration for automated dependency updates
- Makefile for convenient development commands
- Custom CSS and JavaScript for enhanced UI/UX
- Scroll progress indicator
- External link markers
- Security severity badges
- Enhanced Material theme configuration
- Dark/light mode toggle
- Navigation improvements (tabs, sections, search)
- Code copy buttons with feedback
- Keyboard shortcuts (Ctrl+K for search)
- Contributing guidelines (CONTRIBUTING.md)
- License file (MIT)
- EditorConfig for consistent coding styles
- Comprehensive .gitignore and .dockerignore files

### Changed
- Fixed critical README.md merge conflicts
- Corrected ARM architecture specification (arm7 → arm/v7)
- Enhanced Dockerfile with multi-stage build for smaller images
- Improved docker-compose.yml with proper Traefik labels
- Updated requirements.txt with pinned versions
- Enhanced build scripts with error handling and versioning
- Improved security with non-root user and minimal base image
- Better healthcheck using wget instead of curl

### Fixed
- Duplicate Traefik certresolver labels in docker-compose.yml
- Missing curl in Docker healthcheck
- Incorrect platform specification in Dockerfile
- Unresolved merge conflict markers in README.md

### Security
- Added comprehensive security scanning in CI/CD
- Implemented secret scanning with TruffleHog
- Added container vulnerability scanning with Trivy
- Dockerfile linting with Hadolint
- License compliance checking
- Daily automated security scans
- Security headers in Traefik configuration
- Read-only volumes in docker-compose.yml

## [1.0.0] - 2024-01-01

### Added
- Initial release
- MkDocs with Material theme
- Basic documentation structure
- Docker Swarm deployment configuration
- ARM7 architecture support
- Traefik integration

[Unreleased]: https://github.com/socket23/socket23-docs/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/socket23/socket23-docs/releases/tag/v1.0.0

