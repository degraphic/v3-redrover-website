$(function() {

  // header
  $('.btn-email').click(function(){
    $('.signup-form').toggle();
  });

  // filter controls
  $('.additional p').click(function(){
    $('.bottom_controls').slideToggle(200, function(){
      if ($(this).hasClass('active')){
        $('p .caret').removeClass('up').addClass('down');
      }
      else {
        $(this).addClass('active');
        $('p .caret').removeClass('down').addClass('up');
      }
    });
  });

  // settings
  $('.toggle-button.normal').toggleButtons();
  $('.toggle-button.gender').toggleButtons({
    width: 220,
    label: {
      enabled: "Male",
      disabled: "Female"
    }
  });

  // follow buttons
  $('.btn-follow.follow, .btn-follow.following').click(function(e){
    e.preventDefault();
    $(this).toggleClass('following');
  });

  $('.follow_view .btn-accept').click(function() {
    if($(this).hasClass('decline')){
      $(this).parents('.span10').fadeOut(200);
    }
    else {
      $(this).hide();
      $(this).siblings('.decline').hide();
      $(this).siblings('.btn-follow').show();
    }
  });  

  $('.requests .btn-follow').click(function() {
    $(this).parents('.span10').fadeOut(200);
  });

  // follow the fun buttons 
  $('.btn-icomoon').click(function(){
    if($(this).hasClass('followed')){
      $(this).removeClass('followed');
      $(this).html("<span class='icomoon-star'></span> Follow");
    }
    else{
      $(this).addClass('followed');
      $(this).html("<span class='icomoon-star'></span> Followed");
    }
  });

});

