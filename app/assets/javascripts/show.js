// 完了ボタンを表示 start
// 完了ボタンが表示する
function showDoneButton(idName) {
    document.getElementById(idName).style.display = 'block';
  }
  
  // 内容が変更されると完了ボタンが表示
  document.getElementById('task_content').onchange = function() {
    showDoneButton('tasks-form-button')
  }
  
  // タイトルが変更されると完了ボタンが表示
  document.getElementById('task_title').onchange = function() {
    showDoneButton('tasks-form-button')
  }
  
  // 期限が変更されると完了ボタンが表示
  document.getElementById('task_deadline').onchange = function() {
    showDoneButton('tasks-form-button')
  }
  
  // 優先順位が変更されると完了ボタンが表示
  document.getElementById('task_priority').onchange = function() {
    showDoneButton('tasks-form-button')
  }
  
  // ステータスが変更されると完了ボタンが表示
  document.getElementById('task_status').onchange = function() {
    showDoneButton('tasks-form-button')
  }
  // 完了ボタンを表示 end
