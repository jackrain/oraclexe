jQuery(document).ready(function(){
//加法
//说明：javascript的加法结果会有误差，在两个浮点数相加的时候会比较明显。这个函数返回较为精确的加法结果。
//调用：accAdd(arg1,arg2)
//返回值：arg1加上arg2的精确结果
function accAdd(arg1,arg2){
    var r1,r2,m;
   	r1=arg1.toString().split(".");
    if(r1[1]){
    	r1=r1[1].length;
    }else{
    	r1=0;
    }
    r2=arg2.toString().split(".")
    if(r2[1]){
    	r2=r2[1].length;
    }else{
    	r2=0;
    }
    m=Math.pow(10,Math.max(r1,r2));
    return (arg1*m+arg2*m)/m
}

//给Number类型增加一个add方法，调用起来更加方便。
Number.prototype.add = function (arg){
    return accAdd(arg,this);
}
//减法
//说明：javascript的减法结果会有误差，在两个浮点数相加的时候会比较明显。这个函数返回较为精确的减法结果。
//调用：accSub(arg1,arg2)
//返回值：arg1减上arg2的精确结果
function accSub(arg1,arg2){    
    return accAdd(arg1,-arg2);
}

//给Number类型增加一个sub方法，调用起来更加方便。
Number.prototype.sub = function (arg){
    return accSub(this,arg);
} 

//乘法
//说明：javascript的乘法结果会有误差，在两个浮点数相乘的时候会比较明显。这个函数返回较为精确的乘法结果。
//调用：accMul(arg1,arg2)
//返回值：arg1乘以arg2的精确结果
function accMul(arg1,arg2)
{
    var m=0,s1=arg1.toString(),s2=arg2.toString();
    if(s1.split(".")[1])m+=s1.split(".")[1].length;
    if(s2.split(".")[1])m+=s2.split(".")[1].length;
    return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m);
}

//给Number类型增加一个mul方法，调用起来更加方便。
Number.prototype.mul = function (arg){
    return accMul(arg, this);
} 

//除法
//说明：javascript的除法结果会有误差，在两个浮点数相除的时候会比较明显。这个函数返回较为精确的除法结果。   
//调用：accDiv(arg1,arg2)   
//返回值：arg1除以arg2的精确结果   
function accDiv(arg1,arg2){   
    var t1=0,t2=0,r1,r2;   
    if(arg1.toString().split(".")[1])t1=arg1.toString().split(".")[1].length;
    if(arg2.toString().split(".")[1])t2=arg2.toString().split(".")[1].length;
    with(Math){   
        r1=Number(arg1.toString().replace(".",""));
        r2=Number(arg2.toString().replace(".",""));  
        return (r1/r2)*pow(10,t2-t1);   
    }   
}   
  
//给Number类型增加一个div方法，调用起来更加方便。   
Number.prototype.div = function (arg){   
		if(arg==0)return 0;
    return accDiv(this, arg);   
}  
});