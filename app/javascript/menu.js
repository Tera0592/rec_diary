$(function(){
  $(".user-nickname").hover(function(){
    $(this).children(".my-menu").stop().slideToggle();
  });
});