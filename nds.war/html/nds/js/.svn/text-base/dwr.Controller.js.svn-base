// Provide a default path to dwr.engine
if (dwr == null) var dwr = {};
if (dwr.engine == null) dwr.engine = {};
if (DWREngine == null) var DWREngine = dwr.engine;
if (Controller == null) var Controller = {};
Controller._path = '/servlets/dwr';
Controller.handle = function(p0, callback) {
  dwr.engine._execute(Controller._path, 'Controller', 'handle', p0, 
   		{	timeout:3000*1000,
			timeoutFunc:function(batch){
				if(batch && !batch.completed){
					var e=	$("timeoutBox");
					if(e!=null)e.style.visibility = 'visible';
				}else{
					if(batch)clearInterval(batch.interval);
				}
			},
			callback:callback
		}
	);
}
Controller.query = function(p0, callback) {
  dwr.engine._execute(Controller._path, 'Controller', 'query', p0, 
  		{	timeout:600*1000,
			timeoutFunc:function(batch){
				if(batch && !batch.completed){
					var e=	$("timeoutBox");
					if(e!=null)e.style.visibility = 'visible';
				}else{
					if(batch)clearInterval(batch.interval);
				}
			},
			callback:callback
		}
	);
}