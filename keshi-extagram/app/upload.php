<?php
if (!empty($_POST["post"])) {

    $photoid;
    if(!empty($_FILES['photo']['name'])){
        $photoid = uniqid();
        move_uploaded_file($_FILES['photo']['tmp_name'], 'uploads/' . $photoid);
    }
    $db = new mysqli("db.extagram.edt", "extagram_admin", "pass123", "extagram_db");
    $stmt = $db->prepare("INSERT INTO posts VALUES(?,?)");
    $stmt->bind_param("ss", $_POST["post"], $photoid);
    $stmt->execute();
    $stmt->close();
}

header("location: /");
?>
