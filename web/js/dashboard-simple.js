/**
 * Simple Dashboard JavaScript
 * Minimal functionality for sidebar and dropdowns
 */

// Toggle sidebar dropdown (đóng dropdown khác, mở/đóng dropdown hiện tại)
function toggleDropdown(element) {
    const dropdown = element.closest('.sidebar-dropdown');
    const menu = dropdown ? dropdown.querySelector('.sidebar-dropdown-menu') : null;
    const isOpen = dropdown && dropdown.classList.contains('open');

    document.querySelectorAll('.sidebar-dropdown.open').forEach(function(openDropdown) {
        if (openDropdown !== dropdown) {
            openDropdown.classList.remove('open');
            const openMenu = openDropdown.querySelector('.sidebar-dropdown-menu');
            if (openMenu) openMenu.style.display = 'none';
        }
    });

    if (dropdown && menu) {
        if (isOpen) {
            dropdown.classList.remove('open');
            menu.style.display = 'none';
            element.setAttribute('aria-expanded', 'false');
        } else {
            dropdown.classList.add('open');
            menu.style.display = 'block';
            element.setAttribute('aria-expanded', 'true');
        }
    }
}

// Toggle sidebar on mobile
function toggleSidebar() {
    const sidebar = document.getElementById('sideMenu');
    if (sidebar) {
        sidebar.classList.toggle('show');
    }
}

// Close sidebar when clicking outside on mobile
document.addEventListener('click', function(event) {
    const sidebar = document.getElementById('sideMenu');
    const toggle = document.querySelector('.sidebar-toggle');
    
    if (sidebar && toggle) {
        if (!sidebar.contains(event.target) && !toggle.contains(event.target)) {
            sidebar.classList.remove('show');
        }
    }
});

// Auto-close dropdowns when clicking outside
document.addEventListener('click', function(event) {
    if (!event.target.closest('.sidebar-dropdown')) {
        document.querySelectorAll('.sidebar-dropdown.open').forEach(function(dropdown) {
            dropdown.classList.remove('open');
        });
    }
});

// Highlight active menu item theo URL hiện tại
(function() {
    const currentPath = window.location.pathname;
    document.querySelectorAll('#sideMenu .sidebar-item[href]').forEach(function(item) {
        const href = item.getAttribute('href');
        if (!href) return;
        const linkPath = href.indexOf('http') === 0 ? new URL(href).pathname : href.split('?')[0];
        if (currentPath === linkPath || (linkPath.length > 1 && currentPath.indexOf(linkPath) !== -1)) {
            item.classList.add('active');
        }
    });
})();

// Show toast notification (optional)
function showToast(message, type = 'info') {
    console.log(`[${type.toUpperCase()}] ${message}`);
    // You can add Bootstrap toast here if needed
}

console.log('Dashboard scripts loaded successfully');
