$(function() {
  console.log('bb')
  $('#register').click(function() {
    $('.pink-box').css('transform', 'translateX(80%)')
    $('.login').addClass('no-display');
    $('.register').removeClass('no-display')
    console.log('aa')
  })

  $('#login').click(function() {
    $('.pink-box').css('transform', 'translateX(0%)')
    $('.register').addClass('no-display')
    $('.login').removeClass('no-display')
    console.log('aa')
  })

  function changeImage() {
    document.getElementById('safeCode').src = 'safeCode?rnd=' + Math.random() * 100
  }
})