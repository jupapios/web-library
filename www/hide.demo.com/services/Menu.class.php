<?php
include("/www/hide.demo.com/adodb5/adodb.inc.php");
require_once("/www/demo.com/pajax/PajaxRemote.class.php");
class Menu extends PajaxRemote {
	function Menu() {
		session_start();
	}
	function getmenu(){
		        require_once("/www/hide.demo.com/utils/query.php");
	                $result = doquery("SELECT o_name FROM getuser(".$_SESSION["&user"].")");
	                if(!($result))
	                        return 0;
	                $row=$result->FetchRow();
	                $rslt="<nav>
				<ul class='parentmenu'>
			        <li><img src='img/portraits/d.30.jpg' id='menudo_portrait' width='24' height='24' alt='Usuario'/></li>
	
			        <li>
			        <a class='label'>".$row['o_name']."</a>
		                <ul class='childmenu' id='first'>
		                        <li><a href='main.html'>Inicio</a></li>
		                        <li><a href='options.html'>Opciones</a></li>
		                        <li><a href='logout.html' id='logout'>Salir</a></li>
		                        <li></li>
		                        <li></li>
		                </ul>
		        </li>
		
		        <li>
		        <a class='label'>Mi Bilioteca</a>
		                <ul class='childmenu'>
		                        <li><a href='books_all.html'>Todos</a></li>
		                        <li><a href='notes.html'>Mis notas</a></li>
		                        <li></li>
		                </ul>
		        </li>
		
		        <li>
		        <a class='label'>Libreria</a>
		                <ul class='childmenu'>
		                        <li><a href='http://buy.demo.com'>Comprar</a></li>
		                        <li></li>
		                </ul>
		        </li>
		
		        <li>
		        <div class='menu_image'>
		        <input class='field' autocomplete='off' maxlength='50'/>
		        </div>
		        </li>
			</ul>
			</nav>";
	                return $rslt;
	}
}
?>
