<?php
$dsn = 'mysql:dbname=push_de_akushu;host=localhost';
$user = 'root';
$password = '';

try{
    $dbh = new PDO($dsn, $user, $password);
    $sql = 'select * from messagea;';
	$messages = array();
	while ($row = mysql_fetch_object($sql) {
 		$messages[] = array(
    		'id'=> $row->id,
    		'msg' => $row->msg,
    	);
	}
}catch (PDOException $e){
    print('Error:'.$e->getMessage());
    die();
}

header('Content-type: application/json');
echo json_encode($messages);

?>