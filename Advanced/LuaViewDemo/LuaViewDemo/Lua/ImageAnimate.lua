scrW, scrH = System.screenSize();
window.backgroundColor(0x777777,1);

w = scrW/3;
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
imageView.startAnimation( names, 3.0, 1000);


Animate(3, function(){
    imageView.center(scrW/2,scrH/2);
}, function ()
Animate(3, function(){
    imageView.center(scrW,scrH);
}, function ()
end);
end);


label = Label();

imageView2 = Image();
imageView2.frame(X0+w+X0, Y0, w, w);
imageView2.image("http://g.alicdn.com/ju/lua/2.0.24/doc/icon.png",function(info)
	print("图片加载成功!", info);
	label.text("图片加载成功!" )
	label.adjustSize();
	label.center(scrW/2,scrH/2);
end
)


Animate( 2, 0, 0.3,0, function(){
    imageView2.scale(1.2,1.2);
}, function ()
end)

