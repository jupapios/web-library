/* Author: Juan Pinilla */

$(document).ready(function() {
	$(".cloud").animate({right: $(document).width()}, 4*1000*10, "linear");
  $('#box_register').hide();
  $('#box_forgot').hide();

	$('article.register').click(function() {
		$('#box_login').hide();
		$('#box_forgot').hide();
		$('#box_register').show();
	});

	$('article.enter').click(function() {
		$('#box_register').hide();
		$('#box_forgot').hide();
		$('#box_login').show();
	});

	$('div.forgot').click(function() {
		$('#box_register').hide();
		$('#box_login').hide();
		$('#box_forgot').show();
	});
});

function checkEmail(val) {
    if (val == '' || val.indexOf('@') == -1 || val.indexOf('.') == -1) {
        return false;
    }
    return /[a-zA-Z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-zA-Z0-9!#$%&'*+\/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-z0-9])?\.)+(?:[A-Za-z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum|cat|coop|pro|tel|int)\b/.test(val.toLowerCase());
}

function sign_in() {
		var ans=0;
    if (!checkEmail($('#field0_1').val())) {
    $('#field0_1').addClass('rounded_error');
        ans += 1;
    } else {
			$('#field0_1').removeClass('rounded_error');
		}

		if ($('#field0_2').val().trim() == '') {
    $('#field0_2').addClass('rounded_error');
        ans += 1;
    } else {
			$('#field0_2').removeClass('rounded_error');
		}

    if(ans==0)
			dologin();
}

function sign_up() {
	var ans=0;
  if($('#field1_0').val() == '') {
    $('#field1_0').addClass('rounded_error');
        ans+=1;
  } else {
    $('#field1_0').removeClass('rounded_error');
	}

	if (!checkEmail($('#field1_1').val())) {
    $('#field1_1').addClass('rounded_error');
    	ans+=1;
  } else {
    $('#field1_1').removeClass('rounded_error');
	}

	if ($('#field1_2').val().trim() == '') {
    $('#field1_2').addClass('rounded_error');
        ans+=1;
  } else {
    $('#field1_2').removeClass('rounded_error');
	}

	if(ans==0)
    doregister();
}

function forgot_pass() {
  if (!checkEmail($('#field2_0').val())) {
    $('#field2_0').addClass('rounded_error');
        return false;
    }
  $('#field2_0').removeClass('rounded_error');
  doforgot();
}

