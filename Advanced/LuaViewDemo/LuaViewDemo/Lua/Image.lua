scrW, scrH = System.screenSize();
window.backgroundColor(0x777777,1);

w  = scrW/3;
X0 = scrW/10;
Y0 = scrH/5;


imageView = Image();
imageView.frame(X0, Y0, w, w);
imageView.backgroundColor(0xff0000,1);
names = {};

for i=1,16 do
	names[i] = "img" .. i .. ".tiff"
end

imageView.image("img16.tiff");
imageView.startAnimationImages( names, 3.0, 1000);

label = Label();

imageView2 = Image();
imageView2.frame(X0+w+X0, Y0, w, w);
imageView2.image("http://g.alicdn.com/ju/lua/2.0.24/doc/icon.png",
	function(info)
		print("图片加载成功!", info);
		label.text("图片加载成功!" )
		label.adjustSize();
		label.center(scrW/2,scrH/2);
	end
)
label.backgroundColor(0xFF);



closeButton = Button();
closeButton.title("关闭");
closeButton.frame(125,10,100,50);
closeButton.backgroundColor(0x00a4ff)
closeButton.callback(
	function ()
		window.release();
	end
);

view3 = Image()
view3.frame(scrW/2-50, 350, 100, 100)
view3.image("http://gw.alicdn.com/tps/TB1qMx0KFXXXXXSXXXXXXXXXXXX-1065-765.png")
view3.cornerRadius(20)
view3.borderColor(0xff0000)
view3.borderWidth(4)
view3.borderDash(5, 5)
