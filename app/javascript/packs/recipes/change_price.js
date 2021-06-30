$('input[name="recipe[genre]"]').change(function(){
  if ($('input[name="recipe[genre]"]:checked').val() == "主食") {
      $('#price').val(500);
  } else if ($('input[name="recipe[genre]"]:checked').val() == "副食") {
      $('#price').val(350);
  } else if ($('input[name="recipe[genre]"]:checked').val() == "スープ") {
      $('#price').val(200);
  } else if ($('input[name="recipe[genre]"]:checked').val() == "ドレッシング・ソース") {
      $('#price').val(150);
  } else if($('input[name="recipe[genre]"]:checked').val() ==　"デザート") {
      $('#price').val(150);
  };
})
