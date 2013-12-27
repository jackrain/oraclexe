var ztools=null;
var ZTOOLS=Class.create();
ZTOOLS.prototype={
    initialize:function(){
        
    },
    /*
    * 合并数组中重复的元素
    * arr:目标数组、
    * return 合并后的集合 */
    mergeArr:function(arr){
       var len=arr.length;
       for(var i=0;i<len;i++){
           if(i<arr.length-1){
               arr=this._removeSameEle(arr,i);
           }
       }
        return arr;
    },
    /*删除指定下标元素右边相同的元素
    * arr:目标数组
    * num:指定的下标*/
    _removeSameEle:function(arr,num){
        var reArr=new Array();
        for(var i=0;i<arr.length;i++){
            if(i>num&&arr[i]==arr[num]){
                reArr.push(i);
            }
        }
        for(var j=0;j<reArr.length;j++){
            arr=arr.slice(0,reArr[j]-j).concat(arr.slice(reArr[j]-j+1));
        }
        return arr;
    },
    /*根据json对象数组中的某一项排序
    * 排序规则为js的sort的方法
    * data:json对象
    * item:json对象的某个明细名，必须能够使用sort的方法如数字型或字符型
    * level:item有几层，最多支持2层，默认1层
    * 返回:排序后的json*/
    sortJSON:function(data,item,level){
        var itemArr=new Array();
        var newData=new Array();
        var itemr=item.split(".");
        for(var i=0;i<data.length;i++){
            itemArr.push(level==2?data[i][itemr[0]][itemr[1]]:data[i][item]);
        }
        itemArr=itemArr.sort(function(a,b){
            var v1=parseInt(a,10);
            var v2=parseInt(b,10);
            if(isNaN(v1)||isNaN(v2)){
                return -1;
            }else{
                return v1-v2;
            }
        });
        for(var j=0;j<itemArr.length;j++){
            if(j==0||itemArr[j]!=itemArr[j-1]){
                for(var s=0;s<data.length;s++){
                    if((level==2?data[s][itemr[0]][itemr[1]]:data[s][item])==itemArr[j]){
                        newData.push(data[s])
                    }
                }
            }
        }
        return newData;
    }
}
ZTOOLS.main=function(){
    ztools=new ZTOOLS();
};
jQuery(document).ready(ZTOOLS.main);