window.onload = function () {
  const books2 = JSON.parse(document.getElementById('books2').value);
  alert(books2);
}

document.addEventListener("DOMContentLoaded", function() {
  var ctx = document.getElementById("myChart").getContext('2d');
  var myChart = new Chart(ctx, {
    type: 'line',
    data: {
      labels: ['6日前', '5日前', '4日前', '3日前', '2日前', '昨日', '今日'],
      datasets: [{
        label: "投稿数",
        data: [books2.created_6days.count, books2.created_5days.count, books2.created_4days.count, books2.created_3days.count, books2.created_2days.count , yesterday_book.count , today_book.count],
        backgroundColor: 'rgba(255, 80, 120, 1.0)',
        borderColor: 'rgba(255, 80, 120, 1.0)',
        fill: false
      }]
    },
    options: {
      responsive: true
    }
  });
});
