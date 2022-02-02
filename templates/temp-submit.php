<?php
if ($_SERVER['REQUEST_METHOD'] === 'GET')
{
  header("Location: index.php");
  exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST')
{
  /* Database example:
  $db = new SQLite3('kiosk.db');
  $sql = $db->prepare('UPDATE names SET galaxy=:g WHERE row_num='.1);
  $sql->bindValue(':g', $_POST['galaxy']);
  $sql->execute();
  $db->close();
  */

  // If uploading a file, do some file security checks

  // When done, restart local pisignage player (restartPiSi() found in lib files)

  // echo a success message
}
?>