
<footer>
    <div class="environment"></div>
    <div class="copyrights">
        <p>&copy; <?= date('Y') ?> Controle Financeiro Pessoal.</p>
    </div>
</footer>

<!-- SCRIPTS -->
<script {csp-script-nonce}>
    document.getElementById("menuToggle").addEventListener('click', toggleMenu);
    function toggleMenu() {
        var menuItems = document.getElementsByClassName('menu-item');
        for (var i = 0; i < menuItems.length; i++) {
            var menuItem = menuItems[i];
            menuItem.classList.toggle("hidden");
        }
    }
</script>
</body>
</html>
