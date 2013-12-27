var weather=function(){
	var tmp=0;
	var SWther={w:[{}],add:{}};
	var SWther={};
	this.getWeather=function(city,type){
		//city=utf8ToGBK(city);
		/*
		$.getScript("http://php.weather.sina.com.cn/iframe/index/w_cl.php?code=js&day=2&city="+city+"&dfc=3",function(){if(type=='js'){echo(city);}});
		**/
$.ajax({
dataType:'script',
scriptCharset:'gb2312',////////
url:"http://php.weather.sina.com.cn/iframe/index/w_cl.php?code=js&day=2&city="+city+"&dfc=3",
success:function(){
if(type=='js'){echo(city);}
}
})

		}

function dis_img(weather){
    var style_img="image/s_13.png";
	if(weather.indexOf("多云")!==-1||weather.indexOf("晴")!==-1){style_img="image/s_1.png";}
	else if(weather.indexOf("多云")!==-1&&weather.indexOf("阴")!==-1){style_img="image/s_2.png";}
	else if(weather.indexOf("阴")!==-1&&weather.indexOf("雨")!==-1){style_img="image/s_3.png";}
	else if(weather.indexOf("晴")!==-1&&weather.indexOf("雨")!==-1){style_img="image/s_12.png";}
	else if(weather.indexOf("晴")!==-1&&weather.indexOf("雾")!==-1){style_img="image/s_12.png";}
    else if(weather.indexOf("晴")!==-1){style_img="image/s_13.png";}
	else if(weather.indexOf("多云")!==-1){style_img="image/s_2.png";}
	else if(weather.indexOf("阵雨")!==-1){style_img="image/s_3.png";}
	else if(weather.indexOf("小雨")!==-1){style_img="image/s_3.png";}
	else if(weather.indexOf("中雨")!==-1){style_img="image/s_4.png";}
	else if(weather.indexOf("大雨")!==-1){style_img="image/s_5.png";}
	else if(weather.indexOf("暴雨")!==-1){style_img="image/s_5.png";}
	else if(weather.indexOf("冰雹")!==-1){style_img="image/s_6.png";}
	else if(weather.indexOf("雷阵雨")!==-1){style_img="image/s_7.png";}
	else if(weather.indexOf("小雪")!==-1){style_img="image/s_8.png";}
	else if(weather.indexOf("中雪")!==-1){style_img="image/s_9.png";}
	else if(weather.indexOf("大雪")!==-1){style_img="image/s_10.png";}
	else if(weather.indexOf("暴雪")!==-1){style_img="image/s_10.png";}
	else if(weather.indexOf("扬沙")!==-1){style_img="image/s_11.png";}
	else if(weather.indexOf("沙尘")!==-1){style_img="image/s_11.png";}
	else if(weather.indexOf("雾")!==-1){style_img="image/s_12.png";}
	else{style_img="image/s_2.png";}
    return style_img;};
	
function echo(city){
	$('#city').html(city);
	$('#weather').html(window.SWther.w[city][0].s1);
	$('#temperature').html(window.SWther.w[city][0].t1+'&deg;');
	$('#wind').html(window.SWther.w[city][0].p1);
	$('#direction').html(window.SWther.w[city][0].d1);
		
	var T_weather_img=dis_img(window.SWther.w[city][0].s1);
	$('#T_weather_img').html("<img src='"+T_weather_img+"' title='"+window.SWther.w[city][0].s1+"' alt='"+window.SWther.w[city][0].s1+"' /><br><span id=\"T_weather\"></span>");
	//$('#T_temperature').html(window.SWther.w[city][0].t1+'~'+window.SWther.w[city][0].t2+'&deg;');
	$('#T_temperature').html(window.SWther.w[city][0].t1);
$('#T_weather').html(window.SWther.w[city][0].s1);

	$('#T_wind').html(window.SWther.w[city][0].p1);
	$('#T_direction').html(window.SWther.w[city][0].d1);
	$('#M_weather').html(window.SWther.w[city][1].s1);
	
	var M_weather_img=dis_img(window.SWther.w[city][1].s1);
	$('#M_weather_img').html("<img src='"+M_weather_img+"' title='"+window.SWther.w[city][1].s1+"' alt='"+window.SWther.w[city][1].s1+"' />");
	$('#M_temperature').html(window.SWther.w[city][1].t1+'~'+window.SWther.w[city][1].t2+'&deg;');
	$('#M_wind').html(window.SWther.w[city][1].p1);
	$('#M_direction').html(window.SWther.w[city][1].d1);
	$('#L_weather').html(window.SWther.w[city][2].s1);
	
	var L_weather_img=dis_img(window.SWther.w[city][2].s1);
	$('#L_weather_img').html("<img src='"+L_weather_img+"' title='"+window.SWther.w[city][2].s1+"' alt='"+window.SWther.w[city][2].s1+"' />");
	$('#L_temperature').html(window.SWther.w[city][2].t1+'~'+window.SWther.w[city][2].t2+'&deg;');
	$('#L_wind').html(window.SWther.w[city][2].p1);$('#L_direction').html(window.SWther.w[city][2].d1);
	}
	}
	//weather结束了
	function jintian(){
		weather_.getWeather(city,'js');
		};
