<?php
if (isset($_GET['text'])) {
    if ($db_con = mysql_connect('localhost:/tmp/mysql50.sock','ra100_scifi_guide_net','90ra10058')) {
        mysql_select_db("ra100_scifi_guide_net", $db_con);
    }
    else {
        echo "Chyba pripojenia na databazu";
        exit(0);
    }
    session_start();
    mysql_set_charset("utf8");
    $name = $_GET['name'];
    if (strlen($name) == 0) $name = "anonymous";
    $text = $_GET['text'];
    $text = utf8_encode($text);
    $text = mysql_real_escape_string($text);
    $name = utf8_encode($name);
    $name = mysql_real_escape_string($name);
    $select='INSERT INTO VB_guestbook(`time`,`name`,`text`) VALUES ("'.date("Y-m-d H:i:s").'","'.$name.'","'.$text.'");';
    $res=mysql_query($select);
    echo $select;
    echo "<br/>";
    echo "OK";
    mysql_close($db_con);
}
?>