window.onload = function () {
    //获取当前日期 时间
    function todayTime() {
        let date = new Date();
        let curYear = date.getFullYear();
        let curMonth = date.getMonth() + 1;
        let curDate = date.getDate();
        let curHours = date.getHours();
        let curMinutes = date.getMinutes();
        let curSeconds = date.getSeconds();
        if(curMonth<10){
            curMonth = '0' + curMonth;
        }
        if(curDate<10){
            curDate = '0' + curDate;
        }
        // if(curHours<10){
        //     curHours = '0' + curHours;
        // }
        if(curMinutes<10){
            curMinutes = '0' + curMinutes;
        }
        if(curSeconds<10){
            curSeconds = '0' + curSeconds;
        }
        let week = "星期" + "日一二三四五六".charAt(new Date().getDay())
        return curYear + '年' + curMonth + '月' + curDate + '日 ' + curHours + ':' + curMinutes + ':' + curSeconds + ' ' + week;
    }

    setInterval(function () {
        msg.innerHTML = '现在是：' + todayTime()
    }, 1000)
}