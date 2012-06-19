/* Foundation v2.2 http://foundation.zurb.com */

jQuery.ajaxSetup( { 
		'beforeSend': function( xhr ) {
	  		xhr.setRequestHeader( 'Accept', 'text/javascript' );
	  		xhr.setRequestHeader( 'X-CSRF-Token', $( 'meta[name=csrf-token]' ).attr( 'content' ) );
	   },
	   	'complete': function() {
	   		//$('#loader').remove();
	   	}
} );
	
jQuery(document).ready(function ($) {
	var route_browse_jobs = '/opportunities/industry/'
	//alert('Test');
	/* Use this js doc for all application specific JS */

	/* TABS --------------------------------- */
	/* Remove if you don't need :) */

	function activateTab($tab) {
		var $activeTab = $tab.closest('dl').find('a.active'),
				contentLocation = $tab.attr("href") + 'Tab';

		//Make Tab Active
		$activeTab.removeClass('active');
		$tab.addClass('active');

    	//Show Tab Content
		$(contentLocation).closest('.tabs-content').children('li').hide();
		$(contentLocation).css('display', 'block');
	}

	$('dl.tabs').each(function () {
		//Get all tabs
		var tabs = $(this).children('dd').children('a');
		tabs.click(function (e) {
			activateTab($(this));
		});
	});

	if (window.location.hash) {
		activateTab($('a[href="' + window.location.hash + '"]'));
	}

	/* ALERT BOXES ------------ */
	$(".alert-box").delegate("a.close", "click", function(event) {
    event.preventDefault();
	  $(this).closest(".alert-box").fadeOut(function(event){
	    $(this).remove();
	  });
	});


	/* PLACEHOLDER FOR FORMS ------------- */
	/* Remove this and jquery.placeholder.min.js if you don't need :) */

	$('input, textarea').placeholder();

	/* TOOLTIPS ------------ */
	$(this).tooltips();



	/* UNCOMMENT THE LINE YOU WANT BELOW IF YOU WANT IE6/7/8 SUPPORT AND ARE USING .block-grids */
//	$('.block-grid.two-up>li:nth-child(2n+1)').css({clear: 'left'});
//	$('.block-grid.three-up>li:nth-child(3n+1)').css({clear: 'left'});
//	$('.block-grid.four-up>li:nth-child(4n+1)').css({clear: 'left'});
//	$('.block-grid.five-up>li:nth-child(5n+1)').css({clear: 'left'});



	/* DROPDOWN NAV ------------- */

	var lockNavBar = false;
	$('.nav-bar a.flyout-toggle').live('click', function(e) {
		e.preventDefault();
		var flyout = $(this).siblings('.flyout');
		if (lockNavBar === false) {
			$('.nav-bar .flyout').not(flyout).slideUp(500);
			flyout.slideToggle(500, function(){
				lockNavBar = false;
			});
		}
		lockNavBar = true;
	});
  if (Modernizr.touch) {
    $('.nav-bar>li.has-flyout>a.main').css({
      'padding-right' : '75px'
    });
    $('.nav-bar>li.has-flyout>a.flyout-toggle').css({
      'border-left' : '1px dashed #eee'
    });
  } else {
    $('.nav-bar>li.has-flyout').hover(function() {
      $(this).children('.flyout').show();
    }, function() {
      $(this).children('.flyout').hide();
    })
  }
  
	// $( '.sidebar_links li a' ).click(function(){
  		// e.preventDefault();
		// alert('Test');
	// });

	// $('.industry_links li a').live('click', function (e) {
		// e.preventDefault()
		// var industry_id = $(this).attr('id')
		// $(this).addClass("selected")
		// window.open = route_browse_jobs  + industry_id
// 		
	// });
	
	
	// $('#apply_job').click(function(){
		// //alert('Test');
		// $('#modalApply').remove();
		// var content = $( '<div id="modalApply" class="reveal-modal">' +
									// '<h2>Awesome. I have it.</h2>' +
									// '<p class="lead">Your couch.  I it\'s mine.</p>' +
									// '<p>Im a cool paragraph that lives inside of an even cooler modal. Wins</p>' +
									// '<a class="close-reveal-modal">&#215;</a>' +
									// '</div>' );
		// $( 'body' ).append( content );
		// $(content).reveal();
// 		
	// })
	
	
	// function build_application_modal() {
    	// var content = $( '<div id="modalApply" class="reveal-modal">' +
									// '<h2>Awesome. I have it.</h2>' +
									// '<p class="lead">Your couch.  I it\'s mine.</p>' +
									// '<p>Im a cool paragraph that lives inside of an even cooler modal. Wins</p>' +
									// '<a class="close-reveal-modal">&#215;</a>' +
									// '</div>' );
		// $(content).reveal();
// 		
	// }
	
	// $('.industry_links li a').live('click',function(e){
		// e.preventDefault();
		// var parent = $('.industry_links');
		// //var container_cols = $('.executiveFeatures');
		// $(parent).find('a').removeClass('selected');
		// $(this).addClass('selected'); 
		// var post_container = $('.jobposts_container .post_data')
		// var curr_route = $(this).attr('href');
		// var industry_id = $(this).attr('id');
		// post_container.empty();
// 		
		// $.get(curr_route);
		// $('.executiveFeatures > article').removeClass('job_post');
		// $('.executiveFeatures > article').addClass('posts');
		// //alert(industry_id);
// 		
	 	// // $.get(curr_route , function( data ) {
			// // var items = [];
			// // $.each(data, function(key, post) {
				// // post_container.append( build_post_row(post) );
			    // // // items.push('<li id="' + key + '">' + val + '</li>');
// // 			    
		  	// // });
		// // });
	// });
	
	// $('.pagination a').live('click',function(e){
		// e.preventDefault();
		// var parent = $('.industry_links');
		// $(parent).find('a').removeClass('selected');
		// $(this).addClass('selected'); 
		// var post_container = $('.jobposts_container .post_data')
		// var curr_route = $(this).attr('href');
			// if( $(parent).find('a').hasClass('selected') == true ){
				// curr_industry = $(parent).find('a').hasClass('selected'); 
				// var industry_id = $(curr_industry).attr('id');
				// curr_route = $(this).attr('href') + '&industry_id=' + industry_id 
			// }
		// $(post_container).empty();
	 	// $.get(curr_route);
	// });
	
	
	$('.post_control #customDropdown').live('change', function(){
		industry = $('.industry_links');
		sort_val = $(this).val();
		//alert(sort_val);
		var industry_id = '';
		var post_container = $('.jobposts_container .post_data')
		var curr_route = '/opportunities'
		//alert(curr_route);
			if( $(industry).find('a').hasClass('selected') == true ){
				curr_industry = $(industry).find('a').hasClass('selected'); 
				var industry_id = $('input#industry_id').val();
				//alert(industry_id);
				//curr_route = curr_route + '&industry_id=' + industry_id 
			}
		//$(post_container).empty();
		$.get(curr_route, { sortby: sort_val, industry_id:industry_id, page:1 } , function( data ) {
			var items = [];
			$.each(data, function(key, post) {
				post_container.append( build_post_row(post) );
			    // items.push('<li id="' + key + '">' + val + '</li>');
			    
		  	});
		});
		// $.get(curr_route, { sortby: sort_val, industry_id:industry_id } );
		// $(this).attr("selected","selected");
	});
	
	function build_post_row(post) {
		if(post.description.length > 110){
			var post_description = jQuery.trim(post.description).substring(0, 110).split(" ").slice(0, -1).join(" ") + "...";
		}else{
			var post_description = post.description;
		}
		
		var row = '<div class="job_post">' +
			'<p class="header"><a href="/opportunities/show/'+ post.id+'">' + post.position + '</a></p>' +
			'<div class="description">' + post_description + '</div>' +
			'<table><tbody><tr>' +
				'<td style="width:230px;"><strong>Location:&nbsp;</strong>&nbsp;' + post.location + '</td>' +
				'<td style="width:100px;"><strong>Date:&nbsp;</strong>&nbsp;' + post.date_posted + '</td>' +
				'<td><strong>Salary:&nbsp;</strong>' + post.salary1 + '&nbsp;<span class="salary2"></span> HKD / ANNUM</td>' +
			'<table><tbody><tr>' +
			'<p class="classification"><strong>Classification:</strong> <span>'+ post.classification +'</p>'
				
			if(post.salary2 != null || post.salary2 != ''){
				$('.job_post table td span.salary2').html('&ndash;&nbsp;' + post.salary2 )
			}	
		return row
	}
	
	
	/* DISABLED BUTTONS ------------- */
	/* Gives elements with a class of 'disabled' a return: false; */
  

});
