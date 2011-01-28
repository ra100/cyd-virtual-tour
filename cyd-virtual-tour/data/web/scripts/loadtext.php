<?php
	if (isset($_GET['name'])){
		if ($db_con = mysql_connect('localhost:/tmp/mysql50.sock','ra100_scifi_guide_net','90ra10058')) {mysql_select_db("ra100_scifi_guide_net", $db_con);}
		else {echo "Chyba pripojenia na databazu"; exit(0);}
		session_start();
		$name = $_GET['name'];
		$lang = $_GET['language'];
		$select='SELECT * FROM VB_text WHERE name="'.$name.'" AND language="'.$lang.'"';
		$res=mysql_query($select);
		$row=mysql_fetch_assoc($res);
		echo '<?xml version="1.0" encoding="UTF-8"?>';
		echo "<data>";
		echo "<title>".$row['title']."</title>";
		echo "<content>".$row['content']."</content>";	
		echo "</data>";
		mysql_close($db_con);
	}
?>

