<?php
include("/www/hide.demo.com/adodb5/adodb.inc.php");
require_once("/www/demo.com/pajax/PajaxRemote.class.php");
class Book extends PajaxRemote {
	function Book() {
		session_start();
	}
	function getbooks(){
		require_once("/www/hide.demo.com/utils/query.php");
	       	$result = doquery("SELECT * FROM getbooks(".$_SESSION["&user"].")");
	     	if(!($result))
	        	return 0;
		while($row=$result->FetchRow())
			$combo[]=array("id"=>$row["o_usersbooks_id"],"title"=>$row["o_title"],"author"=>$row["o_author"],"editorial"=>$row["o_editorial"],"description"=>$row["o_description"],"boughtdate"=>$row["o_boughtdate"],"lastvisit"=>$row["o_lastvisit"],"url"=>$row["o_url"]);
		return json_encode($combo);
	}
	function getbook($id){
		//$tmp = new Book;
		//$sections=$tmp->getsections($id);
		$sections = "";
		require_once("/www/hide.demo.com/utils/query.php");
	       	$result = doquery("SELECT * FROM getbook(".$id.")");
	     	if(!($result))
	        	return 0;
		$row=$result->FetchRow();

		$rslt="{id: '$id',title: '".$row["o_title"]."', access: 'public', pages: ".$row["o_pages"].", description: '".$row["o_description"]."', source: 'NaN', created_at: 'NanN', updated_at: 'NaN', canonical_url: 'book_full.html?id=".$id."', contributor: '".$row["o_author"]."', contributor_organization: '".$row["o_editorial"]."', resources: { text: 'http://s.demo.com/non.txt', thumbnail: 'http://s.demo.com/non.gif',  search: 'http://www.documentcloud.org/documents/7262/search.json?q={query}', page: { text: 'http://s.demo.com/texts/".$row["o_url"]."/{page}.txt', image: 'http://s.demo.com/books/".$row["o_url"]."/{page}-{size}.gif'} }, sections:[".$sections."] }";
		return $rslt;
	}

	function getsections($id) {
                require_once("/www/hide.demo.com/utils/query.php");
                $result = doquery("SELECT * FROM getsections(".$id.")");
                $sections="";
                if($result) {
                        while($row=$result->FetchRow()) {
                                if($sections=="")
                                        $sections = $sections ."{title: '".$row["o_title"]."', page: ".$row["o_page"]."}";
                                else
                                        $sections = $sections ." ,{title: '".$row["o_title"]."', page: ".$row["o_page"]."}";
			}
		}
		return $sections;
	}

	function createnote($id,$content) {
                require_once("/www/hide.demo.com/utils/query.php");
                $result = doquery("SELECT * FROM createnote(".$id.",'".$content."')");
                if(!($result))
                        return 0;
                while($row=$result->FetchRow())
                        $combo[]=array("id"=>$row["o_note_id"],"title"=>$row["o_title"],"content"=>$row["o_content"]);
                return json_encode($combo);
	}

        function getnotes($id) {
                require_once("/www/hide.demo.com/utils/query.php");
                $result = doquery("SELECT * FROM getnotes(".$id.")");
                if(!($result))
                        return 0;
                while($row=$result->FetchRow())
                        $combo[]=array("id"=>$row["o_note_id"],"title"=>$row["o_title"],"content"=>$row["o_content"]);
                return json_encode($combo);
        }

        function listnotes() {
                require_once("/www/hide.demo.com/utils/query.php");
                $result = doquery("SELECT * FROM listnotes(".$_SESSION["&user"].")");
                if(!($result))
                        return 0;
                while($row=$result->FetchRow())
                        $combo[]=array("title"=>$row["o_title"],"book"=>$row["o_book"]);
                return json_encode($combo);
        }

	function generatehtml() {
                require_once("/www/hide.demo.com/utils/query.php");
                $result = doquery("SELECT * FROM listnotes(".$_SESSION["&user"].")");
		$html = "<html><body>";
                if(!($result))
                        return 0;
                while($row=$result->FetchRow())
                        $html = $html ."<h1>".$row["o_title"]."</h1><br/><h3>".$row["o_book"]."</h3><br/><br/>".$row["o_content"]."<br/></br>";
		$html = $html."</body></html>";
		return $html;
	}
}
?>
