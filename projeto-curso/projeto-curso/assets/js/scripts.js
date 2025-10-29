
    const links = document.querySelectorAll('.image-link');
    const modals = document.querySelectorAll('.modal');
    const closeButtons = document.querySelectorAll('.close');

    links.forEach(link => {
        link.addEventListener('click', () => {
        const modalId = link.getAttribute('data-modal');
        document.getElementById(modalId).style.display = 'block';
        });
    });

    closeButtons.forEach(btn => {
        btn.addEventListener('click', () => {
        btn.closest('.modal').style.display = 'none';
        });
    });

    window.addEventListener('click', event => {
        modals.forEach(modal => {
        if (event.target === modal) {
            modal.style.display = 'none';
        }
        });
    });

document.getElementById("menuToggle").addEventListener('click', toggleMenu);
function toggleMenu() {
    var menuItems = document.getElementsByClassName('menu-item');
    for (var i = 0; i < menuItems.length; i++) {
        var menuItem = menuItems[i];
        menuItem.classList.toggle("hidden");
    }
}
