<!DOCTYPE html>
<link rel="stylesheet" href="https://static.extagram.edt/style.css">

<form method="POST" enctype="multipart/form-data" action="upload">
    <input type="text" name="post" placeholder="Write something...">
    <input id="file" type="file" name="photo" onchange="document.getElementById('preview').src=window.URL.createObjectURL(event.target.files[0])">
    <label for="file">
        <img id="preview" src="https://static.extagram.edt/preview.svg">
    </label>
    <input type="submit" value="Publish">
</form>
<?php
$db = new mysqli("db.extagram.edt", "extagram_admin", "pass123", "extagram_db");

foreach ($db->query("SELECT * FROM posts") as $fila) {
    echo "<div class='post'>";
    echo "<p>".$fila['post']."</p>";
    if (!empty($fila['photourl'])) {
            echo "<img src='https://storage.extagram.edt/".$fila['photourl']."'>";
    }
    echo "</div>";
}
?>
