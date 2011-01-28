<?php
if ($db_con = mysql_connect('localhost:/tmp/mysql50.sock','ra100_scifi_guide_net','90ra10058')) {
    mysql_select_db("ra100_scifi_guide_net", $db_con);
}
else {
    echo "Chyba pripojenia na databazu";
    exit(0);
}
if (isset($_GET['page'])) {
    $page=$_GET['page'];
} else {
    $page=0;
};
session_start();
$limit = 5;
$offset = $page*$limit;
$select='SELECT * FROM VB_guestbook;';
$res=mysql_query($select);
$rowcount = mysql_num_rows($res);
$select='SELECT * FROM VB_guestbook ORDER BY `time` DESC LIMIT '.$limit.' OFFSET '.$offset.';';
$res=mysql_query($select);
echo '<?xml version="1.0" encoding="UTF-8"?>';
echo "<data>";
echo "<rowcount>";
echo $rowcount;
echo "</rowcount>";
while ($row=mysql_fetch_assoc($res)) {
    echo "<comment>";
    echo "<time>".$row['time']."</time>";
    echo "<name>".$row['name']."</name>";
    echo "<text>".$row['text']."</text>";
    echo "</comment>";
};
echo "</data>";
mysql_close($db_con);
?>

