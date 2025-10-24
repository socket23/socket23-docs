// Socket23 Custom JavaScript

document.addEventListener('DOMContentLoaded', function() {
  
  // Add copy button functionality enhancement
  enhanceCopyButtons();
  
  // Add external link indicators
  markExternalLinks();
  
  // Add scroll progress indicator
  addScrollProgress();
  
  // Add last updated timestamp
  addLastUpdated();
  
  // Initialize security badges
  initSecurityBadges();
  
});

/**
 * Enhance copy buttons with feedback
 */
function enhanceCopyButtons() {
  const copyButtons = document.querySelectorAll('.md-clipboard');
  
  copyButtons.forEach(button => {
    button.addEventListener('click', function() {
      const originalTitle = button.getAttribute('title');
      button.setAttribute('title', 'Copied!');
      
      setTimeout(() => {
        button.setAttribute('title', originalTitle);
      }, 2000);
    });
  });
}

/**
 * Mark external links with an icon
 */
function markExternalLinks() {
  const links = document.querySelectorAll('.md-content a[href^="http"]');
  
  links.forEach(link => {
    if (!link.hostname.includes(window.location.hostname)) {
      link.setAttribute('target', '_blank');
      link.setAttribute('rel', 'noopener noreferrer');
      
      // Add external link icon
      if (!link.querySelector('.external-link-icon')) {
        const icon = document.createElement('span');
        icon.className = 'external-link-icon';
        icon.innerHTML = ' ↗';
        icon.style.fontSize = '0.8em';
        icon.style.opacity = '0.6';
        link.appendChild(icon);
      }
    }
  });
}

/**
 * Add scroll progress indicator
 */
function addScrollProgress() {
  // Create progress bar
  const progressBar = document.createElement('div');
  progressBar.id = 'scroll-progress';
  progressBar.style.cssText = `
    position: fixed;
    top: 0;
    left: 0;
    width: 0%;
    height: 3px;
    background: linear-gradient(90deg, #1976d2, #3f51b5);
    z-index: 1000;
    transition: width 0.1s ease;
  `;
  document.body.appendChild(progressBar);
  
  // Update progress on scroll
  window.addEventListener('scroll', function() {
    const windowHeight = window.innerHeight;
    const documentHeight = document.documentElement.scrollHeight - windowHeight;
    const scrolled = window.scrollY;
    const progress = (scrolled / documentHeight) * 100;
    
    progressBar.style.width = progress + '%';
  });
}

/**
 * Add last updated timestamp to footer
 */
function addLastUpdated() {
  const footer = document.querySelector('.md-footer-meta');
  
  if (footer && !document.getElementById('last-updated')) {
    const lastUpdated = document.createElement('div');
    lastUpdated.id = 'last-updated';
    lastUpdated.style.cssText = `
      text-align: center;
      padding: 1em;
      font-size: 0.8em;
      opacity: 0.7;
    `;
    lastUpdated.innerHTML = `Last updated: ${new Date().toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    })}`;
    
    footer.appendChild(lastUpdated);
  }
}

/**
 * Initialize security severity badges
 */
function initSecurityBadges() {
  // Look for severity indicators in content
  const content = document.querySelector('.md-content');
  
  if (content) {
    // Replace severity text with styled badges
    const severityPatterns = [
      { pattern: /\[CRITICAL\]/gi, class: 'severity-critical', text: 'CRITICAL' },
      { pattern: /\[HIGH\]/gi, class: 'severity-high', text: 'HIGH' },
      { pattern: /\[MEDIUM\]/gi, class: 'severity-medium', text: 'MEDIUM' },
      { pattern: /\[LOW\]/gi, class: 'severity-low', text: 'LOW' }
    ];
    
    severityPatterns.forEach(({ pattern, class: className, text }) => {
      const walker = document.createTreeWalker(
        content,
        NodeFilter.SHOW_TEXT,
        null,
        false
      );
      
      const nodesToReplace = [];
      let node;
      
      while (node = walker.nextNode()) {
        if (pattern.test(node.textContent)) {
          nodesToReplace.push(node);
        }
      }
      
      nodesToReplace.forEach(node => {
        const span = document.createElement('span');
        span.className = className;
        span.textContent = text;
        
        const newContent = node.textContent.replace(pattern, '');
        const parent = node.parentNode;
        
        if (newContent.trim()) {
          parent.insertBefore(document.createTextNode(newContent), node);
        }
        parent.insertBefore(span, node);
        parent.removeChild(node);
      });
    });
  }
}

/**
 * Add smooth scroll to anchor links
 */
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
  anchor.addEventListener('click', function (e) {
    const href = this.getAttribute('href');
    if (href !== '#') {
      e.preventDefault();
      const target = document.querySelector(href);
      if (target) {
        target.scrollIntoView({
          behavior: 'smooth',
          block: 'start'
        });
      }
    }
  });
});

/**
 * Add keyboard shortcuts
 */
document.addEventListener('keydown', function(e) {
  // Ctrl/Cmd + K to focus search
  if ((e.ctrlKey || e.metaKey) && e.key === 'k') {
    e.preventDefault();
    const searchInput = document.querySelector('.md-search__input');
    if (searchInput) {
      searchInput.focus();
    }
  }
  
  // Escape to close search
  if (e.key === 'Escape') {
    const searchInput = document.querySelector('.md-search__input');
    if (searchInput && document.activeElement === searchInput) {
      searchInput.blur();
    }
  }
});

console.log('Socket23 Documentation - Enhanced features loaded');

