<?php
$dsn = 'mysql:dbname=push_de_akushu;host=localhost';
$user = 'root';
$password = '';

try{
    $dbh = new PDO($dsn, $user, $password);
    $sql = 'select * from message;';
	$messages = array();
	while ($row = mysql_fetch_object($query)) {
 		$messages[] = array(
    		'id'=> $row->id
    		,'msg' => $row->name
    	);
	}
}catch (PDOException $e){
    print('Error:'.$e->getMessage());
    die();
}

header('Content-type: application/json');
echo json_encode($messages);

?>