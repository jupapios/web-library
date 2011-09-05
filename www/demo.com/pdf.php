<?php
class pdf {
	function gethtml() {
		require_once("/www/hide.demo.com/services/Book.class.php");
		$book = new Book();
		return $book->generatehtml();
	}
	
	function getpdf($html) {
		require_once("/www/hide.demo.com/dompdf/dompdf_config.inc.php");
		
		  $dompdf = new DOMPDF();
		  $dompdf->load_html($html);
		  $dompdf->render();
		  $dompdf->stream("notas.pdf");
	}
}
$t = new pdf;
$t->getpdf($t->gethtml());
?>
