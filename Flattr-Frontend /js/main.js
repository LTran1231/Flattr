
$(document).on("swiperight", "#imageslider", function(event){
  event.preventDefault();
  console.log('swiped right');
  var img = $('#swiper_image')[0].src
  var like = true;
  addVote(img, like);
  getPhoto();
});

$(document).on("swipeleft", "#imageslider", function(event){
  event.preventDefault();
  console.log('swiped left');
  var img = $('#swiper_image')[0].src
  var like = false;
  addVote(img, like);
  getPhoto();
});

$(document).on("click", "#imageslider", function(event){
  event.preventDefault();
  console.log(event.target);
  var img = $('#swiper_image')[0].src
  var like = true;
  addVote(img, like);
  getPhoto();
});

$(document).on("click", "#dislike", function(event){
  console.log('used button');
  event.preventDefault();
  var img = $('#swiper_image')[0].src
  var like = false;
  addVote(img, like);
  getPhoto();
})

$(document).on("click", "#like", function(event){
  console.log('used button');
  event.preventDefault();
  var img = $('#swiper_image')[0].src
  var like = true;
  addVote(img, like);
  getPhoto();
})

$(document).on("ready", function(){
  sessions.login('#dialog-login');
  sessions.logout('.logout');
  createPhoto();
  app.initialize();
  $(".homefeed-link").on('click', function(event){
    getPhoto();
  })
});


// HOMEFEED
var getPhoto = function(){
  var request = $.ajax({
    url: base + 'user_photos',
    type: 'GET',
    data: authData
  })
  request.done(function(response){
    console.log("getPhoto ran")
    template = Handlebars.compile($("#photo_feed_template").html());
    $('#container').html(template(response));
  })
  request.fail(function(response){
    console.log("ERROR" + response);
  })
}

var addVote = function(photo, like){
  console.log("adding vote");
  console.log(authData);
  var request = $.ajax({
    url: base + 'votes',
    type: 'POST',
    data: {user: authData, photo: photo, like: like},
    dataType: 'JSON'
  })
}

var authData;

var sessions = (function(){
  base = "https://flattrr.herokuapp.com/"
  var myFirebaseRef = new Firebase("https://flattr.firebaseio.com/");

var login = (function(target) {
  $(target).on('click', 'a.btn-social', function(event) {
    event.preventDefault();

    var $currentButton = $(event.target);
    var provider = $currentButton.data('provider');
    var getName = function(authData) {
      switch(authData.provider){
        case 'facebook':
        return authData.facebook.displayName;
        case 'google':
        return authData.google.displayName;
      }
    }

    myFirebaseRef.authWithOAuthPopup(provider, function(err, userData) {
      if (err)
        console.log("Login Failed", err);
      else
        authData = userData;
      myFirebaseRef.child("users").child(userData.uid).set({
        provider: authData.provider,
        name: getName(authData)
      })
      var url = base;
      $.post(url+provider, { user: authData }).done(function(data){
        authData = data.user;
        userPhotos = data.photos;
        console.log(userPhotos);
        window.location.href = '#homefeed';
        $('.myUserId').val(authData.id);
        setProfile();
        showResultData();
        getPhoto();
      })

    })
  })
});

var logout = (function (target){
  $(target).on('click', function (event) {
    event.preventDefault();
    myFirebaseRef.unauth();
    window.location.href = '#main-login-page';
  })
})

return {
  login: login,
  logout: logout
}

})();

var setProfile = (function(){
  url = base + "users/" + authData.id;
  $.get(url).done(function(currentUser){
    $('.user_avatar').attr('src', currentUser.avatar);
    $('.user_name').text(currentUser.first_name + " " + currentUser.last_name);
    $('.user_gender').text(currentUser.gender);
    if (currentUser.age !== null)
      $('.user_age').text(currentUser.age);

  })
})

// <-------------SHOW------------------------------------


var showResultData = function(){
  console.log(userPhotos);
  var photosTemplate = Handlebars.compile($('.photos-template').html());
  $('.photos-area').append(photosTemplate({photos: userPhotos}));

  var url = base + "photos/7"
  $.ajax({
    url: url,
    type: 'get',
  }).done(function(response) {
    $('.rating_saying').append(response.rating_saying);
  });
};


var createPhoto = function(){
  $('.upload-photo-btn').on('click', function(event){
    event.preventDefault();

    var userID = $('.myUserId').val();
    var imageData = $('.myImageData').val();

    var request = $.ajax({
      url: 'https://flattrr.herokuapp.com/photos',
      type: "POST",
      dataType: "json",
      data: {photo: {user_id: userID, photo_url: imageData, vote_count: 2}}
    })
    request.done(function(response){
      console.log('success' + response);
      $('.photos-area').prepend(response);
      window.location.href = '#profile';
    })
    request.fail(function(response){
      console.log('fail', response);
    })
  })
}


var app = {
  initialize: function() {
    this.bindEvents();
  },
  bindEvents: function() {
    document.addEventListener('deviceready', this.onDeviceReady, false);
    document.addEventListener('deviceready', this.createPhoto, false);
  },
  onDeviceReady: function() {
    // Camera plugin
    var myButton = document.querySelector('.take-photo-btn');
    myButton.addEventListener('click', openCamera);

    function openCamera() {
      navigator.camera.getPicture(onSuccess, onFail, { quality: 50,
        destinationType: Camera.DestinationType.DATA_URL});
    }

    function onSuccess(imageData) {
      var displayMyImage = document.querySelector('.displayMyImage');
      var myImageData = document.querySelector('.myImageData');
      displayMyImage.src = "data:image/jpeg;base64," + imageData;
      myImageData.value = "data:image/jpeg;base64," + imageData;
    }

    function onFail(message) {
      alert('Failed because: ' + message);
    }
  }
}
