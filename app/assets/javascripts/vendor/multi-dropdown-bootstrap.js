$(function(){
  $.startMultiDropdown = function(){
    $(".dropdown-menu .multicheck").on("click" ,function(e) {     
       $(this).toggleClass("checked"); 
       $(this).find("span").toggleClass("icon-ok"); 
    });
  }
})
