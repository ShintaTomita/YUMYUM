$(function() {
  $(".menu li").hover(
    function() {
      //クラス名「open」を付与する
      $(this).children(".menuSub").addClass("open");
      //hoverが外れた場合
    }, function() {
      //クラス名「open」を取り除く
      $(this).children(".menuSub").removeClass("open");
    }
  );
});

$(function() {
  $(".genre li").hover(
    function() {
      //クラス名「open」を付与する
      $(this).children(".genreSub").addClass("open");
      //hoverが外れた場合
    }, function() {
      //クラス名「open」を取り除く
      $(this).children(".genreSub").removeClass("open");
    }
  );
});
