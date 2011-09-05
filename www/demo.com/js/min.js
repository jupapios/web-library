function checkEmail(val) {
    if (val == '' || val.indexOf('@') == -1 || val.indexOf('.') == -1) {
        return false;
    }
    return /[a-zA-Z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-zA-Z0-9!#$%&'*+\/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-z0-9])?\.)+(?:[A-Za-z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum|cat|coop|pro|tel|int)\b/.test(val.toLowerCase());
}
function sign_in() {
    if (!checkEmail($('field0_1').value)) {
		$('field0_1').addClass('rounded_error');
        return false;
    } else if ($('field0_2').value.trim() == '') {
		$('field0_1').removeClass('rounded_error');
		$('field0_2').addClass('rounded_error');
        return false;
    }
    $('field0_1').removeClass('rounded_error');
    $('field0_2').removeClass('rounded_error');
    dologin();
}

function sign_up() {
	if ($('field1_0').value.trim() == '') {
		$('field1_0').addClass('rounded_error');
        return false;
    } else if (!checkEmail($('field1_1').value)) {
		$('field1_0').removeClass('rounded_error');
		$('field1_1').addClass('rounded_error');
        return false;
    } else if ($('field1_2').value.trim() == '') {
		$('field1_1').removeClass('rounded_error');
		$('field1_2').addClass('rounded_error');
        return false;
    }
    $('field1_0').removeClass('rounded_error');
    $('field1_1').removeClass('rounded_error');
    $('field1_2').removeClass('rounded_error');
    doregister();
}

function forgot_pass() {
	if (!checkEmail($('field2_0').value)) {
		$('field2_0').addClass('rounded_error');
        return false;
    }
	$('field2_0').removeClass('rounded_error');
	doforgot();
}

function create_note() {
	if ($('note').value.trim() == '') {
                $('note').addClass('rounded_error');
        	return false;
    	}
	createnote();
}
