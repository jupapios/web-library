<?php
require_once("dompdf_config.inc.php");
require_once("/www/hide.demo.com/utils/query.php");
$result = doquery("SELECT * FROM getnotes(".$id.")");
if(!($result))
return 0;
$html = "<html><body>"
while($row=$result->FetchRow())
	$html = $html ."<h1>".$row["o_title"]."</h1><br>".$row["o_content"]."<br><br>";
$html = $html." </body></html>"
$dompdf = new DOMPDF();
$dompdf->load_html($html);
$dompdf->render();
$dompdf->stream("sample.pdf");

?>
