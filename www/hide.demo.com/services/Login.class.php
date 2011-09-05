<?php
include("/www/hide.demo.com/adodb5/adodb.inc.php");
require_once("/www/demo.com/pajax/PajaxRemote.class.php");
class Login extends PajaxRemote {
	function Login() {
		session_start();
	}
	function chkstate() {
		if (isset($_SESSION['&user']))
			return 1;
		return 0;
	}
	function dologin($user,$pass) {
		require_once("/www/hide.demo.com/utils/query.php");
		$crypt= mb_strtoupper(md5($user.":".$pass));
                $result = doquery("SELECT * FROM dologin('".$user."','".$crypt."')");
                if(!($result))
                        return 0;
                $row=$result->FetchRow();
                $rslt=$row["o_group"];
                $user_id=$row["o_user_id"];
		if($rslt!=0) {
			$_SESSION["&user"] = $user_id;
                } 
		return $rslt;
	}

	function doregister($name,$user,$pass) {
                require_once("/www/hide.demo.com/utils/query.php");
                $crypt= mb_strtoupper(md5($user.":".$pass));
                $result = doquery("SELECT * FROM doregister('".$name."','".$user."','".$crypt."')");
                if(!($result))
                        return 0;
                $row=$result->FetchRow();
                $rslt=$row["o_result"];
                return $rslt;
	}

	function doforgot($user) {
		//TODO
                return 0;
	}

	function logout(){
		session_destroy();
	}

}
?>
