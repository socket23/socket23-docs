# Contributing to Socket23 Documentation

Thank you for your interest in contributing to Socket23's cybersecurity documentation! This guide will help you get started.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [How to Contribute](#how-to-contribute)
- [Documentation Standards](#documentation-standards)
- [Development Workflow](#development-workflow)
- [Submitting Changes](#submitting-changes)

## Code of Conduct

By participating in this project, you agree to maintain a respectful and professional environment. We expect all contributors to:

- Be respectful and inclusive
- Focus on constructive feedback
- Prioritize security and accuracy in all contributions
- Respect confidentiality and responsible disclosure practices

## Getting Started

### Prerequisites

- Python 3.11 or higher
- Git
- Docker (optional, for container testing)
- Text editor or IDE

### Setting Up Your Development Environment

1. **Fork and clone the repository**

   ```bash
   git clone https://github.com/YOUR_USERNAME/socket23-docs.git
   cd socket23-docs
   ```

2. **Install dependencies**

   ```bash
   # Using Make (recommended)
   make install
   
   # Or manually
   pip install -r requirements.txt
   ```

3. **Start the development server**

   ```bash
   # Using Make
   make serve
   
   # Or manually
   mkdocs serve
   ```

4. **Open your browser**

   Navigate to http://localhost:8000 to see your changes in real-time.

## How to Contribute

### Reporting Issues

- Check existing issues before creating a new one
- Use clear, descriptive titles
- Include steps to reproduce (if applicable)
- Add relevant labels (bug, enhancement, documentation, etc.)

### Suggesting Enhancements

- Clearly describe the enhancement and its benefits
- Explain why this would be useful to the community
- Provide examples or mockups if possible

### Contributing Documentation

We welcome contributions in the following areas:

- **New research findings** - Share your cybersecurity research
- **Project documentation** - Document new tools or frameworks
- **Improvements** - Fix typos, clarify explanations, add examples
- **Security advisories** - Responsible disclosure of vulnerabilities

## Documentation Standards

### Writing Style

- **Clear and concise** - Use simple language, avoid jargon when possible
- **Technical accuracy** - Ensure all technical details are correct
- **Security-focused** - Always consider security implications
- **Well-structured** - Use proper headings, lists, and formatting

### Markdown Guidelines

- Use ATX-style headers (`#` instead of underlines)
- Include blank lines around headers, lists, and code blocks
- Use fenced code blocks with language identifiers
- Keep lines under 120 characters when possible

### Code Examples

```markdown
\`\`\`python
# Always include language identifier
# Add comments to explain complex code
def example_function():
    """Include docstrings for functions."""
    return "Hello, Socket23!"
\`\`\`
```

### Security Content

When documenting security vulnerabilities or exploits:

- **Never** include working exploits for unpatched vulnerabilities
- Follow responsible disclosure practices
- Include mitigation strategies
- Mark severity levels: `[CRITICAL]`, `[HIGH]`, `[MEDIUM]`, `[LOW]`
- Provide CVE references when applicable

Example:

```markdown
## Vulnerability: SQL Injection [HIGH]

**CVE:** CVE-2024-XXXXX

**Description:** Brief description of the vulnerability.

**Affected Versions:** 1.0.0 - 1.2.3

**Mitigation:**
- Upgrade to version 1.2.4 or higher
- Apply the security patch
- Implement input validation
```

## Development Workflow

### Branch Naming

- `feature/description` - New features or content
- `fix/description` - Bug fixes or corrections
- `docs/description` - Documentation improvements
- `security/description` - Security-related changes

### Commit Messages

Follow conventional commit format:

```
type(scope): brief description

Detailed explanation if needed.

Fixes #123
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

Examples:
```
docs(research): add zero trust architecture findings
fix(projects): correct IoT toolkit installation steps
feat(tools): add new network scanner documentation
```

## Submitting Changes

### Pull Request Process

1. **Create a feature branch**

   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**

   - Follow the documentation standards
   - Test locally with `make serve`
   - Ensure the build succeeds with `make build`

3. **Commit your changes**

   ```bash
   git add .
   git commit -m "docs(scope): description"
   ```

4. **Push to your fork**

   ```bash
   git push origin feature/your-feature-name
   ```

5. **Create a Pull Request**

   - Use a clear, descriptive title
   - Reference any related issues
   - Describe what changed and why
   - Add screenshots if relevant

### Pull Request Checklist

- [ ] Documentation builds without errors (`make build`)
- [ ] Changes are tested locally (`make serve`)
- [ ] Commit messages follow conventions
- [ ] No sensitive information included
- [ ] Security implications considered
- [ ] Links are valid and working
- [ ] Spelling and grammar checked

## Testing Your Changes

### Local Testing

```bash
# Build the documentation
make build

# Serve locally
make serve

# Run tests
make test
```

### Docker Testing

```bash
# Build Docker image
make docker-build

# Run container
make docker-run
```

## Questions?

If you have questions or need help:

- Open an issue with the `question` label
- Email: research@socket23.com
- Check existing documentation and issues first

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.

---

Thank you for contributing to Socket23! Your efforts help make cybersecurity knowledge more accessible to everyone.

