$('#destroy').click(function() {
  if (confirm("本当にアカウントを削除してよろしいですか？")) {
    return true;
  }else{
    return false;
  }
});
