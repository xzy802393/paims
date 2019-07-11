function returnFloat(value){
    var value=Math.round(parseFloat(value)*100)/100;
    var s=value.toString().split(".");
    if(s.length==1){
        value=value.toString()+".00";
        return value;
    }
    if(s.length>1){
        if(s[1].length<2){
            value=value.toString()+"0";
        }
        return value;
    }
}
function commafy(num) {
    return num && num
        .toString()
        .replace(/(\d)(?=(\d{3})+\.)/g, function ($1, $2) {
            return $2 + ',';
        });
}