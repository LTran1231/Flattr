
$(document).ready(function () {
	var photosTemplate = Handlebars.compile($('.photos-template').html());
	var url = base + "photos/"
	$ajax({
		url: url,
		type: 'get',
	}).done(function  (response) {
		$('.photos-template').append(photosTemplate(photo: response))
	});
});

// <div class"media photos-template"></div>
// <script type='text/x-handlebars-template' class='photos-template'>
// {{#each photo}}
// </li><a data-rel="popup" data-position-to="window" data-transition="pop" data-inline="true" href="#{{photo.id}}">
// <img class="media-object" height="64" width="64" src="{{photo.photo_url}}"/>
// </a></li>
// {{/each}}
// </script>


<div class="media photos">
<div class="media-left">
<!-- <a class="foto-posted" data-rel="popup" data-position-to="window" data-transition="pop" data-inline="true">
<img class="media-object" height="64" width="64"/>
</a> -->
</div>
<!-- <div class="media-body">
<div class="media-heading" id="rating_saying"></div>
<div class="result_left"></div>
<div class="result_right"></div>
</div> -->
</div>