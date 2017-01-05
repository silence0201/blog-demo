window.backgroundColor(0xeeddee)
local scrW, scrH = System.screenSize()

loading = LoadingIndicator()

btnH = scrH/10

btn1 = Button()
btn1.text("Start")
btn1.frame(0, btnH*1, scrW, btnH)
btn1.backgroundColor(0xcccccc)
btn1.callback(
	function ()
		loading.start()
	end
)


btn2 = Button()
btn2.text("Stop")
btn2.frame(0, btnH*2.5, scrW, btnH)
btn2.backgroundColor(0xcccccc)
btn2.callback(
	function ()
		loading.stop()
	end
)

index = 0
btn3 = Button()
btn3.text("Change Color")
btn3.frame(0, btnH*4, scrW, btnH)
btn3.backgroundColor(0xcccccc)
btn3.callback(
function ()
	if (index%2 == 0) then
		loading.color(0xff0000)
	else
		loading.color(0xff00)
	end
	index = index + 1
	end
)

loading.size(30, 30)
loading.center(scrW/2, btnH*6)
