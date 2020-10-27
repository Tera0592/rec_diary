$(document).ready(function(){
  $("#user").on("click",function(){
    if ($('#menu').css('display') == 'none') {
      $("#menu").css("display", "block")
      return false;
      // 表示されている場合の処理
  } else {
      $("#menu").css("display", "none")
      return false;  
      // 非表示の場合の処理
  }
  });
});
