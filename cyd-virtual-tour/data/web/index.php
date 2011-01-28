<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
    <?php
    if (isset($_GET['obsah'])) $obsah=$_GET['obsah'];
    else $obsah="uvod";
    if (isset($_GET['lang'])) $lang=$_GET['lang'];
    else $lang="sk";
    ?>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title><?php
            if ($lang == "en") {
                echo "Virtual Brhlovce";
            }
            else echo "Virtuálne Brhlovce";?></title>
        <meta http-equiv="content-type"
              content="text/html;charset=utf-8" />
        <link rel="stylesheet" type="text/css" href="data/style.css" />
        <script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
    </head>
    <body>
        <div id="bokehtop">
            <div id="bokehbottom">
                <div id="main-container">
                    <div id="header">
                       <?php
                        if ($lang == "en") {
                            echo '<a href="index.php?obsah=uvod&lang=en"><img src="images/titleEn.png" class="title" alt="Vitual Brhlovce"/></a>';
                        }
                             else echo '<a href="index.php?obsah=uvod"><img src="images/titleSk.png" class="title" alt="Vitual Brhlovce"/></a>';?>
                    </div>
                    <div id="menu">
                        <?php
                        if ($lang == "en") {
                            require("data/menuEN.php");
                        }
                        else require("data/menu.php");?>
                    </div>
                    <div id="content">
                        <?php if ($lang == "en") {
                            require("data/".$obsah."En.php");
                        }
                        else require("data/".$obsah.".php");?>
                    </div>
                    <div id="content-footer"></div>
                    <div id="footer">Code and Design by
                        <a href="http://twitter.com/ra100">R@100</a></div>
                </div>
            </div>
        </div>
        <script src="data/slicker.js" type="text/javascript"></script>
    </body>
</html>
