  $("#purchase").click(function(){
    if (confirm('このレシピを購入してもよろしいですか？')) {
      return true;
    }else{
      return false;
    }
  })
