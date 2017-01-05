viewController.externalApiDemo_number("dongxicheng",123);

button = Button();
button.frame(150,30,100,50);
button.title("跳转")
button.backgroundColor(0x00a4ff)
button.callback(
	function()
		print("页面跳转");
		if( viewController.pushToOthers ) then
			viewController.pushToOthers();
		else
			print("viewController.externalApiDemo not exist !!!");
		end
	end
)
