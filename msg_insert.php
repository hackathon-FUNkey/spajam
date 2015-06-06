<?php
$dsn = 'mysql:dbname=push_de_akushu;host=localhost';
$user = 'root';
$password = '';

$msg = "こんばんわ";

try{
    $dbh = new PDO($dsn, $user, $password);
    $sql = 'insert into messages (msg) values ('. $msg .')';
    $stmt = $dbh->prepare($sql);
    $stmt->execute();
}catch (PDOException $e){
    print('Error:'.$e->getMessage());
    die();
}

?>