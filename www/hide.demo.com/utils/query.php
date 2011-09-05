<?php
function doquery($query) {
	require_once("/www/hide.demo.com/utils/data.php");
	$conn = &ADONewConnection($dbtype);
	$conn->PConnect("host=".$db[host]." user=".$db[user]." password=".$db[pass]." dbname=".$db[db]." ");
	$conn->SetFetchMode(ADODB_FETCH_ASSOC);
	$result = $conn->Execute($query);
	$conn->Close();
	return $result;
}
?>
