<?php
if (isset($_GET['duration'])) {
    if ($db_con = mysql_connect('localhost:/tmp/mysql50.sock','ra100_scifi_guide_net','90ra10058')) {
        mysql_select_db("ra100_scifi_guide_net", $db_con);
    }
    else {
        echo "Chyba pripojenia na databazu";
        exit(0);
    }
    session_start();
    $duration = $_GET['duration'];
    $trace = $_GET['trace'];
    $select='INSERT INTO VB_visitors(`date`,`duration`,`trace`,`helper`) VALUES ("'.date("Y-m-d H:i:s").'",'.$duration.',"'.$trace.'","")';
    $res=mysql_query($select);
    echo $select;
    echo "<br/>";
    echo "OK";
    mysql_close($db_con);
}
?>
