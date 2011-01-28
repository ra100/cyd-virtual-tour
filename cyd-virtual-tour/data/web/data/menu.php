<ul class="top-menu">
<li <?php if ($obsah == "uvod") echo 'class="selected"';?>>
<a href="index.php?obsah=uvod">Brhlovce</a>
</li>
<li <?php if ($obsah == "history") echo 'class="selected"';?>>
<a href="index.php?obsah=history">Skalné obydlia</a>
</li>
<li <?php if ($obsah == "pano") echo 'class="selected"';?>>
<a href="index.php?obsah=pano">Virtuálna prehliadka</a>
</li>
<li <?php if ($obsah == "contact") echo 'class="selected"';?>>
<a href="index.php?obsah=contact">Kontakt</a>
</li>
<li <?php if ($obsah == "project") echo 'class="selected"';?>>
<a href="index.php?obsah=project">O projekte</a>
</li>
<li class="lang">
<a href="index.php?obsah=<?php echo $obsah;?>&lang=en"><img src="images/En.png" alt="English" /></a>
<a href="index.php?obsah=<?php echo $obsah;?>&lang=sk"><img src="images/Sk.png" alt="Slovensky" /></a>
</li>
<ul>