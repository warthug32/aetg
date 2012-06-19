$(function () {

	// Notification Close Button
	$('.close-notification').click(
		function () {
			$(this).parent().fadeTo(350, 0, function () {$(this).slideUp(600);});
			return false;
		}
	);

	// jQuery Tipsy
	$('[rel=tooltip], #main-nav span, .loader').tipsy({gravity:'s', fade:true}); // Tooltip Gravity Orientation: n | w | e | s

	// jQuery Facebox Modal
	$('a[rel*=modal]').facebox();

	// jQuery jWYSIWYG Editor
	$('.wysiwyg').wysiwyg({ iFrameClass:'wysiwyg-iframe' });
	
	// jQuery dataTables
	$('.datatable').dataTable();

	// jQuery Custome File Input
	$('.fileupload').customFileInput();

	// jQuery DateInput
	$('.datepicker').datepick({ pickerClass: 'jq-datepicker' });

	// Check all checkboxes
	$('.check-all').click(
		function(){
			$(this).parents('form').find('input:checkbox').attr('checked', $(this).is(':checked'));
		}
	)

	// IE7 doesn't support :disabled
	$('.ie7').find(':disabled').addClass('disabled');

	// Menu Dropdown
	$('#main-nav li ul').hide(); //Hide all sub menus
	$('#main-nav li.current a').parent().find('ul').slideToggle('slow'); // Slide down the current sub menu
	$('#main-nav li a').click(
		function () {
			$(this).parent().siblings().find('ul').slideUp('normal'); // Slide up all menus except the one clicked
			$(this).parent().find('ul').slideToggle('normal'); // Slide down the clicked sub menu
			return false;
		}
	);
	$('#main-nav li a.no-submenu, #main-nav li li a').click(
		function () {
			window.location.href=(this.href); // Open link instead of a sub menu
			return false;
		}
	);

	// Widget Close Button
	$('.close-widget').click(
		function () {
			$(this).parent().fadeTo(350, 0, function () {$(this).slideUp(600);}); // Hide widgets
			return false;
		}
	);

	// Table actions
	$('.table-actions ul').hide(); // Hide all table action menu
	$('.table-actions > a').click(
		function () {
			$(this).parent().parent().parent().siblings().find('.table-actions > a').removeClass('active').next().slideUp(); // Hide all menus expect the one clicked
			$(this).toggleClass('active').next().slideToggle(); // Toggle clicked menu
			$(document).click(function() { // Hide menu when clicked outside of it
				$('.table-actions ul').slideUp();
				$('.table-actions > a').removeClass('active')
			});
			return false;
		}
	);

	// Image actions
	$('.image-frame').hover(
		function() { $(this).find('.image-actions').css('display', 'none').fadeIn('fast').css('display', 'block'); }, // Show actions menu
		function() { $(this).find('.image-actions').fadeOut(100); } // Hide actions menu
	);

// Content box tabs and sidetabs
	$('.tab, .sidetab').hide(); // Hide the content divs
	$('.default-tab, .default-sidetab').show(); // Show the div with class 'default-tab'
	$('.tab-switch a.default-tab, .sidetab-switch a.default-sidetab').addClass('current'); // Set the class of the default tab link to 'current'

	if (window.location.hash && window.location.hash.match(/^#tab\d+$/)) {
		var tabID = window.location.hash;
		
		$('.tab-switch a[href='+tabID+']').addClass('current').parent().siblings().find('a').removeClass('current');
		$('div'+tabID).parent().find('.tab').hide();
		$('div'+tabID).show();
	} else if (window.location.hash && window.location.hash.match(/^#sidetab\d+$/)) {
		var sidetabID = window.location.hash;
		
		$('.sidetab-switch a[href='+sidetabID+']').addClass('current');
		$('div'+sidetabID).parent().find('.sidetab').hide();
		$('div'+sidetabID).show();
	}
	
	$('.tab-switch a').click(
		function() { 
			var tab = $(this).attr('href'); // Set variable 'tab' to the value of href of clicked tab
			$(this).parent().siblings().find('a').removeClass('current'); // Remove 'current' class from all tabs
			$(this).addClass('current'); // Add class 'current' to clicked tab
			$(tab).siblings('.tab').hide(); // Hide all content divs
			$(tab).show(); // Show the content div with the id equal to the id of clicked tab
			$(tab).find('.data').trigger('visualizeRefresh');; // Refresh jQuery Visualize
			$('.fullcalendar').fullCalendar('render'); // Refresh jQuery FullCalendar
			return false;
		}
	);

	$('.sidetab-switch a').click(
		function() { 
			var sidetab = $(this).attr('href'); // Set variable 'sidetab' to the value of href of clicked sidetab
			$(this).parent().siblings().find('a').removeClass('current'); // Remove 'current' class from all sidetabs
			$(this).addClass('current'); // Add class 'current' to clicked sidetab
			$(sidetab).siblings('.sidetab').hide(); // Hide all content divs
			$(sidetab).show(); // Show the content div with the id equal to the id of clicked tab
			$(sidetab).find('.data').trigger('visualizeRefresh');; // Refresh jQuery Visualize
			$('.fullcalendar').fullCalendar('render'); // Refresh jQuery FullCalendar
			
			return false;
		}
	);
	
	// Content box accordions
	$('.accordion li div').hide();
	$('.accordion li:first-child div').show();
	$('.accordion .accordion-switch').click(
		function() {
			$(this).parent().siblings().find('div').slideUp();
			$(this).next().slideToggle();
			return false;
		}
	);
	
	//Minimize Content Article
	$('article header h2').css({ 'cursor':'s-resize' }); // Minizmie is not available without javascript, so we don't change cursor style with CSS
	$('article header h2').click( // Toggle the Box Content
		function () {
			$(this).parent().find('nav').toggle();
			$(this).parent().parent().find('section, footer').toggle();
		}
	);
	
	//jQuery Full Calendar
	var date = new Date();
	var d = date.getDate();
	var m = date.getMonth();
	var y = date.getFullYear();
	
	$('.fullcalendar').fullCalendar({
		header: {
			left: 'prev,next today',
			center: 'title',
			right: 'month,basicWeek,basicDay'
		},
		editable: true,
		events: [
			{
				title: 'All Day Event',
				start: new Date(y, m, 1)
			},
			{
				title: 'Long Event',
				start: new Date(y, m, d-5),
				end: new Date(y, m, d-2)
			},
			{
				id: 999,
				title: 'Repeating Event',
				start: new Date(y, m, d-3, 16, 0),
				allDay: false
			},
			{
				id: 999,
				title: 'Repeating Event',
				start: new Date(y, m, d+4, 16, 0),
				allDay: false
			},
			{
				title: 'Meeting',
				start: new Date(y, m, d, 10, 30),
				allDay: false
			},
			{
				title: 'Lunch',
				start: new Date(y, m, d, 12, 0),
				end: new Date(y, m, d, 14, 0),
				allDay: false
			},
			{
				title: 'Birthday Party',
				start: new Date(y, m, d+1, 19, 0),
				end: new Date(y, m, d+1, 22, 30),
				allDay: false
			},
			{
				title: 'Click for Parallaq',
				start: new Date(y, m, 28),
				end: new Date(y, m, 29),
				url: 'http://www.parallaq.com/'
			}
		]
	});
	
	// jQuery Data Visualize
	// Options: 'bar', 'area', 'pie', 'line'
	$('.data').hide();
	$('table.sample-graph').each(function() {
		var chartWidth = $(this).parent().width()*0.90;
		var chartType = '';
			
		if ($(this).attr('data-chart')) { 
			chartType = $(this).attr('data-chart');
		} else  {
			chartType = 'area'; 
		}
		
		$(this).visualize({
			type: chartType,
			width: chartWidth,
			height: '240px'
		});
	});
});