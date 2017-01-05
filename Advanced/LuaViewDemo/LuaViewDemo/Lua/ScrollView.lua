local  scrW,scrH = System.screenSize()

scrollView = HScrollView()

buttons = {}
scrollView.frame(0,scrH/5,scrW,scrH/5)
scrollView.contentSize(scrW*3,scrH/5)
for i = 1,10 do
	local button = Button()
	button.frame((i-1)*scrW,0,scrW,scrH/5)
	button.title("按钮"..i)
    button.backgroundColor(0x00a4ff)
	scrollView.addView(button)
	buttons[i] = button
end
scrollView.backgroundColor(0xff0000)

scrollView.callback{
	Scrolling = function(){
		print("scrolling")
	},
	ScrollBegin = function(){
		print("scroll begin")
	},
	ScrollEnd = function (){
		print("scroll end")
	}
}
