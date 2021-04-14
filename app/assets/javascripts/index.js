// モーダル操作 start
// モーダル非表示
function closeModal(idName){
    document.getElementById(idName).style.display = 'none';
  }
  
  function openModal(idName){
    document.getElementById(idName).style.display = 'block';
  }
  
  // フォームのモーダル表示
  document.getElementById('tasks-create').onclick = function() {
    openModal('tasks-form')
  }
  
  // フォームのモーダル非表示
  document.getElementById('form-overlay').onclick = function() {
    closeModal('tasks-form')
  }
  
  // オプションのモーダル表示
  document.getElementById('icon-option').onclick = function() {
    openModal('tasks-option')
  }
  
  // オプションのモーダル非表示
  document.getElementById('option-overlay').onclick = function() {
    closeModal('tasks-option')
  }
  // モーダル操作 end
  
  // 並び替えデータを選択するとボタンが表示
  document.getElementById('sort_data').onchange = function() {
    document.getElementById('tasks-sort-button').style.display = 'initial';
  }
  
  // 期限の初期値を今日にする
  window.onload = function () {
    //今日の日時を表示
    var date = new Date()
    var year = date.getFullYear()
    var month = date.getMonth() + 1
    var day = date.getDate()
  
    var toTwoDigits = function (num, digit) {
      num += ''
      if (num.length < digit) {
        num = '0' + num
      }
      return num
    }
    
    var yyyy = toTwoDigits(year, 4)
    var mm = toTwoDigits(month, 2)
    var dd = toTwoDigits(day, 2)
    var ymd = yyyy + '-' + mm + '-' + dd;
    
    document.getElementById('tasks-form__deadline').value = ymd;
  }
  