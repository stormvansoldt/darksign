<!DOCTYPE html>
<html>
<head>
  <style>
    body { 
      background-repeat: no-repeat;
      background-color: #99ffff;
    }

    img {
      width: 300px;
      height: auto;
    }

    input {
      text-align: center;
    }

    table {
      border: 1;
      border-collapse: collapse;
      color: black;
      border: 2px solid black;
    }

    td {
    }

    .footer {
      position: fixed;
      text-align: center;
      bottom: 0px;
      width: 100%;
    }
  </style>
</head>
<body>
  <form action="submit.php" method="POST">
    <!-- INSERT CONTENT HERE -->
    <input type="submit" text="Submit" name="submit" id="submit">
  </form>
  <div class="footer">
    <img src="darksign_logo.png">
  </div>
</body>
</html>