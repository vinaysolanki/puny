// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function(){

	$("#btn-copy").zclip({
		path:'http://www.steamdev.com/zclip/js/ZeroClipboard.swf',
        copy: function(){
			val = $('#url').val();
			return val;
		}
	});
	
	$('#btn-copy').click(function(){
		$('.copy-msg').css('visibility', 'visible');
		$('.copy-msg').css('opacity', 1);
		$('.copy-msg').animate({'opacity': 0},3000);
	});
	
	if (status == 1){
		
		$('#shorten-status').delay(500).slideDown(900);
	} 
	else if (status == 2){
		$('#shorten-status').css('height',30);
		$('#shorten-msg').css('color','red');
		$('#share-box').hide();
		$('#shorten-status').delay(200).slideDown(400);
		
		
	}
	
	
});