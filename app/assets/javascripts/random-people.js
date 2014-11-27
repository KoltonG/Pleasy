$( document ).ready(function() {
    
  $.ajax({
    url: 'http://api.randomuser.me/',
    dataType: 'json',
    success: function(data){
      $('#picture').attr('src', data.results[0].user.picture.thumbnail);
      $('#name').html(data.results[0].user.name.first + ' ' + data.results[0].user.name.last);
    }
  });
  
  });